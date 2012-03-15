//
//  FUMath.h
//  Fuji
//
//  Created by Hart David on 29.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <GLKit/GLKit.h>
#import "FUMacros.h"


static __inline__ float FUClamp(float value, float min, float max)
{
	FUCAssertError(min < max, @"min=%f, max=%f", min, max);
	
	if (value < min)
	{
		return min;
	}
	else if (value > max)
	{
		return max;
	}
	else
	{
		return value;
	}
}


extern const GLKVector2 GLKVector2Zero;
extern const GLKVector2 GLKVector2One;
