//
//  FUTimingActionSpec.m
//  Fuji
//
//  Created by David Hart
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#include "Prefix.pch"
#import "Fuji.h"
#import "FUTestSupport.h"


#define FUTestTimingFunction(_function) \
	context(@#_function, ^{ \
		it(@"has a min value of 0.0f", ^{ \
			expect(_function(0.0f)).to.equal(0.0f); \
		}); \
		\
		it(@"has a max value of 1.0f", ^{ \
			expect(_function(1.0f)).to.equal(1.0f); \
		}); \
	});


static NSString* const FUActionNilMessage = @"Expected 'action' to not be nil";
static NSString* const FUFunctionNullMessage = @"Expected 'function' to not be NULL";


SPEC_BEGIN(FUTimingAction)

describe(@"Timing functions", ^{
	FUTestTimingFunction(FUTimingLinear);
	FUTestTimingFunction(FUTimingEaseIn);
	FUTestTimingFunction(FUTimingEaseOut);
	FUTestTimingFunction(FUTimingEaseInOut);
	FUTestTimingFunction(FUTimingBackIn);
	FUTestTimingFunction(FUTimingBackOut);
	FUTestTimingFunction(FUTimingBackInOut);
	FUTestTimingFunction(FUTimingElasticIn);
	FUTestTimingFunction(FUTimingElasticOut);
	FUTestTimingFunction(FUTimingElasticInOut);
	FUTestTimingFunction(FUTimingBounceIn);
	FUTestTimingFunction(FUTimingBounceOut);
	FUTestTimingFunction(FUTimingBounceInOut);
});

describe(@"A timing action", ^{
	it(@"is a finite action", ^{
		expect([FUTimingAction class]).to.beSubclassOf([FUFiniteAction class]);
	});
	
	context(@"initializing with a nil action", ^{
		it(@"throws an exception", ^{
			assertThrows([[FUTimingAction alloc] initWithAction:nil function:FUTimingLinear], NSInvalidArgumentException, FUActionNilMessage);
		});
	});
	
	context(@"initializing with a NULL function", ^{
		it(@"throws an exception", ^{
			FUFiniteAction* action = mock([FUFiniteAction class]);
			assertThrows([[FUTimingAction alloc] initWithAction:action function:NULL], NSInvalidArgumentException, FUFunctionNullMessage);
		});
	});
	
	context(@"initializing with an action and a function", ^{
		__block FUTimingAction* action;
		__block id<FUAction> subaction;
		
		beforeEach(^{
			subaction = mockProtocol(@protocol(FUAction));
			action = [[FUTimingAction alloc] initWithAction:subaction function:FUTimingEaseInOut];
		});
		
		it(@"is not nil", ^{
			expect(action).toNot.beNil();
		});
	});
});

SPEC_END