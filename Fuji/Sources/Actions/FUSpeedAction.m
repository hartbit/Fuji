//
//  FUSpeedAction.m
//  Fuji
//
//  Created by David Hart
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

@synthesize action = _action;
@synthesize speed = _speed;

#pragma mark - Initialization

- (id)initWithAction:(id<FUAction>)action speed:(float)speed
{
	FUCheck(action != nil, FUActionNilMessage);
	
	if ((self = [super init]))
	{
		[self setAction:action];
		[self setSpeed:speed];
	}
	
	return self;
}

- (id)copyWithZone:(NSZone*)zone
{
	id copy;
	
	if ((copy = [[self class] new]))
	{
		[self setAction:[[self action] copyWithZone:zone]];
		[self setSpeed:[self speed]];
	}
	
	return self;
}

#pragma mark - FUAction Methods

- (BOOL)isComplete
{
	return NO;
}

- (void)updateWithDeltaTime:(NSTimeInterval)deltaTime
{
	[[self action] updateWithDeltaTime:deltaTime * [self speed]];
}

@end
