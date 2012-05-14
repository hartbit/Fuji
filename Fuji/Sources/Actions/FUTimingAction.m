//
//  FUTimingAction.m
//  Fuji
//
//  Created by David Hart
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

@property (nonatomic, strong) FUFiniteAction* action;
@property (nonatomic, copy) FUTimingFunction function;

@end


@implementation FUTimingAction

@synthesize action = _action;
@synthesize function = _function;

#pragma mark - Initialization

- (id)initWithAction:(FUFiniteAction*)action function:(FUTimingFunction)function
{
	FUCheck(action != nil, FUActionNilMessage);
	FUCheck(function != NULL, FUFunctionNullMessage);
	
	if ((self = [super initWithDuration:[action duration]])) {
		[self setAction:action];
		[self setFunction:function];
	}
	
	return self;
}

- (id)copyWithZone:(NSZone*)zone
{
	FUTimingAction* copy = [super copyWithZone:zone];
	[copy setAction:[[self action] copyWithZone:zone]];
	[copy setFunction:[self function]];
	return copy;
}

#pragma mark - FUFiniteAction Methods

- (void)updateWithFactor:(float)factor
{
	float newFactor = [self function](FUClamp(factor, 0.0f, 1.0f));
	[[self action] updateWithFactor:newFactor];
}

@end
