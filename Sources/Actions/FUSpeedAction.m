//
//  FUSpeedAction.m
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUSpeedAction.h"
#import "FUSupport.h"


static NSString* const FUActionNilMessage = @"Expected 'action' to not be nil";


@interface FUSpeedAction ()

@property (nonatomic, strong) id<FUAction> action;

@end


@implementation FUSpeedAction

#pragma mark - Initialization

- (id)initWithAction:(id<FUAction>)action speed:(float)speed
{
	FUCheck(action != nil, FUActionNilMessage);
	
	if ((self = [super init])) {
		[self setAction:action];
		[self setSpeed:speed];
	}
	
	return self;
}

#pragma mark - NSCopying Methods

- (id)copyWithZone:(NSZone*)zone
{
	FUSpeedAction* copy = [[[self class] allocWithZone:zone] init];
	[copy setAction:[[self action] copyWithZone:zone]];
	[copy setSpeed:[self speed]];
	return copy;
}

#pragma mark - FUAction Methods

- (NSTimeInterval)consumeDeltaTime:(NSTimeInterval)deltaTime
{
	float speed = [self speed];
	
	if (speed == 0.0f) {
		return 0.0;
	}
	
	return [[self action] consumeDeltaTime:deltaTime * [self speed]] / [self speed];
}

@end


FUSpeedAction* FUSpeed(id<FUAction> action, float speed)
{
	return [[FUSpeedAction alloc] initWithAction:action speed:speed];
}
