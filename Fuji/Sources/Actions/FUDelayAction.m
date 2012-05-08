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
#import "FUSupport.h"


static NSString* const FUDelayNegativeMessage = @"Expected 'delay=%g' to be positive";


@interface FUDelayAction ()

@property (nonatomic) NSTimeInterval delay;

@end


@implementation FUDelayAction

@synthesize delay = _delay;

#pragma mark - Initialization

- (id)copyWithZone:(NSZone*)zone
{
	id copy;
	
	if ((copy = [super copyWithZone:zone]))
	{
		[copy setDelay:[self delay]];
	}
	
	return copy;
}

#pragma mark - Initialization

+ (FUDelayAction*)actionWithDelay:(NSTimeInterval)delay
{
	return [[self alloc] initWithDelay:delay];
}

- (id)initWithDelay:(NSTimeInterval)delay
{
	FUCheck(delay >= 0, FUDelayNegativeMessage, delay);
	
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
