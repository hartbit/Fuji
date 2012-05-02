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


@interface FUFiniteAction ()

@property (nonatomic) NSTimeInterval time;
@property (nonatomic, getter=isComplete) BOOL complete;

@end


@implementation FUFiniteAction

@synthesize time = _time;
@synthesize complete = _complete;

#pragma mark - Properties

- (NSTimeInterval)duration
{
	return 0;
}

#pragma mark - FUFiniteAction Methods

- (FUFiniteAction*)reverse
{
	return self;
}

- (void)updateWithFactor:(float)factor
{
}

#pragma mark - FUAction Methods

- (void)updateWithDeltaTime:(NSTimeInterval)deltaTime
{
	NSTimeInterval duration = [self duration];
	NSTimeInterval time = [self time] + deltaTime;
	
	if (time < 0.0)
	{
		time = 0.0;
		[self setComplete:YES];
	}
	else if (time >= duration)
	{
		time = duration;
		[self setComplete:YES];
	}
	
	[self setTime:time];
	[self updateWithFactor:time / duration];
}

@end
