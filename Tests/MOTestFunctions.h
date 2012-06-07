//
//  FUTestFunctions.h
//  Fuji
//
//  Created by Hart David on 09.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//


static __inline__ BOOL GLKMatrix4EqualToMatrix4(GLKMatrix4 left, GLKMatrix4 right)
{
	return memcmp(left.m, right.m, sizeof(float) * 16) == 0;
}

static __inline__ BOOL AreClose(float a, float b)
{
    return fabs(a - b) < 0.001;
}

static __inline__ BOOL GLKMatrix4CloseToMatrix4(GLKMatrix4 left, GLKMatrix4 right)
{
	return AreClose(left.m00, right.m00) && AreClose(left.m01, right.m01) && AreClose(left.m02, right.m02) && AreClose(left.m03, right.m03) &&
	AreClose(left.m10, right.m10) && AreClose(left.m11, right.m11) && AreClose(left.m12, right.m12) && AreClose(left.m13, right.m13) &&
	AreClose(left.m20, right.m20) && AreClose(left.m21, right.m21) && AreClose(left.m22, right.m22) && AreClose(left.m23, right.m23) &&
	AreClose(left.m30, right.m30) && AreClose(left.m31, right.m31) && AreClose(left.m32, right.m32) && AreClose(left.m33, right.m33);
}