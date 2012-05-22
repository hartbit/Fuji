//
//  FUTimingFunctionsSpec.m
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


#define FUTestTimingFunction(_function) \
	context(@#_function, ^{ \
		it(@"has a min value of 0.0f", ^{ \
			expect(_function(0.0f)).to.equal(0.0f); \
		});	\
		\
		it(@"has a max value of 1.0f", ^{ \
			expect(_function(1.0f)).to.equal(1.0f); \
		}); \
	});


SPEC_BEGIN(FUTimingFunctions)

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

SPEC_END
