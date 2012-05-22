//
//  FUTimingFunctions.m
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUTimingFunctions.h"
#import "FUSupport.h"


#define FUTimingInOut(_inFunction, _outFunction, _t) \
	if (_t < 0.5f) { \
		return 0.5f * _inFunction(t * 2.0f); \
	} else { \
		return 0.5f * _outFunction((t - 0.5f) * 2.0f) + 0.5f; \
	}


const FUTimingFunction FUTimingLinear = ^(float t) {
	return t;
};

const FUTimingFunction FUTimingEaseIn = ^(float t) {
	return t * t * t;
};

const FUTimingFunction FUTimingEaseOut = ^(float t) {
	float inverseT = t - 1.0f;
    return inverseT * inverseT * inverseT + 1.0f;
};

const FUTimingFunction FUTimingEaseInOut = ^(float t) {
	FUTimingInOut(FUTimingEaseIn, FUTimingEaseOut, t);
};

const float backS = 1.70158;

const FUTimingFunction FUTimingBackIn = ^(float t) {
	return t * t * ((backS + 1) * t - backS);
};

const FUTimingFunction FUTimingBackOut = ^(float t) {
	float inverseT = t - 1.0f;
    return inverseT * inverseT * ((backS + 1.0f) * inverseT + backS) + 1.0f;    
};

const FUTimingFunction FUTimingBackInOut = ^(float t) {
	FUTimingInOut(FUTimingBackIn, FUTimingBackOut, t);
};

const float elasticP = 0.3f;
const float elasticS = elasticP * 0.25f;

const FUTimingFunction FUTimingElasticIn = ^(float t) {
	if ((t == 0) || (t == 1)) {
		return t;
	}
	
	float inverseT = t - 1.0f;
	return -1.0f * powf(2.0f, 10.0f * inverseT) * sin((inverseT - elasticS) * (2 * M_PI) / elasticP);
};

const FUTimingFunction FUTimingElasticOut = ^(float t) {
	if ((t == 0) || (t == 1)) {
		return t;
	}
	
	return powf(2.0f, -10.0f * t) * sinf((t - elasticS) * (2 * M_PI) / elasticP) + 1.0f;
};

const FUTimingFunction FUTimingElasticInOut = ^(float t) {
	FUTimingInOut(FUTimingElasticIn, FUTimingElasticOut, t);
};

const float bounceS = 7.5625f;
const float bounceP = 2.75f;

const FUTimingFunction FUTimingBounceIn = ^(float t) {
	return 1.0f - FUTimingBounceOut(1.0f - t);
};

const FUTimingFunction FUTimingBounceOut = ^(float t) {
	float l;
	
	if (t < (1.0f / bounceP)) {
		l = bounceS * t * t;
	} else if (t < (2.0f / bounceP)) {
		t -= 1.5f / bounceP;
		l = bounceS * t * t + 0.75f;
	} else if (t < (2.5f / bounceP)) {
		t -= 2.25f / bounceP;
		l = bounceS * t * t + 0.9375f;
	} else {
		t -= 2.625f / bounceP;
		l = bounceS * t * t + 0.984375f;
	}
	
	return l;
};

const FUTimingFunction FUTimingBounceInOut = ^(float t) {
	FUTimingInOut(FUTimingBounceIn, FUTimingBounceOut, t);
};