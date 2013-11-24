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
		
		it(@"has the director property set to nil", ^{
			expect([sceneObject director]).to.beNil();
		});
		
		context(@"giving the scene a director", ^{
			it(@"has the director pointing to the new director", ^{
				FUViewController * director = mock([FUViewController class]);
				[given([scene director]) willReturn:director];
				expect([sceneObject director]).to.beIdenticalTo(director);
			});
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
