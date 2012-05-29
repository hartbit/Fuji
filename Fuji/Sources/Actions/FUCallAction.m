//
//  FUCallAction.m
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUCallAction.h"
#import "FUSupport.h"


static NSString* const FUCallNullMessage = @"Expected block to not be nil";


@interface FUCallAction ()

@property (nonatomic, copy) void (^block)();

@end


@implementation FUCallAction

@synthesize block = _block;

#pragma mark - Initialization

- (id)initWithBlock:(void (^)())block
{
	FUCheck(block != NULL, FUCallNullMessage);
	
	if ((self = [super initWithDuration:0.0])) {
		[self setBlock:block];
	}
	
	return self;
}

#pragma mark - NSCopying Methods

- (id)copyWithZone:(NSZone*)zone
{
	FUCallAction* copy = [super copyWithZone:zone];
	[copy setBlock:[self block]];
	return copy;
}

#pragma mark - FUTimedAction Methods

- (void)update
{
	[self block]();
}

@end
