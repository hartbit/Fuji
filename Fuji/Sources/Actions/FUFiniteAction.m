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

#import "FUFiniteAction.h"
#import "FUMath.h"


static NSString* const FUDurationNegativeMessage = @"Expected 'duration=%g' to be positive";


@interface FUFiniteAction ()

@property (nonatomic) FUTime duration;
@property (nonatomic) float factor;
@property (nonatomic, getter=isComplete) BOOL complete;

@end


@implementation FUFiniteAction

@synthesize duration = _duration;
@synthesize factor = _factor;
@synthesize complete = _complete;

#pragma mark - Initialization

- (id)initWithDuration:(FUTime)duration
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
	FUFiniteAction* copy = [[[self class] allocWithZone:zone] init];
	[copy setDuration:[self duration]];
	[copy setFactor:[self factor]];
	[copy setComplete:[self isComplete]];
	return copy;
}

#pragma mark - FUFiniteAction Methods

- (void)updateWithFactor:(float)factor
{
	[self setFactor:factor];
	[self setComplete:((factor == 0.0f) || (factor == 1.0f))];
}

#pragma mark - FUAction Methods

- (void)updateWithDeltaTime:(FUTime)deltaTime
{
	FUTime duration = [self duration];
	
	if (duration == 0.0f) {
		[self updateWithFactor:1.0f];
	} else {
		FUTime time = FUClamp([self factor] * duration + deltaTime, 0.0f, duration);
		[self updateWithFactor:time / duration];
	}
}

@end
