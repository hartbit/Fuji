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
#import "FURenderer.h"


static NSString* const FUBlockNullMessage = @"Expected block to not be NULL";
static NSString* const FUKeyNumericalMessage = @"Expected 'key=%@' on 'target=%@' to be of a numerical type";
static NSString* const FUKeyVector2Message = @"Excepcted 'key=%@' on 'target=%@' to be of type GLKVector2";
static NSString* const FUValueNilMessage = @"Expected value to not be nil";
static NSString* const FUAddendNilMessage = @"Expected addend to not be nil";
static NSString* const FUFactorNilMessage = @"Expected factor to not be nil";
static NSString* const FUTargetNilMessage = @"Expected target to not be nil";


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

FUTweenAction* FUTweenTo(NSTimeInterval duration, id target, NSString* key, NSNumber* value)
{
	FUCheck([FUValueForKey(target, key) isKindOfClass:[NSNumber class]], FUKeyNumericalMessage, key, target);
	FUCheck(value != nil, FUValueNilMessage);
	
	__block BOOL hasStarted = NO;
	__block double startDouble = 0.0;
	__block double difference = 0.0;
	
	return [[FUTweenAction alloc] initWithDuration:duration block:^(float t) {
		if (!hasStarted) {
			startDouble = [[target valueForKey:key] doubleValue];
			difference = [value doubleValue] - startDouble;
			hasStarted = YES;
		}
		
		double currentDouble = startDouble + t * difference;
		[target setValue:[NSNumber numberWithDouble:currentDouble] forKey:key];
	}];
}

FUTweenAction* FUTweenSum(NSTimeInterval duration, id target, NSString* key, NSNumber* addend)
{
	FUCheck([FUValueForKey(target, key) isKindOfClass:[NSNumber class]], FUKeyNumericalMessage, key, target);
	FUCheck(addend != nil, FUAddendNilMessage);
	
	__block BOOL hasStarted = NO;
	__block double startDouble = 0.0;
	double difference = [addend doubleValue];
	
	return [[FUTweenAction alloc] initWithDuration:duration block:^(float t) {
		if (!hasStarted) {
			startDouble = [[target valueForKey:key] doubleValue];
			hasStarted = YES;
		}
		
		double currentDouble = startDouble + t * difference;
		[target setValue:[NSNumber numberWithDouble:currentDouble] forKey:key];
	}];
}

FUTweenAction* FUTweenProduct(NSTimeInterval duration, id target, NSString* key, NSNumber* factor)
{
	FUCheck([FUValueForKey(target, key) isKindOfClass:[NSNumber class]], FUKeyNumericalMessage, key, target);
	FUCheck(factor != nil, FUFactorNilMessage);
	
	__block BOOL hasStarted = NO;
	__block double startDouble = 0.0;
	__block double difference = 0.0;
	
	return [[FUTweenAction alloc] initWithDuration:duration block:^(float t) {
		if (!hasStarted) {
			startDouble = [[target valueForKey:key] doubleValue];
			difference = startDouble * ([factor doubleValue] - 1.0);
			hasStarted = YES;
		}
		
		double currentDouble = startDouble + t * difference;
		[target setValue:[NSNumber numberWithDouble:currentDouble] forKey:key];
	}];
}

static id OBJC_INLINE FUTransformTarget(id target)
{
	if ([target isKindOfClass:[FUEntity class]]) {
		return [(FUEntity*)target transform];
	} else {
		return target;
	}
}

FUTweenAction* FUMoveTo(NSTimeInterval duration, id target, GLKVector2 position)
{
	FUCheck(target != nil, FUTargetNilMessage);
	
	id realTarget = FUTransformTarget(target);
	
	__block BOOL hasStarted = NO;
	__block GLKVector2 startPosition;
	
	return [[FUTweenAction alloc] initWithDuration:duration block:^(float t) {
		if (!hasStarted) {
			startPosition = [(FUTransform*)realTarget position];
			hasStarted = YES;
		}
		
		GLKVector2 currentPosition = GLKVector2Lerp(startPosition, position, t);
		[(FUTransform*)realTarget setPosition:currentPosition];
	}];
}

