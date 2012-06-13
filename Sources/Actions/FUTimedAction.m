//
//  FUTimedAction.m
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUTimedAction.h"
#import "FUMath.h"


static NSString* const FUDurationNegativeMessage = @"Expected 'duration=%g' to be positive";


typedef enum {
	FUTimedStateStart = -1,
	FUTimedStateNone = 0,
	FUTimedStateEnd = 1
} FUTimedState;


@interface FUTimedAction ()

@property (nonatomic) NSTimeInterval duration;

@end


@implementation FUTimedAction

#pragma mark - Initialization

- (id)initWithDuration:(NSTimeInterval)duration
{
	FUCheck(duration >= 0.0f, FUDurationNegativeMessage, duration);
	
	if ((self = [super init])) {
		[self setDuration:duration];
	}
	
	return self;
}

#pragma mark - NSCopying Methods

- (id)copyWithZone:(NSZone*)zone
{
	FUTimedAction* copy = [[self class] allocWithZone:zone];
	[copy setDuration:[self duration]];
	copy->_normalizedTime = [self normalizedTime];
	return copy;
}

#pragma mark - Properties

- (void)setNormalizedTime:(float)normalizedTime
{
	if (normalizedTime != _normalizedTime) {
		_normalizedTime = normalizedTime;
		[self update];
	}
}

#pragma mark - FUAction Methods

- (NSTimeInterval)consumeDeltaTime:(NSTimeInterval)deltaTime
{
	if (deltaTime == 0.0) {
		return 0.0;
	}
	
	BOOL isTimeForward = deltaTime > 0.0;
	NSTimeInterval duration = [self duration];
	float oldNormalizedTime = [self normalizedTime];
	float newNormalizedTime;
	
	if (duration == 0.0) {
		newNormalizedTime = isTimeForward ? 1.0f : 0.0f;
	} else {
		newNormalizedTime = FUClampFloat(oldNormalizedTime + (float)(deltaTime / duration), 0.0f, 1.0f);
	}
	
	[self setNormalizedTime:newNormalizedTime];

	// Return time left
	
	NSTimeInterval frameTime = (oldNormalizedTime * duration) + deltaTime;
	
	if (isTimeForward) {
		return MAX(frameTime - duration, 0.0);
	} else {
		return MIN(frameTime, 0.0);
	}
}

#pragma mark - Public Methods

- (void)update
{
}

@end


FUTimedAction* FUDelay(NSTimeInterval duration)
{
	return [[FUTimedAction alloc] initWithDuration:duration];
}
