//
//  FUFiniteAction.m
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUFiniteAction.h"
#import "FUMath.h"


static NSString* const FUDurationNegativeMessage = @"Expected 'duration=%g' to be positive";


@interface FUFiniteAction ()

@property (nonatomic) NSTimeInterval duration;
@property (nonatomic) float factor;

@end


@implementation FUFiniteAction

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
	FUFiniteAction* copy = [[[self class] allocWithZone:zone] init];
	[copy setDuration:[self duration]];
	[copy setFactor:[self factor]];
	return copy;
}

#pragma mark - FUFiniteAction Methods

- (void)updateWithFactor:(float)factor
{
	[self setFactor:factor];
}

#pragma mark - FUAction Methods

- (NSTimeInterval)consumeDeltaTime:(NSTimeInterval)deltaTime
{
	NSTimeInterval duration = [self duration];
	
	if (duration == 0.0f) {
		[self updateWithFactor:1.0f];
	} else {
		float deltaFactor = deltaTime / duration;
		float newFactor = FUClampFloat([self factor] + deltaFactor, 0.0f, 1.0f);
		[self updateWithFactor:newFactor];
	}
	
	return 0.0;
}

@end
