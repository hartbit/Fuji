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
#import "FUEntity-Internal.h"
#import "FUTransform.h"


static NSString* const FUBlockNullMessage = @"Expected block to not be NULL";
static NSString* const FUKeyNumericalMessage = @"Expected 'key=%@' on 'object=%@' to be of a numerical type";
static NSString* const FUKeyVector2Message = @"Excepcted 'key=%@' on 'object=%@' to be of type GLKVector2";
static NSString* const FUValueNilMessage = @"Expected value to not be nil";
static NSString* const FUAddendNilMessage = @"Expected addend to not be nil";
static NSString* const FUFactorNilMessage = @"Expected factor to not be nil";
static NSString* const FUObjectNilMessage = @"Expected object to not be nil";


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

FUTweenAction* FUTweenTo(NSTimeInterval duration, id object, NSString* key, NSNumber* value)
{
	FUCheck([FUValueForKey(object, key) isKindOfClass:[NSNumber class]], FUKeyNumericalMessage, key, object);
	FUCheck(value != nil, FUValueNilMessage);
	
	__block NSNumber* startValue = nil;
	__block double startDouble = 0.0;
	__block double difference = 0.0;
	
	return [[FUTweenAction alloc] initWithDuration:duration block:^(float t) {
		if (startValue == nil) {
			startValue = [object valueForKey:key];
			startDouble = [startValue doubleValue];
			difference = [value doubleValue] - startDouble;
		}
		
		double currentDouble = startDouble + t * difference;
		[object setValue:[NSNumber numberWithDouble:currentDouble] forKey:key];
	}];
}

FUTweenAction* FUTweenSum(NSTimeInterval duration, id object, NSString* key, NSNumber* addend)
{
	FUCheck([FUValueForKey(object, key) isKindOfClass:[NSNumber class]], FUKeyNumericalMessage, key, object);
	FUCheck(addend != nil, FUAddendNilMessage);
	
	__block NSNumber* startValue = nil;
	__block double startDouble = 0.0;
	double difference = [addend doubleValue];
	
	return [[FUTweenAction alloc] initWithDuration:duration block:^(float t) {
		if (startValue == nil) {
			startValue = [object valueForKey:key];
			startDouble = [startValue doubleValue];
		}
		
		double currentDouble = startDouble + t * difference;
		[object setValue:[NSNumber numberWithDouble:currentDouble] forKey:key];
	}];
}

FUTweenAction* FUTweenProduct(NSTimeInterval duration, id object, NSString* key, NSNumber* factor)
{
	FUCheck([FUValueForKey(object, key) isKindOfClass:[NSNumber class]], FUKeyNumericalMessage, key, object);
	FUCheck(factor != nil, FUFactorNilMessage);
	
	__block NSNumber* startValue = nil;
	__block double startDouble = 0.0;
	__block double difference = 0.0;
	
	return [[FUTweenAction alloc] initWithDuration:duration block:^(float t) {
		if (startValue == nil) {
			startValue = [object valueForKey:key];
			startDouble = [startValue doubleValue];
			difference = startDouble * ([factor doubleValue] - 1.0);
		}
		
		double currentDouble = startDouble + t * difference;
		[object setValue:[NSNumber numberWithDouble:currentDouble] forKey:key];
	}];
}

FUTweenAction* FUMoveTo(NSTimeInterval duration, id object, GLKVector2 position)
{
	FUCheck(object != nil, FUObjectNilMessage);
	
	id realObject = [object isKindOfClass:[FUEntity class]] ? [(FUEntity*)object transform] : object;
	
	__block BOOL hasStarted = NO;
	__block GLKVector2 startPosition;
	
	return [[FUTweenAction alloc] initWithDuration:duration block:^(float t) {
		if (!hasStarted) {
			startPosition = [(FUTransform*)realObject position];
			hasStarted = YES;
		}
		
		GLKVector2 currentPosition = GLKVector2Lerp(startPosition, position, t);
		[(FUTransform*)realObject setPosition:currentPosition];
	}];
}

FUTweenAction* FUMoveBy(NSTimeInterval duration, id object, GLKVector2 translation)
{
	return nil;
}

FUTweenAction* FURotateTo(NSTimeInterval duration, id object, float rotation)
{
	id realObject = [object isKindOfClass:[FUEntity class]] ? [(FUEntity*)object transform] : object;
	return FUTweenTo(duration, realObject, @"rotation", [NSNumber numberWithFloat:rotation]);
}

FUTweenAction* FURotateBy(NSTimeInterval duration, id object, float addend)
{
	id realObject = [object isKindOfClass:[FUEntity class]] ? [(FUEntity*)object transform] : object;
	return FUTweenSum(duration, realObject, @"rotation", [NSNumber numberWithFloat:addend]);
}
