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


static NSString* const FUArrayNilMessage = @"Expected array to not be nil";
static NSString* const FUFiniteActionSubclassMessage = @"Expected 'action=%@' to be a subclass of FUFiniteAction";


@interface FUSequenceAction ()

@property (nonatomic, strong) NSArray* actions;
@property (nonatomic) NSUInteger actionIndex;

@end


@implementation FUSequenceAction

@synthesize actions = _actions;
@synthesize actionIndex = _actionIndex;

#pragma mark - Initialization

- (id)initWithActions:(NSArray*)actions
{
	FUCheck(actions != nil, FUArrayNilMessage);
	
	NSTimeInterval duration = 0.0f;
	
	for (FUFiniteAction* action in actions) {
		FUCheck([action isKindOfClass:[FUFiniteAction class]], FUFiniteActionSubclassMessage, action);
		duration += [action duration];
	}

	if ((self = [super initWithDuration:duration])) {
		[self setActions:[actions copy]];
	}
	
	return self;
}

#pragma mark - NSCopying Methods

- (id)copyWithZone:(NSZone*)zone
{
	FUSequenceAction* copy = [super copyWithZone:zone];
	[copy setActions:[[NSArray alloc] initWithArray:[self actions] copyItems:YES]];
	[copy setActionIndex:[self actionIndex]];
	return copy;
}

#pragma mark - FUAction Methods

- (void)updateWithFactor:(float)factor
{
	[super updateWithFactor:factor];
	
	NSArray* actions = [self actions];
	NSUInteger actionCount = [actions count];
	NSTimeInterval duration = [self duration];
	
	float minFactor = 0.0f;
	float maxFactor = 0.0f;
	NSUInteger currentIndex = 0;
	FUFiniteAction* currentAction = nil;
	
	while (YES) {
		currentAction = [actions objectAtIndex:currentIndex];
		maxFactor += [currentAction duration] / duration;
		
		if ((maxFactor > factor) || (currentIndex == actionCount - 1)) {
			break;
		}
		
		currentIndex++;
		minFactor = maxFactor;
	}
	
	NSInteger actionIndex = [self actionIndex];
	
	if (currentIndex > actionIndex) {
		for (; actionIndex < currentIndex; actionIndex++) {
			[[actions objectAtIndex:actionIndex] updateWithFactor:1.0f];
		}
	} else if (currentIndex < actionIndex) {
		for (; actionIndex > currentIndex; actionIndex--) {
			[[actions objectAtIndex:actionIndex] updateWithFactor:0.0f];
		}
	}
	
	[self setActionIndex:actionIndex];
	
	if ((factor == 0.0f) || (factor == 1.0f)) {
		[currentAction updateWithFactor:factor];
	} else {
		float actionFactor = (factor - minFactor) / (maxFactor - minFactor);
		[currentAction updateWithFactor:actionFactor];
	}
}

@end
