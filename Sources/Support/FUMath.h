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


extern const GLKVector2 GLKVector2Zero;
extern const GLKVector2 GLKVector2One;

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