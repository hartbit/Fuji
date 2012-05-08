//
//  FUTestFunctions.h
//  Fuji
//
//  Created by Hart David on 09.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//


static __inline__ BOOL FUMatrix4EqualToMatrix4(GLKMatrix4 left, GLKMatrix4 right)
{
	return memcmp(left.m, right.m, sizeof(float) * 16) == 0;
}

static __inline__ BOOL FUAreCloseWithAccuracy(float a, float b, float epsilon)
{
    return fabs(a - b) < epsilon;
}

static __inline__ BOOL FUAreClose(float a, float b)
{
    return FUAreCloseWithAccuracy(a, b, 0.001);
}

static __inline__ BOOL FUMatrix4CloseToMatrix4(GLKMatrix4 left, GLKMatrix4 right)
{
	return FUAreClose(left.m00, right.m00) && FUAreClose(left.m01, right.m01) && FUAreClose(left.m02, right.m02) && FUAreClose(left.m03, right.m03) &&
	FUAreClose(left.m10, right.m10) && FUAreClose(left.m11, right.m11) && FUAreClose(left.m12, right.m12) && FUAreClose(left.m13, right.m13) &&
	FUAreClose(left.m20, right.m20) && FUAreClose(left.m21, right.m21) && FUAreClose(left.m22, right.m22) && FUAreClose(left.m23, right.m23) &&
	FUAreClose(left.m30, right.m30) && FUAreClose(left.m31, right.m31) && FUAreClose(left.m32, right.m32) && FUAreClose(left.m33, right.m33);
}