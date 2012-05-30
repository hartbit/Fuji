//
//  FUTweenAction.m
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUTweenAction.h"


static NSString* const FUBlockNullMessage = @"Expected block to not be NULL";
static NSString* const FUTargetNilMessage = @"Expected target to not be nil";
static NSString* const FUPropertyNilMessage = @"Expected property to not be nil or empty";
static NSString* const FUToValueNilMessage = @"Expected toValue to not be nil";
static NSString* const FUByValueNilMessage = @"Expected byValue to not be nil";
static NSString* const FUPropertyUndefinedMessage = @"The 'property=%@' is not defined for 'object=%@'";
static NSString* const FUPropertyReadonlyMessage = @"Expected 'property=%@' on 'object=%@' to be readwrite but was readonly";


@interface FUTweenAction ()

@property (nonatomic, copy) FUTweenBlock block;

@end


@implementation FUTweenAction

@synthesize block = _block;

#pragma mark - Initialization

- (id)initWithDuration:(NSTimeInterval)duration block:(FUTweenBlock)block
{
	FUCheck(block != NULL, FUBlockNullMessage);
	
	if ((self = [super initWithDuration:duration])) {
		[self setBlock:block];
	}
	
	return self;
}

#pragma mark - NSCopying Methods

- (id)copyWithZone:(NSZone*)zone
{
	FUTweenAction* copy = [super copyWithZone:zone];
	[copy setBlock:[self block]];
	return copy;
}

#pragma mark - FUTimedAction Methods

- (void)update
{
	[self block]([self normalizedTime]);
}

@end


void FUCheckTargetAndProperty(id target, NSString* property)
{
	FUCheck(target != nil, FUTargetNilMessage);
	FUCheck(FUStringIsValid(property), FUPropertyNilMessage);
	
	NSNumber* currentValue;
	
	@try {
		currentValue = [target valueForKey:property];
	} @catch (NSException*) {
		_FUThrow(NSInvalidArgumentException, FUPropertyUndefinedMessage, property, target);
	}
	
	@try {
		[target setValue:currentValue forKey:property];
	}
	@catch (NSException*) {
		_FUThrow(NSInvalidArgumentException, FUPropertyReadonlyMessage, property, target);
	}
}

FUTweenAction* FUTween(NSTimeInterval duration, FUTweenBlock block)
{
	return [[FUTweenAction alloc] initWithDuration:duration block:block];
}

FUTweenAction* FUTweenTo(NSTimeInterval duration, id target, NSString* property, NSNumber* toValue)
{
#ifndef NS_BLOCK_ASSERTIONS
	FUCheckTargetAndProperty(target, property);
#endif
	FUCheck(toValue != nil, FUToValueNilMessage);
	
	__block NSNumber* fromValue = nil;
	__block double fromDouble = 0.0;
	__block double difference = 0.0;
	
	return [[FUTweenAction alloc] initWithDuration:duration block:^(float t) {
		if (fromValue == nil) {
			fromValue = [target valueForKey:property];
			fromDouble = [fromValue doubleValue];
			difference = [toValue doubleValue] - fromDouble;
		}
		
		double currentDouble = fromDouble + t * difference;
		[target setValue:[NSNumber numberWithDouble:currentDouble] forKey:property];
	}];
}

FUTweenAction* FUTweenBy(NSTimeInterval duration, id target, NSString* property, NSNumber* byValue)
{
#ifndef NS_BLOCK_ASSERTIONS
	FUCheckTargetAndProperty(target, property);
#endif
	FUCheck(byValue != nil, FUByValueNilMessage);
	
	__block NSNumber* fromValue = nil;
	__block double fromDouble = 0.0;
	double difference = [byValue doubleValue];
	
	return [[FUTweenAction alloc] initWithDuration:duration block:^(float t) {
		if (fromValue == nil) {
			fromValue = [target valueForKey:property];
			fromDouble = [fromValue doubleValue];
		}
		
		double currentDouble = fromDouble + t * difference;
		[target setValue:[NSNumber numberWithDouble:currentDouble] forKey:property];
	}];
}

FUTweenAction* FURotateTo(NSTimeInterval duration, id target, float toRotation)
{
	return FUTweenTo(duration, target, @"rotation", [NSNumber numberWithFloat:toRotation]);
}

FUTweenAction* FURotateBy(NSTimeInterval duration, id target, float byRotation)
{
	return FUTweenBy(duration, target, @"rotation", [NSNumber numberWithFloat:byRotation]);
}
