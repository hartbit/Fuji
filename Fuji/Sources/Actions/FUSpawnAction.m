//
//  FUSpawnAction.m
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUSpawnAction.h"
#import "FUSupport.h"


static NSString* const FUArrayNilMessage = @"Expected array to not be nil";
static NSString* const FUActionProtocolMessage = @"Expected 'action=%@' to conform to the FUAction protocol";


@interface FUSpawnAction ()

@property (nonatomic, copy) NSArray* actions;

@end


@implementation FUSpawnAction

@synthesize actions = _actions;

#pragma mark - Initialization

- (id)initWithActions:(NSArray*)actions
{
	FUCheck(actions != nil, FUArrayNilMessage);
	
	for (id action in actions) {
		FUCheck([action conformsToProtocol:@protocol(FUAction)], FUActionProtocolMessage, action);
	}
	
	if ((self = [super init])) {
		[self setActions:actions];
	}
	
	return self;
}

#pragma mark - NSCopying Methods

- (id)copyWithZone:(NSZone*)zone
{
	FUSpawnAction* copy = [[self class] allocWithZone:zone];
	[copy setActions:[[NSArray alloc] initWithArray:[self actions] copyItems:YES]];
	return copy;
}

#pragma mark - FUAction Methods

- (NSTimeInterval)consumeDeltaTime:(NSTimeInterval)deltaTime
{
	if (deltaTime == 0.0) {
		return 0.0;
	}
	
	BOOL isForward = deltaTime > 0.0;
	NSTimeInterval lessTimeLeft = isForward ? DBL_MAX : -DBL_MAX;
	
	for (id<FUAction> action in [self actions]) {
		NSTimeInterval timeLeft = [action consumeDeltaTime:deltaTime];
		lessTimeLeft = isForward ? MIN(lessTimeLeft, timeLeft) : MAX(lessTimeLeft, timeLeft);
	}
	
	return lessTimeLeft;
}


@end
