//
//  FUInterpolations.h
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUMath.h"


typedef float (^FUInterpolation)(float t);


OBJC_EXPORT const FUInterpolation FULinear;
OBJC_EXPORT const FUInterpolation FUInterpolationEaseIn;
OBJC_EXPORT const FUInterpolation FUTimingEaseOut;
OBJC_EXPORT const FUInterpolation FUTimingEaseInOut;
OBJC_EXPORT const FUInterpolation FUTimingBackIn;
OBJC_EXPORT const FUInterpolation FUTimingBackOut;
OBJC_EXPORT const FUInterpolation FUTimingBackInOut;
OBJC_EXPORT const FUInterpolation FUTimingElasticIn;
OBJC_EXPORT const FUInterpolation FUTimingElasticOut;
OBJC_EXPORT const FUInterpolation FUTimingElasticInOut;
OBJC_EXPORT const FUInterpolation FUTimingBounceIn;
OBJC_EXPORT const FUInterpolation FUTimingBounceOut;
OBJC_EXPORT const FUInterpolation FUTimingBounceInOut;