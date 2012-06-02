//
//  FUSceneObject.m
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
#import "FUSceneObject-Internal.h"
#import "FUTestSupport.h"


static NSString* const FUCreationInvalidMessage = @"Can not create a scene object outside of a scene";
static NSString* const FUSceneNilMessage = @"Expected 'scene' to not be nil";


SPEC_BEGIN(FUSceneObject)

describe(@"A scene", ^{
	it(@"conforms to FUInterfaceRotating", ^{
		expect([[FUSceneObject class] conformsToProtocol:@protocol(FUInterfaceRotating)]).to.beTruthy();
	});
	
	context(@"initialized with init", ^{
		it(@"throws an exception", ^{
			assertThrows([FUSceneObject new], NSInternalInconsistencyException, FUCreationInvalidMessage);
		});
	});
	
	context(@"initialized with a nil scene", ^{
		it(@"throws an exception", ^{
			assertThrows([[FUSceneObject alloc] initWithScene:nil], NSInvalidArgumentException, FUSceneNilMessage);
		});
	});
	
	context(@"initialized with a scene", ^{
		__block FUScene* scene;
		__block FUSceneObject* sceneObject;
		
		beforeEach(^{
			scene = mock([FUScene class]);
			sceneObject = [[FUSceneObject alloc] initWithScene:scene];
		});
		
		it(@"has the scene property set", ^{
			expect([sceneObject scene]).to.beIdenticalTo(scene);
		});
		
		context(@"accepting a visitor", ^{
			it(@"calls the visitSceneObject: method on the visitor", ^{
				FUVisitor* visitor = mock([FUVisitor class]);
				[sceneObject acceptVisitor:visitor];
				[verify(visitor) visitSceneObject:sceneObject];
			});
		});
	});
});

SPEC_END
