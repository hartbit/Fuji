//
//  FUSceneSpec.m
//  Fuji
//
//  Created by Hart David on 24.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#include "Prefix.pch"
#import "Fuji.h"


SPEC_BEGIN(FUSceneSpec)

describe(@"A scene", ^{
	__block FUScene* scene = nil;
	
	it(@"is a subclass of FUEntity", ^{
		expect([FUScene class]).to.beSubclassOf([FUEntity class]);
	});
	
	it(@"conforms to the GLKViewControllerDelegate protocol", ^{
		expect([FUScene conformsToProtocol:@protocol(GLKViewControllerDelegate)]).to.beTruthy();
	});
	
	it(@"conforms to the GLKViewDelegate protocol", ^{
		expect([FUScene conformsToProtocol:@protocol(GLKViewDelegate)]).to.beTruthy();
	});
	
	context(@"created and initialized", ^{
		beforeEach(^{
			scene = [FUScene new];
		});
		
		it(@"is not nil", ^{
			expect(scene).toNot.beNil();
		});
		
		it(@"has it's scene property point to itself", ^{
			expect([scene scene]).to.beIdenticalTo(scene);
		});
		
		it(@"contains no game objects", ^{
			expect([scene allEntitys]).to.beEmpty();
		});
		
		it(@"has a graphics engine component", ^{
			FUGraphicsEngine* graphicsEngine = [scene componentWithClass:[FUGraphicsEngine class]];
			expect(graphicsEngine).toNot.beNil();
			
			NSSet* components = [scene allComponents];
			expect(components).to.haveCountOf(1);
			expect(components).to.contain(graphicsEngine);
		});
		
		it(@"the graphics property returns the graphics engine component", ^{
			FUGraphicsEngine* graphicsEngine = [scene componentWithClass:[FUGraphicsEngine class]];
			expect([scene graphics]).to.beIdenticalTo(graphicsEngine);
		});
		
		context(@"removing the graphics engine component", ^{
			it(@"has the grapics property to nil", ^{
				FUGraphicsEngine* graphicsEngine = [scene componentWithClass:[FUGraphicsEngine class]];
				[scene removeComponent:graphicsEngine];
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
				NSSet* entitys = [scene allEntitys];
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
					NSSet* entitys = [scene allEntitys];
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
					expect([scene allEntitys]).to.beEmpty();
				});
			});
		});
	});
});

SPEC_END
