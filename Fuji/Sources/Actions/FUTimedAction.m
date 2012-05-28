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

@synthesize duration = _duration;
@synthesize factor = _factor;

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
	copy->_factor = [self factor];
	return copy;
}

#pragma mark - Properties

- (void)setFactor:(float)factor
{
	if (factor != _factor) {
		_factor = factor;
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
	float oldFactor = [self factor];
	float newFactor;
	
	if (duration == 0.0) {
		newFactor = isTimeForward ? 1.0f : 0.0f;
	} else {
		newFactor = FUClampFloat(oldFactor + (deltaTime / duration), 0.0f, 1.0f);
	}
	
	[self setFactor:newFactor];

	// Return time left
	
	NSTimeInterval frameTime = (oldFactor * duration) + deltaTime;
	
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
