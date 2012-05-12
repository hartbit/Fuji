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
		it(@"has a min value of 0", ^{ \
			expect(_function(0)).to.equal(0); \
		}); \
		\
		it(@"has a max value of 1", ^{ \
			expect(_function(1)).to.equal(1); \
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
			assertThrows([[FUTimingAction alloc] initWithAction:nil function:^(FUTime t){ return t; }], NSInvalidArgumentException, FUActionNilMessage);
		});
	});
	
	context(@"initializing with a NULL function", ^{
		it(@"throws an exception", ^{
			FUFiniteAction* action = mock([FUFiniteAction class]);
			assertThrows([[FUTimingAction alloc] initWithAction:action function:NULL], NSInvalidArgumentException, FUFunctionNullMessage);
		});
	});
});

SPEC_END