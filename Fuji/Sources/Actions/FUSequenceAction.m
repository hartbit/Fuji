//
//  FUSequenceAction.m
//  Fuji
//
//  Created by David Hart
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUSequenceAction.h"
#import "FUFiniteAction-Internal.h"
#import "FUSupport.h"


static NSString* const FUArrayNilMessage = @"Expected array to not be nil";
static NSString* const FUFiniteActionSubclassMessage = @"Expected 'action=%@' to not be a subclass of FUFiniteAction";


@interface FUSequenceAction ()

@property (nonatomic, strong) NSArray* actions;
@property (nonatomic) NSUInteger actionIndex;

@end


@implementation FUSequenceAction

@synthesize actions = _actions;
@synthesize actionIndex = _actionIndex;

#pragma mark - Initialization

- (id)initWithArray:(NSArray*)array
{
	FUCheck(array != nil, FUArrayNilMessage);
	
	FUTime duration = 0.0;
	
	for (FUFiniteAction* action in array)
	{
		FUCheck([action isKindOfClass:[FUFiniteAction class]], FUFiniteActionSubclassMessage, action);
		duration += [action duration];
	}

	if ((self = [super initWithDuration:duration]))
	{
		[self setActions:array];
	}
	
	return self;
}

- (id)copyWithZone:(NSZone*)zone
{
	id copy;
	
	if ((copy = [super copyWithZone:zone]))
	{
		[copy setActions:[[NSArray alloc] initWithArray:[self actions] copyItems:YES]];
		[copy setActionIndex:[self actionIndex]];
	}
	
	return copy;
}

#pragma mark - FUAction Methods

- (void)updateWithDeltaTime:(FUTime)deltaTime
{
	[super updateWithDeltaTime:deltaTime];
	
	NSArray* actions = [self actions];
	NSUInteger actionCount = [actions count];
	NSInteger actionIndex = [self actionIndex];
	BOOL isDeltaTimePositive = deltaTime >= 0.0;
	NSInteger deltaIndex = isDeltaTimePositive ? 1 : -1;
	
	while (YES)
	{
		FUFiniteAction* action = [actions objectAtIndex:actionIndex];
		FUTime targetTime = isDeltaTimePositive ? [action duration] : 0.0;
		FUTime timeToCompletion = targetTime - [action time];
		
		[action updateWithDeltaTime:deltaTime];
		
		if ((ABS(timeToCompletion) > ABS(deltaTime)) ||
			(!isDeltaTimePositive && ([self actionIndex] == 0)) ||
			(isDeltaTimePositive && ([self actionIndex] == actionCount - 1)))
		{
			return;
		}
		
		deltaTime -= timeToCompletion;
		actionIndex += deltaIndex;
		[self setActionIndex:actionIndex];
	}
}

@end
