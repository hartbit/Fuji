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
	
	it(@"is a subclass of FUGameObject", ^{
		expect([FUScene class]).to.beSubclassOf([FUGameObject class]);
	});
	
	context(@"created a scene", ^{
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
			expect([scene allGameObjects]).to.beEmpty();
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
				STAssertThrows([scene removeGameObject:nil], nil);
			});
		});
		
		context(@"removing a game object that is not in the scene", ^{
			it(@"throws an exception", ^{
				STAssertThrows([scene removeGameObject:mock([FUGameObject class])], nil);
			});
		});
		
		context(@"created a game object", ^{
			__block FUGameObject* gameObject1 = nil;
			
			beforeEach(^{
				gameObject1 = [scene createGameObject];
			});
			
			it(@"returns a valid game object with the scene property set", ^{
				expect(gameObject1).toNot.beNil();
				expect(gameObject1).to.beAnInstanceOf([FUGameObject class]);
				expect([gameObject1 scene]).to.beIdenticalTo(scene);
			});
			
			it(@"contains the game object", ^{
				NSSet* gameObjects = [scene allGameObjects];
				expect(gameObjects).to.haveCountOf(1);
				expect(gameObjects).to.contain(gameObject1);
			});
			
			context(@"adding another game object", ^{
				__block FUGameObject* gameObject2 = nil;
				
				beforeEach(^{
					gameObject2 = [scene createGameObject];
				});
				
				it(@"returns a valid game object with the scene property set", ^{
					expect(gameObject2).toNot.beNil();
					expect(gameObject2).to.beAnInstanceOf([FUGameObject class]);
					expect([gameObject2 scene]).to.beIdenticalTo(scene);
				});
				
				it(@"contains both game object", ^{
					NSSet* gameObjects = [scene allGameObjects];
					expect(gameObjects).to.haveCountOf(2);
					expect(gameObjects).to.contain(gameObject1);
					expect(gameObjects).to.contain(gameObject2);
				});
			});
			
			context(@"removing the game object", ^{
				beforeEach(^{
					[scene removeGameObject:gameObject1];
				});
				
				it(@"sets the scene property of the game object to nil", ^{
					expect([gameObject1 scene]).to.beNil();
				});
				
				it(@"contains no game objects", ^{
					expect([scene allGameObjects]).to.beEmpty();
				});
			});
		});
	});
});

SPEC_END
