//
//  FUBlockAction.m
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUBlockAction.h"
#import "FUSupport.h"


static NSString* const FUBlockNullMessage = @"Expected block to not be nil";


typedef enum {
	FUBlockStateCalledNegative = -1,
	FUBlockStateNotCalled = 0,
	FUBlockStateCalledPositive = 1
} FUBlockState;


@interface FUBlockAction ()

@property (nonatomic, copy) void (^block)();
@property (nonatomic) FUBlockState state;

@end


@implementation FUBlockAction

@synthesize block = _block;
@synthesize state = _state;

#pragma mark - Initialization

- (id)initWithBlock:(void (^)())block
{
	FUCheck(block != NULL, FUBlockNullMessage);
	
	if ((self = [super init])) {
		[self setBlock:block];
	}
	
	return self;
}

#pragma mark - NSCopying Methods

- (id)copyWithZone:(NSZone*)zone
{
	FUBlockAction* copy = [[super class] allocWithZone:zone];
	[copy setBlock:[self block]];
	[copy setState:[self state]];
	return copy;
}

#pragma mark - FUAction Methods

- (NSTimeInterval)updateWithDeltaTime:(NSTimeInterval)deltaTime
{
	if (deltaTime == 0.0) {
		return 0.0;
	}
	
	FUBlockState state = [self state];
	FUBlockState newState = (FUBlockState)(deltaTime / fabs(deltaTime));
	
	if (newState != state) {
		[self setState:newState];
		[self block]();
	}
	
	return deltaTime;
}

@end
