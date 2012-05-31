//
//  FUGroupAction.m
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUGroupAction.h"


static NSString* const FUArrayNilEmptyMessage = @"Expected array to not be nil or empty";
static NSString* const FUActionSubclassMessage = @"Expected 'action=%@' to be a subclass of FUTimedAction";
static NSString* const FUDurationDifferentMessage = @"Expected actions to have the same duration";


@interface FUGroupAction ()

@property (nonatomic, copy) NSArray* actions;

@end


@implementation FUGroupAction

@synthesize actions = _actions;

#pragma mark - Initialization

- (id)initWithActions:(NSArray*)actions
{
	FUCheck([actions count] > 0, FUArrayNilEmptyMessage);
	
	FUTimedAction* firstAction = [actions objectAtIndex:0];
	FUCheck([firstAction isKindOfClass:[FUTimedAction class]], FUActionSubclassMessage, firstAction);
	
	NSTimeInterval duration = [firstAction duration];
	
#ifndef NS_BLOCK_ASSERTIONS
	for (id action in actions) {
		FUCheck([action isKindOfClass:[FUTimedAction class]], FUActionSubclassMessage, action);
		FUCheck([action duration] == duration, FUDurationDifferentMessage);
	}
#endif
	
	if ((self = [super initWithDuration:duration])) {
		[self setActions:actions];
	}
	
	return self;
}

#pragma mark - NSCopying Methods

- (id)copyWithZone:(NSZone*)zone
{
	FUGroupAction* copy = [super copyWithZone:zone];
	[copy setActions:[[NSArray alloc] initWithArray:[self actions] copyItems:YES]];
	return copy;
}

#pragma mark - FUTimedAction

- (void)update
{
	float normalizedTime = [self normalizedTime];
	
	for (FUTimedAction* action in [self actions]) {
		[action setNormalizedTime:normalizedTime];
	}
}

@end


FUGroupAction* FUGroup(NSArray* actions)
{
	return [[FUGroupAction alloc] initWithActions:actions];
}
