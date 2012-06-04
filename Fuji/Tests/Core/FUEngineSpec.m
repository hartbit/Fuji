//
//  FUEngineSpec.m
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
#import "FUTestSupport.h"
#import "FUEngine-Internal.h"
#import "FUSceneObject-Internal.h"


static NSString* const FUCreationInvalidMessage = @"Can not create an engine object outside of a director";


SPEC_BEGIN(FUEngine)

describe(@"An engine", ^{
	it(@"can react to interface rotations", ^{
		expect([[FUEngine class] conformsToProtocol:@protocol(FUInterfaceRotating)]).to.beTruthy();
	});
	
	context(@"initilalizing with init", ^{
		it(@"throws an exception", ^{
			assertThrows([FUEngine new], NSInternalInconsistencyException, FUCreationInvalidMessage);
		});
	});
	
	context(@"initialized with a director", ^{
		__block FUDirector* director;
		__block FUEngine* engine;
		
		beforeEach(^{
			director = mock([FUDirector class]);
			engine = [[FUEngine alloc] initWithDirector:director];
		});
		
		it(@"has the director property set correctly", ^{
			expect([engine director]).to.beIdenticalTo(director);
		});
		
		it(@"has no registration visitor", ^{
			expect([engine registrationVisitor]).to.beNil();
		});
		
		it(@"has no unregistration visitor", ^{
			expect([engine unregistrationVisitor]).to.beNil();
		});
	});
});

SPEC_END
