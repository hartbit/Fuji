//
//  FUFiniteAction.m
//  Fuji
//
//  Created by David Hart on 5/1/12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "FUFiniteAction.h"


@implementation FUFiniteAction

#pragma mark - Properties

- (NSTimeInterval)duration
{
	return 0;
}

- (BOOL)isComplete
{
	return NO;
}

#pragma mark - FUFiniteAction Methods

- (FUFiniteAction*)reverse
{
	return self;
}

#pragma mark - FUAction Methods

- (void)advanceTime:(NSTimeInterval)deltaTime
{
}

@end
