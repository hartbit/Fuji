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
OBJC_EXPORT const FUTimingFunction FUTimingEaseIn;
OBJC_EXPORT const FUTimingFunction FUTimingEaseOut;
OBJC_EXPORT const FUTimingFunction FUTimingEaseInOut;
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
