//
//  FUSceneSpec.m
//  Fuji
//
//  Created by Hart David on 24.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#include "Prefix.pch"
#import "Fuji.h"
#import "FUTestScene.h"


SPEC_BEGIN(FUSceneSpec)

describe(@"A scene", ^{
	__block FUScene* scene = nil;
	
	it(@"is a subclass of FUEntity", ^{
		expect([FUScene class]).to.beSubclassOf([FUEntity class]);
	});
	
	context(@"created and initialized", ^{
		beforeEach(^{
			scene = [FUScene new];
		});
		
		it(@"is not nil", ^{
			expect(scene).toNot.beNil();
		});
		
		it(@"has it's director property be nil", ^{
			expect([scene director]).to.beNil();
		});
		
		it(@"has it's scene property point to itself", ^{
			expect([scene scene]).to.beIdenticalTo(scene);
		});
		
		it(@"contains no game objects", ^{
			expect([scene allEntities]).to.beEmpty();
		});
		
		it(@"has a graphics settings component", ^{
			FUGraphicsSettings* graphicsSettings = [scene componentWithClass:[FUGraphicsSettings class]];
			expect(graphicsSettings).toNot.beNil();
			
			NSSet* components = [scene allComponents];
			expect(components).to.haveCountOf(1);
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
		
		context(@"removing a nil game object", ^{
			it(@"throws an exception", ^{
				STAssertThrows([scene removeEntity:nil], nil);
			});
		});
		
		context(@"removing a game object that is not in the scene", ^{
			it(@"throws an exception", ^{
				STAssertThrows([scene removeEntity:mock([FUEntity class])], nil);
			});
		});
		
		context(@"created a game object", ^{
			__block FUEntity* entity1 = nil;
			
			beforeEach(^{
				entity1 = [scene createEntity];
			});
			
			it(@"returns a valid game object with the scene property set", ^{
				expect(entity1).toNot.beNil();
				expect(entity1).to.beAnInstanceOf([FUEntity class]);
				expect([entity1 scene]).to.beIdenticalTo(scene);
			});
			
			it(@"contains the game object", ^{
				NSSet* entitys = [scene allEntities];
				expect(entitys).to.haveCountOf(1);
				expect(entitys).to.contain(entity1);
			});
			
			context(@"added another game object", ^{
				__block FUEntity* entity2 = nil;
				
				beforeEach(^{
					entity2 = [scene createEntity];
				});
				
				it(@"returns a valid game object with the scene property set", ^{
					expect(entity2).toNot.beNil();
					expect(entity2).to.beAnInstanceOf([FUEntity class]);
					expect([entity2 scene]).to.beIdenticalTo(scene);
				});
				
				it(@"contains both game object", ^{
					NSSet* entitys = [scene allEntities];
					expect(entitys).to.haveCountOf(2);
					expect(entitys).to.contain(entity1);
					expect(entitys).to.contain(entity2);
				});
			});
			
			context(@"removed the game object", ^{
				beforeEach(^{
					[scene removeEntity:entity1];
				});
				
				it(@"sets the scene property of the game object to nil", ^{
					expect([entity1 scene]).to.beNil();
				});
				
				it(@"contains no game objects", ^{
					expect([scene allEntities]).to.beEmpty();
				});
			});
		});
	});
	
	context(@"created and initialized a test scene with a mock entity", ^{
		__block FUTestScene* scene = nil;
		__block FUEntity* entity = nil;
		
		beforeEach(^{
			scene = [FUTestScene new];
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
