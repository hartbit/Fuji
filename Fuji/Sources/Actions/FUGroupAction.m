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
#import "FUSupport.h"


static NSString* const FUArrayNilMessage = @"Expected array to not be nil";
static NSString* const FUActionProtocolMessage = @"Expected 'action=%@' to conform to the FUAction protocol";


@interface FUGroupAction ()

@property (nonatomic, strong) NSArray* actions;

@end


@implementation FUGroupAction

@synthesize actions = _actions;

#pragma mark - Initialization

- (id)initWithActions:(NSArray*)actions
{
	FUCheck(actions != nil, FUArrayNilMessage);
	
	for (FUFiniteAction* action in actions) {
		FUCheck([action conformsToProtocol:@protocol(FUAction)], FUActionProtocolMessage, action);
	}
	
	if ((self = [super init])) {
		[self setActions:[actions copy]];
	}
	
	return self;
}

#pragma mark - NSCopying Methods

- (id)copyWithZone:(NSZone*)zone
{
	FUGroupAction* copy = [[self class] allocWithZone:zone];
	[copy setActions:[[NSArray alloc] initWithArray:[self actions] copyItems:YES]];
	return copy;
}

#pragma mark - FUAction Methods

- (NSTimeInterval)updateWithDeltaTime:(NSTimeInterval)deltaTime
{
	if (deltaTime == 0.0) {
		return 0.0;
	}
	
	BOOL isForward = deltaTime > 0.0;
	NSTimeInterval lessTimeLeft = isForward ? DBL_MAX : -DBL_MAX;
	
	for (id<FUAction> action in [self actions]) {
		NSTimeInterval timeLeft = [action updateWithDeltaTime:deltaTime];
		lessTimeLeft = isForward ? MIN(lessTimeLeft, timeLeft) : MAX(lessTimeLeft, timeLeft);
	}
	
	return lessTimeLeft;
}


@end
