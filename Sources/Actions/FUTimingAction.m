//
//  FUTimingAction.m
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUTimingAction.h"
#import "FUSupport.h"


static NSString* const FUActionNilMessage = @"Expected 'action' to not be nil";
static NSString* const FUFunctionNullMessage = @"Expected 'function' to not be NULL";


@interface FUTimingAction ()

@property (nonatomic, strong) FUTimedAction* action;
@property (nonatomic, copy) FUTimingFunction function;

@end


@implementation FUTimingAction

@synthesize action = _action;
@synthesize function = _function;

#pragma mark - Initialization

- (id)initWithAction:(FUTimedAction*)action function:(FUTimingFunction)function
{
	FUCheck(action != nil, FUActionNilMessage);
	FUCheck(function != NULL, FUFunctionNullMessage);
	
	if ((self = [super initWithDuration:[action duration]])) {
		[self setAction:action];
		[self setFunction:function];
	}
	
	return self;
}

#pragma mark - NSCopying Methods

- (id)copyWithZone:(NSZone*)zone
{
	FUTimingAction* copy = [super copyWithZone:zone];
	[copy setAction:[[self action] copyWithZone:zone]];
	[copy setFunction:[self function]];
	return copy;
}

#pragma mark - FUFiniteAction Methods

- (void)update
{
	float actionNormalizedTime = [self function](FUClampFloat([self normalizedTime], 0.0f, 1.0f));
	[[self action] setNormalizedTime:actionNormalizedTime];
}

@end


FUTimingAction* FUTiming(FUTimedAction* action, FUTimingFunction function)
{
	return [[FUTimingAction alloc] initWithAction:action function:function];
}
