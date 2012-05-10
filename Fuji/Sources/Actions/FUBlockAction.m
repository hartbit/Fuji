//
//  FUBlockAction.m
//  Fuji
//
//  Created by David Hart
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUBlockAction.h"
#import "FUSupport.h"


static NSString* const FUBlockNullMessage = @"Expected block to not be nil";


@interface FUBlockAction ()

@property (nonatomic, copy) void (^block)();

@end


@implementation FUBlockAction

@synthesize block = _block;

#pragma mark - Initialization

- (id)copyWithZone:(NSZone*)zone
{
	id copy;
	
	if ((copy = [super copyWithZone:zone]))
	{
		[copy setBlock:[self block]];
	}
	
	return copy;
}

#pragma mark - Initialization

+ (id)actionWithBlock:(void (^)())block
{
	return [[self alloc] initWithBlock:block];
}

- (id)initWithBlock:(void (^)())block
{
	FUCheck(block != NULL, FUBlockNullMessage);
	
	if ((self = [super init]))
	{
		[self setBlock:block];
	}
	
	return self;
}

#pragma mark - FUFiniteAction Methods

- (void)updateWithFactor:(float)factor
{
	[self block]();
}

@end