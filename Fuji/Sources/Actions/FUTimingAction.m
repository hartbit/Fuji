//
//  FUTimingAction.m
//  Fuji
//
//  Created by David Hart
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUTimingAction.h"
#import "FUSupport.h"


#define FUTimingInOut(_inFunction, _outFunction, _t) do { \
	if (_t < 0.5f) { \
		return 0.5f * _inFunction(t * 2.0f); \
	} else { \
		return 0.5f * _outFunction((t - 0.5f) * 2.0f) + 0.5f; \
	} \
} while (0)


static NSString* const FUActionNilMessage = @"Expected 'action' to not be nil";
static NSString* const FUFunctionNullMessage = @"Expected 'function' to not be NULL";


const FUTimingFunction FUTimingLinear = ^(FUTime t) {
	return t;
};

const FUTimingFunction FUTimingEaseIn = ^(FUTime t) {
	return t * t * t;
};

const FUTimingFunction FUTimingEaseOut = ^(FUTime t) {
	FUTime inverseT = t - 1.0f;
    return inverseT * inverseT * inverseT + 1.0f;
};

const FUTimingFunction FUTimingEaseInOut = ^(FUTime t) {
	FUTimingInOut(FUTimingEaseIn, FUTimingEaseOut, t);
};

const float backS = 1.70158;

const FUTimingFunction FUTimingBackIn = ^(FUTime t) {
	return t * t * ((backS + 1) * t - backS);
};

const FUTimingFunction FUTimingBackOut = ^(FUTime t) {
	float inverseT = t - 1.0f;
    return inverseT * inverseT * ((backS + 1.0f) * inverseT + backS) + 1.0f;    
};

const FUTimingFunction FUTimingBackInOut = ^(FUTime t) {
	FUTimingInOut(FUTimingBackIn, FUTimingBackOut, t);
};

const float elasticP = 0.3f;
const float elasticS = elasticP * 0.25f;

const FUTimingFunction FUTimingElasticIn = ^(FUTime t) {
	if ((t == 0) || (t == 1)) {
		return t;
	}
	
	float inverseT = t - 1.0f;
	return -1.0f * powf(2.0f, 10.0f * inverseT) * sin((inverseT - elasticS) * (2 * M_PI) / elasticP);
};

const FUTimingFunction FUTimingElasticOut = ^(FUTime t) {
	return powf(2.0f, -10.0f * t) * sinf((t - elasticS) * (2 * M_PI) / elasticP) + 1.0f;
};

const FUTimingFunction FUTimingElasticInOut = ^(FUTime t) {
	FUTimingInOut(FUTimingElasticIn, FUTimingElasticOut, t);
};

const float bounceS = 7.5625f;
const float bounceP = 2.75f;

const FUTimingFunction FUTimingBounceIn = ^(FUTime t) {
	return 1.0f - FUTimingBounceOut(1.0f - t);
};

const FUTimingFunction FUTimingBounceOut = ^(FUTime t) {
    float l;
	
    if (t < (1.0f / bounceP))
    {
        l = bounceS * t * t;
    }
    else
    {    
        if (t < (2.0f / bounceP))
        {
            t -= 1.5f / bounceP;
            l = bounceS * t * t + 0.75f;
        }
        else
        {
            if (t < (2.5f / bounceP))
            {
                t -= 2.25f / bounceP;
                l = bounceS * t * t + 0.9375f;
            }
            else
            {
                t -= 2.625f / bounceP;
                l = bounceS * t * t + 0.984375f;
            }
        }
    }
	
    return l;
};

const FUTimingFunction FUTimingBounceInOut = ^(FUTime t) {
	FUTimingInOut(FUTimingBounceIn, FUTimingBounceOut, t);
};



@implementation FUTimingAction

#pragma mark - Initialization

- (id)initWithAction:(id<FUAction>)action function:(FUTimingFunction)function
{
	FUCheck(action != nil, FUActionNilMessage);
	FUCheck(function != NULL, FUFunctionNullMessage);
	
	if ((self = [super init]))
	{
	}
	
	return self;
}

@end
