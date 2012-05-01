//
//  FUAnimator.m
//  Fuji
//
//  Created by David Hart
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUAnimator.h"


@interface FUAnimator ()

@property (nonatomic, strong) NSMutableArray* animatables;

@end


@implementation FUAnimator

@synthesize animatables = _animatables;

#pragma mark - Properties

- (BOOL)isComplete
{
	return NO;
}

- (NSMutableArray*)animatables
{
	if (_animatables == nil)
	{
		[self setAnimatables:[NSMutableArray array]];
	}
	
	return _animatables;
}

#pragma mark - Public Methods

- (void)playAnimatable:(id<FUAnimatable>)animatable
{
	[[self animatables] addObject:animatable];
}

- (void)advanceTime:(NSTimeInterval)deltaTime
{
	for (id<FUAnimatable> animatable in [self animatables])
	{
		[animatable advanceTime:deltaTime];
	}
}

@end
