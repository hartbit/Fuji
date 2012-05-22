//
//  FUSceneSpec.m
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#include "Prefix.pch"
#import "Fuji.h"
#import "FUVisitor-Internal.h"
#import "FUDirector-Internal.h"
#import "FUScene-Internal.h"
#import "FUSceneObject-Internal.h"
#import "FUTestSupport.h"


static NSString* const FUEntityNilMessage = @"Expected 'entity' to not be nil";
static NSString* const FUEntityNonexistentMessage = @"Can not remove a 'entity=%@' that does not exist";


@interface FUTestScene : FUScene @end


SPEC_BEGIN(FUScene)

describe(@"A scene", ^{
	it(@"is a subclass of FUEntity", ^{
		expect([FUScene class]).to.beSubclassOf([FUEntity class]);
	});
	
	context(@"initialized", ^{
		__block FUScene* scene;
		
		beforeEach(^{
			scene = [FUScene scene];
		});
		
		it(@"is not nil", ^{
			expect(scene).toNot.beNil();
		});
		
		it(@"has it's director property at nil", ^{
			expect([scene director]).to.beNil();
		});
		
		it(@"has it's scene property point to itself", ^{
			expect([scene scene]).to.beIdenticalTo(scene);
		});
		
		it(@"contains no entities", ^{
			expect([scene allEntities]).to.beEmpty();
		});
		
		it(@"has a graphics settings component", ^{
			FUGraphicsSettings* graphicsSettings = [scene componentWithClass:[FUGraphicsSettings class]];
			expect(graphicsSettings).toNot.beNil();
			
			NSArray* components = [scene allComponents];
			expect(components).to.contain(graphicsSettings);
		});
		
		it(@"the graphics property returns the graphics engine component", ^{
			FUGraphicsSettings* graphicsSettings = [scene componentWithClass:[FUGraphicsSettings class]];
			expect([scene graphics]).to.beIdenticalTo(graphicsSettings);
		});
		
		context(@"removing the graphics engine component", ^{
			it(@"has the grapics property to nil", ^{
				FUGraphicsSettings* graphicsSettings = [scene componentWithClass:[FUGraphicsSettings class]];
				[scene removeComponent:graphicsSettings];
				expect([scene graphics]).to.beNil();
			});
		});
		
		context(@"removing a nil entity", ^{
			it(@"throws an exception", ^{
				assertThrows([scene removeEntity:nil], NSInvalidArgumentException, FUEntityNilMessage);
			});
		});
		
		context(@"removing an entity that is not in the scene", ^{
			it(@"throws an exception", ^{
				FUEntity* entity = mock([FUEntity class]);
				assertThrows([scene removeEntity:entity], NSInvalidArgumentException, FUEntityNonexistentMessage, entity);
			});
		});
		
		context(@"set a director on the scene", ^{
			__block FUDirector* director;
			
			beforeEach(^{
				director = mock([FUDirector class]);
				[scene setDirector:director];
			});
			
			context(@"created an entity", ^{
				__block FUEntity* entity1;
				
				beforeEach(^{
					entity1 = [scene createEntity];
				});
				
				it(@"registers the entity and it's transform component", ^{
					[verify(director) didAddSceneObject:entity1];
				});
				
				it(@"returns a valid entity with the scene property set", ^{
					expect(entity1).toNot.beNil();
					expect(entity1).to.beAnInstanceOf([FUEntity class]);
					expect([entity1 scene]).to.beIdenticalTo(scene);
				});
				
				it(@"contains the entity", ^{
					expect([scene allEntities]).to.contain(entity1);
				});
				
				context(@"added another entity", ^{
					__block FUEntity* entity2;
					
					beforeEach(^{
						entity2 = [scene createEntity];
					});
					
					it(@"registers the new entity and it's transform component", ^{
						[verify(director) didAddSceneObject:entity2];
					});
					
					it(@"returns a valid entity with the scene property set", ^{
						expect(entity2).toNot.beNil();
						expect(entity2).to.beAnInstanceOf([FUEntity class]);
						expect([entity2 scene]).to.beIdenticalTo(scene);
					});
					
					it(@"contains both entity", ^{
						NSArray* entities = [scene allEntities];
						expect(entities).to.contain(entity1);
						expect(entities).to.contain(entity2);
					});
					
					context(@"accepting a visitor", ^{
						it(@"makes the visitor visit the scene, it's entities, and their components", ^{
							FUVisitor* visitor = mock([FUVisitor class]);
							[scene acceptVisitor:visitor];
							[verify(visitor) visitSceneObject:scene];
							[verify(visitor) visitSceneObject:[scene graphics]];
							[verify(visitor) visitSceneObject:entity1];
							[verify(visitor) visitSceneObject:[entity1 transform]];
							[verify(visitor) visitSceneObject:entity2];
							[verify(visitor) visitSceneObject:[entity2 transform]];
						});
					});
				});
				
				context(@"removed the entity", ^{
					beforeEach(^{
						[scene removeEntity:entity1];
					});
					
					it(@"unregisters the new entity and it's transform component", ^{
						[verify(director) willRemoveSceneObject:entity1];
					});
					
					it(@"sets the scene property of the entity to nil", ^{
						expect([entity1 scene]).to.beNil();
					});
					
					it(@"contains no entities", ^{
						expect([scene allEntities]).to.beEmpty();
					});
				});
			});
		});
	});
	
	context(@"initialized a test scene with a mock entity", ^{
		__block FUTestScene* scene;
		__block FUEntity* entity;
		
		beforeEach(^{
			scene = [FUTestScene scene];
			entity = [scene createEntity];
		});
		
		it(@"are not nil", ^{
			expect(scene).toNot.beNil();
			expect(entity).toNot.beNil();
		});
		
		context(@"calling the rotation methods", ^{
			it(@"called the rotation methods on it's entity", ^{
				[scene willRotateToInterfaceOrientation:UIInterfaceOrientationPortrait duration:1];
				[verify(entity) willRotateToInterfaceOrientation:UIInterfaceOrientationPortrait duration:1];
				
				[scene willAnimateRotationToInterfaceOrientation:UIInterfaceOrientationPortrait duration:1];
				[verify(entity) willAnimateRotationToInterfaceOrientation:UIInterfaceOrientationPortrait duration:1];
				
				[scene didRotateFromInterfaceOrientation:UIInterfaceOrientationLandscapeLeft];
				[verify(entity) didRotateFromInterfaceOrientation:UIInterfaceOrientationLandscapeLeft];
			});
		});
	});
});

SPEC_END


@implementation FUTestScene
- (FUEntity*)createEntity
{
	FUEntity* mockEntity = mock([FUEntity class]);
	[[self performSelector:@selector(entities)] addObject:mockEntity];
	return mockEntity;
}
@end
