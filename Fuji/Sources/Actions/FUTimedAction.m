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
@property (nonatomic) NSTimeInterval time;
@property (nonatomic) FUTimedState state;

@end


@implementation FUTimedAction

@synthesize duration = _duration;
@synthesize time = _time;
@synthesize state = _state;

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
	[copy setTime:[self time]];
	[copy setState:[self state]];
	return copy;
}

#pragma mark - FUAction Methods

- (NSTimeInterval)consumeDeltaTime:(NSTimeInterval)deltaTime
{
	if (deltaTime == 0.0) {
		return 0.0;
	}
	
	NSTimeInterval duration = [self duration];
	NSTimeInterval frameTime = [self time] + deltaTime;
	NSTimeInterval newTime = FUClampDouble(frameTime, 0.0, duration);
	[self setTime:newTime];
	[self updateStateWithDeltaTime:deltaTime];

	if (deltaTime > 0) {
		return MAX(frameTime - duration, 0.0);
	} else {
		return MIN(frameTime, 0.0);
	}
}

#pragma mark - Public Methods

- (void)updateWithFactor:(float)factor
{
}

#pragma mark - Private Methods

- (void)updateStateWithDeltaTime:(NSTimeInterval)deltaTime
{
	NSTimeInterval duration = [self duration];
	NSTimeInterval time = [self time];
	FUTimedState newState = FUTimedStateNone;
	
	if (duration == 0.0) {
		newState = (FUTimedState)(deltaTime / ABS(deltaTime));
	} else if (time == 0.0) {
		newState = FUTimedStateStart;
	} else if (time == duration) {
		newState = FUTimedStateEnd;
	}
	
	// If both the old and new state are on the same end of time
	if (ABS([self state] + newState) == 2) {
		return;
	}
	
	[self setState:newState];
	
	switch (newState) {
		case FUTimedStateStart: [self updateWithFactor:0.0f]; break;
		case FUTimedStateEnd: [self updateWithFactor:1.0f]; break;
		default: [self updateWithFactor:time / duration]; break;
	}
}

@end
