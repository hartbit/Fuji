//
//  FUMath.h
//  Fuji
//
//  Created by Hart David on 29.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <GLKit/GLKit.h>
#import "FUMacros.h"

#define ARC4RANDOM_MAX 0x100000000


extern const GLKVector2 GLKVector2Zero;
extern const GLKVector2 GLKVector2One;

static inline double FURandomUnit()
{
	return (double)arc4random() / ARC4RANDOM_MAX;
}

static inline double FURandomDouble(float min, float max)
{
	return min + (FURandomUnit() * (max-min));
}