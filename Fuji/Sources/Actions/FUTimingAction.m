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


static NSString* const FUActionNilMessage = @"Expected 'action' to not be nil";
static NSString* const FUFunctionNullMessage = @"Expected 'function' to not be NULL";


const FUTimingFunction FUTimingLinear = ^(FUTime t) {
	return t;
};

const FUTimingFunction FUTimingQuadIn = ^(FUTime t) {
	return t;
};

const FUTimingFunction FUTimingQuadOut = ^(FUTime t) {
	return t;
};

const FUTimingFunction FUTimingQuadInOut = ^(FUTime t) {
	return t;
};

const FUTimingFunction FUTimingCubicIn = ^(FUTime t) {
	return t;
};

const FUTimingFunction FUTimingCubicOut = ^(FUTime t) {
	return t;
};

const FUTimingFunction FUTimingCubicInOut = ^(FUTime t) {
	return t;
};

const FUTimingFunction FUTimingQuartIn = ^(FUTime t) {
	return t;
};

const FUTimingFunction FUTimingQuartOut = ^(FUTime t) {
	return t;
};

const FUTimingFunction FUTimingQuartInOut = ^(FUTime t) {
	return t;
};

const FUTimingFunction FUTimingQuintIn = ^(FUTime t) {
	return t;
};

const FUTimingFunction FUTimingQuintOut = ^(FUTime t) {
	return t;
};

const FUTimingFunction FUTimingQuintInOut = ^(FUTime t) {
	return t;
};

const FUTimingFunction FUTimingSinIn = ^(FUTime t) {
	return t;
};

const FUTimingFunction FUTimingSinOut = ^(FUTime t) {
	return t;
};

const FUTimingFunction FUTimingSinInOut = ^(FUTime t) {
	return t;
};

const FUTimingFunction FUTimingExpoIn = ^(FUTime t) {
	return t;
};

const FUTimingFunction FUTimingExpoOut = ^(FUTime t) {
	return t;
};

const FUTimingFunction FUTimingExpoInOut = ^(FUTime t) {
	return t;
};

const FUTimingFunction FUTimingCircIn = ^(FUTime t) {
	return t;
};

const FUTimingFunction FUTimingCircOut = ^(FUTime t) {
	return t;
};

const FUTimingFunction FUTimingCircInOut = ^(FUTime t) {
	return t;
};

const FUTimingFunction FUTimingBackIn = ^(FUTime t) {
	return t;
};

const FUTimingFunction FUTimingBackOut = ^(FUTime t) {
	return t;
};

const FUTimingFunction FUTimingBackInOut = ^(FUTime t) {
	return t;
};

const FUTimingFunction FUTimingElasticIn = ^(FUTime t) {
	return t;
};

const FUTimingFunction FUTimingElasticOut = ^(FUTime t) {
	return t;
};

const FUTimingFunction FUTimingElasticInOut = ^(FUTime t) {
	return t;
};

const FUTimingFunction FUTimingBounceIn = ^(FUTime t) {
	return t;
};

const FUTimingFunction FUTimingBounceOut = ^(FUTime t) {
	return t;
};

const FUTimingFunction FUTimingBounceInOut = ^(FUTime t) {
	return t;
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
