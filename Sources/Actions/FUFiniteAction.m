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
