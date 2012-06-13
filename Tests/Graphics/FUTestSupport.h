//
//  FUTestSupport.h
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "Fuji.h"


static OBJC_INLINE BOOL FUVector2AreClose(GLKVector2 left, GLKVector2 right)
{
	return FUAreCloseFloat(left.x, right.x) && FUAreCloseFloat(left.y, right.y);
}

static OBJC_INLINE BOOL FUVector3AreClose(GLKVector3 left, GLKVector3 right)
{
	return FUAreCloseFloat(left.x, right.x) && FUAreCloseFloat(left.y, right.y) && FUAreCloseFloat(left.z, right.z);
}

static OBJC_INLINE BOOL FUVector4AreClose(GLKVector4 left, GLKVector4 right)
{
	return FUAreCloseFloat(left.x, right.x) && FUAreCloseFloat(left.y, right.y) && FUAreCloseFloat(left.z, right.z) && FUAreCloseFloat(left.w, right.w);
}

static OBJC_INLINE BOOL FUMatrix4AreEqual(GLKMatrix4 left, GLKMatrix4 right)
{
	return (left.m00 == right.m00) && (left.m01 == right.m01) && (left.m02 == right.m02) && (left.m03 == right.m03) &&
	(left.m10 == right.m10) && (left.m11 == right.m11) && (left.m12 == right.m12) && (left.m13 == right.m13) &&
	(left.m20 == right.m20) && (left.m21 == right.m21) && (left.m22 == right.m22) && (left.m23 == right.m23) &&
	(left.m30 == right.m30) && (left.m31 == right.m31) && (left.m32 == right.m32) && (left.m33 == right.m33);
}

static OBJC_INLINE BOOL FUMatrix4AreClose(GLKMatrix4 left, GLKMatrix4 right)
{
	return FUAreCloseFloat(left.m00, right.m00) && FUAreCloseFloat(left.m01, right.m01) && FUAreCloseFloat(left.m02, right.m02) && FUAreCloseFloat(left.m03, right.m03) &&
	FUAreCloseFloat(left.m10, right.m10) && FUAreCloseFloat(left.m11, right.m11) && FUAreCloseFloat(left.m12, right.m12) && FUAreCloseFloat(left.m13, right.m13) &&
	FUAreCloseFloat(left.m20, right.m20) && FUAreCloseFloat(left.m21, right.m21) && FUAreCloseFloat(left.m22, right.m22) && FUAreCloseFloat(left.m23, right.m23) &&
	FUAreCloseFloat(left.m30, right.m30) && FUAreCloseFloat(left.m31, right.m31) && FUAreCloseFloat(left.m32, right.m32) && FUAreCloseFloat(left.m33, right.m33);
}


static OBJC_INLINE NSString* FUStringFromBool(BOOL value)
{
	return value ? @"YES" : @"NO";
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

#define assertThrows(expr, expectedName, expectedReason, ...) do { \
	BOOL __caughtException = NO; \
	NSString* __expectedReason = STComposeString(expectedReason, ##__VA_ARGS__); \
	@try { \
		(expr);\
	} @catch (NSException* exception) { \
		__caughtException = YES; \
		if (![expectedName isEqualToString:[exception name]]) { \
			NSString* description = STComposeString(@"(Expected exception: (name: %@))", expectedName); \
			[self failWithException: \
				([NSException failureInRaise:[NSString stringWithUTF8String:#expr] \
								   exception:exception \
									  inFile:[NSString stringWithUTF8String:__FILE__] \
									  atLine:__LINE__ \
							 withDescription:description])]; \
		} else if (![__expectedReason isEqualToString:[exception reason]]) { \
			NSString* description = STComposeString(@"(Expected exception) %@", __expectedReason); \
			[self failWithException: \
				([NSException failureInRaise:[NSString stringWithUTF8String:#expr] \
								   exception:exception \
									  inFile:[NSString stringWithUTF8String:__FILE__] \
									  atLine:__LINE__ \
							 withDescription:description])]; \
		} \
	} \
	\
	if (!__caughtException) { \
		[self failWithException: \
			([NSException failureInRaise:[NSString stringWithUTF8String:#expr] \
							   exception:nil \
								  inFile:[NSString stringWithUTF8String:__FILE__] \
								  atLine:__LINE__ \
						 withDescription:@"(Expected exception)"])]; \
	} \
} while (0)

#define assertNoThrow(expr) STAssertNoThrow((expr), nil)
