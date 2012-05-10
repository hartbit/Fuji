//
//  FUSpeedAction.m
//  Fuji
//
//  Created by Hart David on 10.05.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
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

+ (FUSpeedAction*)actionWithAction:(id<FUAction>)action
{
	return [[self alloc] initWithAction:action speed:1.0];
}

+ (FUSpeedAction*)actionWithAction:(id<FUAction>)action speed:(float)speed
{
	return [[self alloc] initWithAction:action speed:speed];	
}

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
