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


typedef float FUTime;


OBJC_EXPORT const GLKVector2 GLKVector2Zero;
OBJC_EXPORT const GLKVector2 GLKVector2One;

#pragma mark - RNG Functions

static inline double FURandomUnit()
{
	return (double)arc4random() / 0x100000000;
}

static inline GLubyte FURandomByte()
{
	return arc4random() / 256;
}

static inline double FURandomDouble(float min, float max)
{
	return min + (FURandomUnit() * (max - min));
}

static inline NSInteger FURandomInteger(NSInteger min, NSInteger max)
{
	return min + (NSInteger)(FURandomUnit() * (max - min + 1));
}

static inline FUColor FURandomColor()
{
	return FUColorMake(FURandomByte(), FURandomByte(), FURandomByte(), FURandomByte());
}

#pragma mark - General Math Functions

static inline double FUClamp(double value, double min, double max)
{
	FUCheck(min <= max, @"Expected 'min=%g' to be less than or equal to 'max=%g'", min, max);
	return MIN(MAX(value, min), max);
}