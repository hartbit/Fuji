//
//  FUTestFunctions.h
//  Fuji
//
//  Created by Hart David on 09.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//


static inline BOOL FUMatrix4EqualToMatrix4(GLKMatrix4 left, GLKMatrix4 right)
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
    return FUAreCloseWithAccuracy(a, b, 0.001);
}

static inline BOOL FUMatrix4CloseToMatrix4(GLKMatrix4 left, GLKMatrix4 right)
{
	return FUAreClose(left.m00, right.m00) && FUAreClose(left.m01, right.m01) && FUAreClose(left.m02, right.m02) && FUAreClose(left.m03, right.m03) &&
	FUAreClose(left.m10, right.m10) && FUAreClose(left.m11, right.m11) && FUAreClose(left.m12, right.m12) && FUAreClose(left.m13, right.m13) &&
	FUAreClose(left.m20, right.m20) && FUAreClose(left.m21, right.m21) && FUAreClose(left.m22, right.m22) && FUAreClose(left.m23, right.m23) &&
	FUAreClose(left.m30, right.m30) && FUAreClose(left.m31, right.m31) && FUAreClose(left.m32, right.m32) && FUAreClose(left.m33, right.m33);
}


#define FU_WAIT_UNTIL_TIMEOUT(condition, timeout) \
	NSDate* timeoutDate = [[NSDate alloc] initWithTimeIntervalSinceNow:(timeout)]; \
	while (!(condition) && ([timeoutDate timeIntervalSinceDate:[NSDate date]] > 0)) { \
		[[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01]]; \
	}

#define FU_WAIT_UNTIL(condition) FU_WAIT_UNTIL_TIMEOUT(condition, 10)
