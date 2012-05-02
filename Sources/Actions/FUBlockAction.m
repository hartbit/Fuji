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


@interface FUBlockAction ()

@property (nonatomic, strong) void (^block)();

@end


@implementation FUBlockAction

@synthesize block = _block;

#pragma mark - Initialization

+ (id)actionWithBlock:(void (^)())block
{
	return [[self alloc] initWithBlock:block];
}

- (id)initWithBlock:(void (^)())block
{
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
