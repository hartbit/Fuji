//
//  FUFiniteAction.m
//  Fuji
//
//  Created by David Hart
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUFiniteAction-Internal.h"
#import "FUMath.h"


@interface FUFiniteAction ()

@property (nonatomic) FUTime duration;
@property (nonatomic, getter=isComplete) BOOL complete;

@end


@implementation FUFiniteAction

@synthesize time = _time;
@synthesize duration = _duration;
@synthesize complete = _complete;

#pragma mark - Initialization

- (id)initWithDuration:(FUTime)duration
{
	if ((self = [super init]))
	{
		[self setDuration:duration];
	}
	
	return self;
}

- (id)copyWithZone:(NSZone*)zone
{
	FUFiniteAction* copy = [[self class] new];
	[copy setTime:[self time]];
	[copy setDuration:[self duration]];
	[copy setComplete:[self isComplete]];
	return copy;
}

#pragma mark - FUFiniteAction Methods

- (void)updateWithFactor:(float)factor
{
}

#pragma mark - FUAction Methods

- (void)updateWithDeltaTime:(FUTime)deltaTime
{
	FUTime duration = [self duration];
	FUTime time = [self time] + deltaTime;
	
	[self setComplete:(time < 0.0f) || (time >= duration)];
	time = FUClamp(time, 0.0f, duration);
	
	[self setTime:time];
	[self updateWithFactor:time / duration];
}

@end
