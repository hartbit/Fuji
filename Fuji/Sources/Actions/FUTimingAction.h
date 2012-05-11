//
//  FUTimingAction.h
//  Fuji
//
//  Created by David Hart
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUFiniteAction.h"
#import "FUAction.h"


typedef FUTime (^FUTimingFunction)(FUTime t);


OBJC_EXPORT const FUTimingFunction FUTimingLinear;
OBJC_EXPORT const FUTimingFunction FUTimingQuadIn;
OBJC_EXPORT const FUTimingFunction FUTimingQuadOut;
OBJC_EXPORT const FUTimingFunction FUTimingQuadInOut;
OBJC_EXPORT const FUTimingFunction FUTimingCubicIn;
OBJC_EXPORT const FUTimingFunction FUTimingCubicOut;
OBJC_EXPORT const FUTimingFunction FUTimingCubicInOut;
OBJC_EXPORT const FUTimingFunction FUTimingQuartIn;
OBJC_EXPORT const FUTimingFunction FUTimingQuartOut;
OBJC_EXPORT const FUTimingFunction FUTimingQuartInOut;
OBJC_EXPORT const FUTimingFunction FUTimingQuintIn;
OBJC_EXPORT const FUTimingFunction FUTimingQuintOut;
OBJC_EXPORT const FUTimingFunction FUTimingQuintInOut;
OBJC_EXPORT const FUTimingFunction FUTimingSinIn;
OBJC_EXPORT const FUTimingFunction FUTimingSinOut;
OBJC_EXPORT const FUTimingFunction FUTimingSinInOut;
OBJC_EXPORT const FUTimingFunction FUTimingExpoIn;
OBJC_EXPORT const FUTimingFunction FUTimingExpoOut;
OBJC_EXPORT const FUTimingFunction FUTimingExpoInOut;
OBJC_EXPORT const FUTimingFunction FUTimingCircIn;
OBJC_EXPORT const FUTimingFunction FUTimingCircOut;
OBJC_EXPORT const FUTimingFunction FUTimingCircInOut;
OBJC_EXPORT const FUTimingFunction FUTimingBackIn;
OBJC_EXPORT const FUTimingFunction FUTimingBackOut;
OBJC_EXPORT const FUTimingFunction FUTimingBackInOut;
OBJC_EXPORT const FUTimingFunction FUTimingElasticIn;
OBJC_EXPORT const FUTimingFunction FUTimingElasticOut;
OBJC_EXPORT const FUTimingFunction FUTimingElasticInOut;
OBJC_EXPORT const FUTimingFunction FUTimingBounceIn;
OBJC_EXPORT const FUTimingFunction FUTimingBounceOut;
OBJC_EXPORT const FUTimingFunction FUTimingBounceInOut;


@interface FUTimingAction : FUFiniteAction

- (id)initWithAction:(id<FUAction>)action function:(FUTimingFunction)function;

@end
