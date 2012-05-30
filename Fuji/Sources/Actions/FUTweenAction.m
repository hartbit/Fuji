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
#import "FUAssert.h"


static NSString* const FUBlockNullMessage = @"Expected block to not be NULL";
static NSString* const FUValueNilMessage = @"Expected value to not be nil";
static NSString* const FUAddendNilMessage = @"Expected addend to not be nil";
static NSString* const FUFactorNilMessage = @"Expected factor to not be nil";


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


FUTweenAction* FUTween(NSTimeInterval duration, FUTweenBlock block)
{
	return [[FUTweenAction alloc] initWithDuration:duration block:block];
}

FUTweenAction* FUTweenTo(NSTimeInterval duration, id target, NSString* property, NSNumber* value)
{
	FUCheckTargetAndProperty(target, property);
	FUCheck(value != nil, FUValueNilMessage);
	
	__block NSNumber* startValue = nil;
	__block double startDouble = 0.0;
	__block double difference = 0.0;
	
	return [[FUTweenAction alloc] initWithDuration:duration block:^(float t) {
		if (startValue == nil) {
			startValue = [target valueForKey:property];
			startDouble = [startValue doubleValue];
			difference = [value doubleValue] - startDouble;
		}
		
		double currentDouble = startDouble + t * difference;
		[target setValue:[NSNumber numberWithDouble:currentDouble] forKey:property];
	}];
}

FUTweenAction* FUTweenSum(NSTimeInterval duration, id target, NSString* property, NSNumber* addend)
{
	FUCheckTargetAndProperty(target, property);
	FUCheck(addend != nil, FUAddendNilMessage);
	
	__block NSNumber* startValue = nil;
	__block double startDouble = 0.0;
	double difference = [addend doubleValue];
	
	return [[FUTweenAction alloc] initWithDuration:duration block:^(float t) {
		if (startValue == nil) {
			startValue = [target valueForKey:property];
			startDouble = [startValue doubleValue];
		}
		
		double currentDouble = startDouble + t * difference;
		[target setValue:[NSNumber numberWithDouble:currentDouble] forKey:property];
	}];
}

FUTweenAction* FUTweenProduct(NSTimeInterval duration, id target, NSString* property, NSNumber* factor)
{
	FUCheckTargetAndProperty(target, property);
	FUCheck(factor != nil, FUFactorNilMessage);
	
	__block NSNumber* startValue = nil;
	__block double startDouble = 0.0;
	__block double difference = 0.0;
	
	return [[FUTweenAction alloc] initWithDuration:duration block:^(float t) {
		if (startValue == nil) {
			startValue = [target valueForKey:property];
			startDouble = [startValue doubleValue];
			difference = startDouble * ([factor doubleValue] - 1.0);
		}
		
		double currentDouble = startDouble + t * difference;
		[target setValue:[NSNumber numberWithDouble:currentDouble] forKey:property];
	}];
}

FUTweenAction* FURotateTo(NSTimeInterval duration, id target, float rotation)
{
	return FUTweenTo(duration, target, @"rotation", [NSNumber numberWithFloat:rotation]);
}

FUTweenAction* FURotateBy(NSTimeInterval duration, id target, float addend)
{
	return FUTweenSum(duration, target, @"rotation", [NSNumber numberWithFloat:addend]);
}
