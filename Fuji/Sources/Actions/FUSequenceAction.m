//
//  FUSequenceAction.m
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUSequenceAction.h"
#import "FUSupport.h"


static NSString* const FUArrayNilEmptyMessage = @"Expected array to not be nil or empty";
static NSString* const FUActionProtocolMessage = @"Expected 'action=%@' to conform to the FUAction protocol";


@interface FUSequenceAction ()

@property (nonatomic, getter=isComplete) BOOL complete;
@property (nonatomic, copy) NSArray* actions;
@property (nonatomic) NSUInteger actionIndex;

@end


@implementation FUSequenceAction

@synthesize complete = _complete;
@synthesize actions = _actions;
@synthesize actionIndex = _actionIndex;

#pragma mark - Initialization

- (id)initWithActions:(NSArray*)actions
{
	FUCheck([actions count] > 0, FUArrayNilEmptyMessage);
	
#ifndef NS_BLOCK_ASSERTIONS
	for (id action in actions) {
		FUCheck([action conformsToProtocol:@protocol(FUAction)], FUActionProtocolMessage, action);
	}
#endif

	if ((self = [super init])) {
		[self setActions:actions];
	}
	
	return self;
}

#pragma mark - NSCopying Methods

- (id)copyWithZone:(NSZone*)zone
{
	FUSequenceAction* copy = [[self class] allocWithZone:zone];
	[copy setActions:[[NSArray alloc] initWithArray:[self actions] copyItems:YES]];
	[copy setActionIndex:[self actionIndex]];
	return copy;
}

#pragma mark - FUAction Methods

- (NSTimeInterval)consumeDeltaTime:(NSTimeInterval)deltaTime
{
	if (deltaTime == 0.0) {
		return 0.0;
	}
	
	NSArray* actions = [self actions];
	NSUInteger actionCount = [actions count];
	NSUInteger actionIndex = [self actionIndex];

	__block NSTimeInterval timeLeft = deltaTime;
	
	BOOL (^updateActionAtIndex)(NSInteger index) = ^(NSInteger index) {
		id<FUAction> action = [actions objectAtIndex:index];
		timeLeft = [action consumeDeltaTime:timeLeft];
		
		if (timeLeft == 0.0) {
			[self setActionIndex:index];
			return YES;
		} else {
			return NO;
		}
	};
	
	if (deltaTime < 0.0) {
		for (NSInteger index = actionIndex; index >= 0; index--) {
			BOOL shouldStop = updateActionAtIndex(index);
			if (shouldStop) break;
		}
	} else {
		for (NSInteger index = actionIndex; index < actionCount; index++) {
			BOOL shouldStop = updateActionAtIndex(index);
			if (shouldStop) break;
		}
	}
	
	return timeLeft;
}

@end


FUSequenceAction* FUSequence(NSArray* actions)
{
	return [[FUSequenceAction alloc] initWithActions:actions];
}
