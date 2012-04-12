//
//  FUSceneObject.m
//  Fuji
//
//  Created by Hart David on 24.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#include "Prefix.pch"
#import "Fuji.h"
#import "FUSceneObject-Internal.h"


SPEC_BEGIN(FUSceneObject)

describe(@"A scene", ^{
	it(@"conforms to FUInterfaceRotating", ^{
		expect([[FUSceneObject class] conformsToProtocol:@protocol(FUInterfaceRotating)]).to.beTruthy();
	});
	
	context(@"initialized with init", ^{
		it(@"throws an exception", ^{
			STAssertThrows([FUSceneObject new], nil);
		});
	});
	
	context(@"initialized with a nil scene", ^{
		it(@"throws an exception", ^{
			STAssertThrows((void)[[FUSceneObject alloc] initWithScene:nil], nil);
		});
	});
	
	context(@"initialized with a scene", ^{
		__block FUDirector* director;
		__block FUScene* scene;
		__block FUSceneObject* sceneObject;
		
		beforeEach(^{
			director = mock([FUDirector class]);
			scene = mock([FUScene class]);
			[given([scene director]) willReturn:director];
			sceneObject = [[FUSceneObject alloc] initWithScene:scene];
		});
		
		it(@"is not nil", ^{
			expect(sceneObject).toNot.beNil();
		});
		
		it(@"has a nil scene", ^{
			expect([sceneObject scene]).to.beIdenticalTo(scene);
		});
		
		context(@"registering", ^{
			it(@"calls the director's register method with itself", ^{
				[sceneObject register];
				[verify(director) registerSceneObject:sceneObject];
			});
		});
		
		context(@"unregistering", ^{
			it(@"calls the director's unregister method with itself", ^{
				[sceneObject unregister];
				[verify(director) unregisterSceneObject:sceneObject];
			});
		});
	});
});

SPEC_END