FUTweenAction* FUMoveBy(NSTimeInterval duration, id target, GLKVector2 translation)
{
	FUCheck(target != nil, FUTargetNilMessage);
	
	id realTarget = FUTransformTarget(target);
	
	__block BOOL hasStarted = NO;
	__block GLKVector2 startPosition;
	__block GLKVector2 endPosition;
	
	return [[FUTweenAction alloc] initWithDuration:duration block:^(float t) {
		if (!hasStarted) {
			startPosition = [(FUTransform*)realTarget position];
			endPosition = GLKVector2Add(startPosition, translation);
			hasStarted = YES;
		}
		
		GLKVector2 currentPosition = GLKVector2Lerp(startPosition, endPosition, t);
		[(FUTransform*)realTarget setPosition:currentPosition];
	}];
}

FUTweenAction* FURotateTo(NSTimeInterval duration, id target, float rotation)
{
	return FUTweenTo(duration, FUTransformTarget(target), @"rotation", [NSNumber numberWithFloat:rotation]);
}

FUTweenAction* FURotateBy(NSTimeInterval duration, id target, float addend)
{
	return FUTweenSum(duration, FUTransformTarget(target), @"rotation", [NSNumber numberWithFloat:addend]);
}

FUTweenAction* FUScaleTo(NSTimeInterval duration, id target, GLKVector2 scale)
{
	FUCheck(target != nil, FUTargetNilMessage);
	
	id realTarget = FUTransformTarget(target);
	
	__block BOOL hasStarted = NO;
	__block GLKVector2 startScale;
	
	return [[FUTweenAction alloc] initWithDuration:duration block:^(float t) {
		if (!hasStarted) {
			startScale = [(FUTransform*)realTarget scale];
			hasStarted = YES;
		}
		
		GLKVector2 currentScale = GLKVector2Lerp(startScale, scale, t);
		[(FUTransform*)realTarget setScale:currentScale];
	}];
}

FUTweenAction* FUScaleBy(NSTimeInterval duration, id target, GLKVector2 factor)
{
	FUCheck(target != nil, FUTargetNilMessage);
	
	id realTarget = FUTransformTarget(target);
	
	__block BOOL hasStarted = NO;
	__block GLKVector2 startScale;
	__block GLKVector2 endScale;
	
	return [[FUTweenAction alloc] initWithDuration:duration block:^(float t) {
		if (!hasStarted) {
			startScale = [(FUTransform*)realTarget scale];
			endScale = GLKVector2Multiply(startScale, factor);
			hasStarted = YES;
		}
		
		GLKVector2 currentScale = GLKVector2Lerp(startScale, endScale, t);
		[(FUTransform*)realTarget setScale:currentScale];
	}];
}

static OBJC_INLINE FURenderer* FURendererTarget(id target)
{
	if ([target isKindOfClass:[FUEntity class]]) {
		return [(FUEntity*)target renderer];
	} else {
		return target;
	}
}

FUTweenAction* FUTintTo(NSTimeInterval duration, id target, GLKVector4 color)
{
	FUCheck(target != nil, FUTargetNilMessage);
	
	FURenderer* realTarget = FURendererTarget(target);
	
	__block BOOL hasStarted = NO;
	__block GLKVector4 startColor;
	
	return [[FUTweenAction alloc] initWithDuration:duration block:^(float t) {
		if (!hasStarted) {
			startColor = [realTarget tint];
			hasStarted = YES;
		}
		
		GLKVector4 currentColor = GLKVector4Lerp(startColor, color, t);
		[realTarget setTint:currentColor];
	}];
}

FUTweenAction* FUTintBy(NSTimeInterval duration, id target, GLKVector4 factor)
{
	FUCheck(target != nil, FUTargetNilMessage);
	
	FURenderer* realTarget = FURendererTarget(target);
	
	__block BOOL hasStarted = NO;
	__block GLKVector4 startColor;
	__block GLKVector4 endColor;
	
	return [[FUTweenAction alloc] initWithDuration:duration block:^(float t) {
		if (!hasStarted) {
			startColor = [realTarget tint];
			endColor = GLKVector4Multiply(startColor, factor);
			hasStarted = YES;
		}
		
		GLKVector4 currentColor = GLKVector4Lerp(startColor, endColor, t);
		[realTarget setTint:currentColor];
	}];
}
