//
//  FUTestFunctions.h
//  Fuji
//
//  Created by David Hart
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//


static inline BOOL FUMatrix4AreEqual(GLKMatrix4 left, GLKMatrix4 right)
{
	return (left.m00 == right.m00) && (left.m01 == right.m01) && (left.m02 == right.m02) && (left.m03 == right.m03) &&
	(left.m10 == right.m10) && (left.m11 == right.m11) && (left.m12 == right.m12) && (left.m13 == right.m13) &&
	(left.m20 == right.m20) && (left.m21 == right.m21) && (left.m22 == right.m22) && (left.m23 == right.m23) &&
	(left.m30 == right.m30) && (left.m31 == right.m31) && (left.m32 == right.m32) && (left.m33 == right.m33);
}

static inline BOOL FUAreCloseWithAccuracy(float a, float b, float epsilon)
{
    return fabs(a - b) < epsilon;
}

static inline BOOL FUAreClose(float a, float b)
{
    return FUAreCloseWithAccuracy(a, b, FLT_EPSILON);
}

static inline BOOL FUMatrix4AreClose(GLKMatrix4 left, GLKMatrix4 right)
{
	return FUAreClose(left.m00, right.m00) && FUAreClose(left.m01, right.m01) && FUAreClose(left.m02, right.m02) && FUAreClose(left.m03, right.m03) &&
	FUAreClose(left.m10, right.m10) && FUAreClose(left.m11, right.m11) && FUAreClose(left.m12, right.m12) && FUAreClose(left.m13, right.m13) &&
	FUAreClose(left.m20, right.m20) && FUAreClose(left.m21, right.m21) && FUAreClose(left.m22, right.m22) && FUAreClose(left.m23, right.m23) &&
	FUAreClose(left.m30, right.m30) && FUAreClose(left.m31, right.m31) && FUAreClose(left.m32, right.m32) && FUAreClose(left.m33, right.m33);
}


#define TEXTURE_NONEXISTANT @"Nonexistent.png"
#define TEXTURE_INVALID @"Invalid.txt"
#define TEXTURE_VALID1 @"Valid1.png"
#define TEXTURE_VALID2 @"Valid2.png"


#define FU_WAIT_UNTIL_TIMEOUT(condition, timeout) \
	NSDate* timeoutDate = [[NSDate alloc] initWithTimeIntervalSinceNow:(timeout)]; \
	while (!(condition) && ([timeoutDate timeIntervalSinceDate:[NSDate date]] > 0)) { \
		[[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01]]; \
	}

#define FU_WAIT_UNTIL(condition) FU_WAIT_UNTIL_TIMEOUT(condition, 10)
