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


static NSString* const FUTargetNilMessage = @"Expected target to not be nil";
static NSString* const FUPropertyNilMessage = @"Expected property to not be nil or empty";
static NSString* const FUFromValueNilMessage = @"Expected fromValue to not be nil";
static NSString* const FUToValueNilMessage = @"Expected toValue to not be nil";
static NSString* const FUByValueNilMessage = @"Expected byValue to not be nil";
static NSString* const FUPropertyUndefinedMessage = @"The 'property=%@' is not defined for 'object=%@'";
static NSString* const FUPropertyReadonlyMessage = @"Expected 'property=%@' on 'object=%@' to be readwrite but was readonly";


@interface FUTweenAction ()

@property (nonatomic, strong) id target;
@property (nonatomic, copy) NSString* property;
@property (nonatomic, strong) NSNumber* fromValue;
@property (nonatomic, strong) NSNumber* toValue;
@property (nonatomic, strong) NSNumber* byValue;

@end



@implementation FUTweenAction

@synthesize target = _target;
@synthesize property = _property;
@synthesize fromValue = _fromValue;
@synthesize toValue = _toValue;
@synthesize byValue = _byValue;

#pragma mark - Initialization

- (id)initWithTarget:(id)target property:(NSString*)property duration:(NSTimeInterval)duration toValue:(NSNumber*)toValue
{
	FUCheck(toValue != nil, FUToValueNilMessage);
	
	if ((self = [self initWithTarget:target property:property duration:duration])) {
		[self setToValue:toValue];
	}
	
	return self;
}

- (id)initWithTarget:(id)target property:(NSString*)property duration:(NSTimeInterval)duration fromValue:(NSNumber*)fromValue toValue:(NSNumber*)toValue
{
	FUCheck(fromValue != nil, FUFromValueNilMessage);
	FUCheck(toValue != nil, FUToValueNilMessage);

	if ((self = [self initWithTarget:target property:property duration:duration])) {
		[self setFromValue:fromValue];
		[self setToValue:toValue];
	}
	
	return self;
}

- (id)initWithTarget:(id)target property:(NSString*)property duration:(NSTimeInterval)duration byValue:(NSNumber*)byValue
{
	FUCheck(byValue != nil, FUByValueNilMessage);
	
	if ((self = [self initWithTarget:target property:property duration:duration])) {
		[self setByValue:byValue];
	}
	
	return self;
}

- (id)initWithTarget:(id)target property:(NSString*)property duration:(NSTimeInterval)duration
{
	FUCheck(target != nil, FUTargetNilMessage);
	FUCheck(FUStringIsValid(property), FUPropertyNilMessage);

#ifndef NS_BLOCK_ASSERTIONS
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
#endif
	
	if ((self = [super initWithDuration:duration])) {
		[self setTarget:target];
		[self setProperty:property];
	}
	
	return self;
}

#pragma mark - NSCopying Methods

- (id)copyWithZone:(NSZone*)zone
{
	FUTweenAction* copy = [super copyWithZone:zone];
	[copy setTarget:[self target]];
	[copy setProperty:[self property]];
	[copy setFromValue:[self fromValue]];
	[copy setToValue:[self toValue]];
	[copy setByValue:[self byValue]];
	return copy;
}

#pragma mark - FUTimedAction

- (void)update
{
	id target = [self target];
	NSString* property = [self property];
	NSNumber* fromValue = [self fromValue];
	NSNumber* toValue = [self toValue];
	
	if (fromValue == nil) {
		fromValue = [target valueForKey:property];
		[self setFromValue:fromValue];
	}
	
	double fromDouble = [fromValue doubleValue];
	
	if (toValue == nil) {
		double byDouble = [[self byValue] doubleValue];
		toValue = [NSNumber numberWithDouble:fromDouble + byDouble];
		[self setToValue:toValue];
	}
	
	double toDouble = [toValue doubleValue];
	double currentDouble = fromDouble + [self factor] * (toDouble - fromDouble);
	[target setValue:[NSNumber numberWithDouble:currentDouble] forKey:property];
}

@end
