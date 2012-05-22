//
//  FUMath.h
//  Fuji
//
//  Created by Hart David on 29.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import <GLKit/GLKit.h>
#import "FUSupport.h"
#import "FUColor.h"


OBJC_EXPORT const GLKVector2 GLKVector2Zero;
OBJC_EXPORT const GLKVector2 GLKVector2One;

#pragma mark - RNG Functions

static OBJC_INLINE float FURandomUnit()
{
	return (float)arc4random() / 0x100000000;
}

static OBJC_INLINE GLubyte FURandomByte()
{
	return arc4random() / 256;
}

static OBJC_INLINE float FURandomFloat(float min, float max)
{
	return min + (FURandomUnit() * (max - min));
}

static OBJC_INLINE double FURandomDouble(double min, double max)
{
	return min + (FURandomUnit() * (max - min));
}

static OBJC_INLINE NSInteger FURandomInteger(NSInteger min, NSInteger max)
{
	return min + (NSInteger)(FURandomUnit() * (max - min + 1));
}

static OBJC_INLINE FUColor FURandomColor()
{
	return FUColorMake(FURandomByte(), FURandomByte(), FURandomByte(), FURandomByte());
}

#pragma mark - General Math Functions

static OBJC_INLINE float FUClampFloat(float value, float min, float max)
{
	FUCheck(min <= max, @"Expected 'min=%g' to be less than or equal to 'max=%g'", min, max);
	return MIN(MAX(value, min), max);
}

static OBJC_INLINE double FUClampDouble(double value, double min, double max)
{
	FUCheck(min <= max, @"Expected 'min=%g' to be less than or equal to 'max=%g'", min, max);
	return MIN(MAX(value, min), max);
}

// Comparison functions from http://randomascii.wordpress.com/2012/02/25/comparing-floating-point-numbers-2012-edition/

static OBJC_INLINE BOOL FUAreCloseFloat(float a, float b)
{
	float diff = fabsf(a - b);
	float absA = fabsf(a);
	float absB = fabsf(b);
	float largest = (absB > absA) ? absB : absA;
	return (diff <= largest * FLT_EPSILON);
}

static OBJC_INLINE BOOL FUAreCloseDouble(double a, double b)
{
	double diff = fabs(a - b);
	double absA = fabs(a);
	double absB = fabs(b);
	double largest = (absB > absA) ? absB : absA;
	return (diff <= largest * DBL_EPSILON);
}
