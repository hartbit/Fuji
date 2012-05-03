//
//  FUDelayAction.m
//  Fuji
//
//  Created by David Hart
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUDelayAction.h"


@interface FUDelayAction ()

@property (nonatomic) NSTimeInterval delay;

@end


@implementation FUDelayAction

@synthesize delay = _delay;

#pragma mark - Initialization

+ (FUDelayAction*)actionWithDelay:(NSTimeInterval)delay
{
	return [[self alloc] initWithDelay:delay];
}

- (id)initWithDelay:(NSTimeInterval)delay
{
	if ((self = [super init]))
	{
		[self setDelay:delay];
	}
	
	return self;
}

#pragma mark - FUFiniteAction Methods

- (NSTimeInterval)duration
{
	return [self delay];
}

@end
