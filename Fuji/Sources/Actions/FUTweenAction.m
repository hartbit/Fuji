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


static NSString* const FUObjectNilMessage = @"Expected object to not be nil";
static NSString* const FUPropertyNilMessage = @"Expected property to not be nil or empty";
static NSString* const FUFromValueNilMessage = @"Expected fromValue to not be nil";
static NSString* const FUToValueNilMessage = @"Expected toValue to not be nil";
static NSString* const FUByValueNilMessage = @"Expected byValue to not be nil";
static NSString* const FUPropertyUndefinedMessage = @"The 'property=%@' is not defined for 'object=%@'";
static NSString* const FUPropertyReadonlyMessage = @"Expected 'property=%@' on 'object=%@' to be readwrite but was readonly";


@interface FUTweenAction ()

@property (nonatomic, strong) id object;
@property (nonatomic, copy) NSString* property;
@property (nonatomic, strong) NSNumber* fromValue;
@property (nonatomic, strong) NSNumber* toValue;
@property (nonatomic, strong) NSNumber* byValue;

@end



@implementation FUTweenAction

@synthesize object = _object;
@synthesize property = _property;
@synthesize fromValue = _fromValue;
@synthesize toValue = _toValue;
@synthesize byValue = _byValue;

#pragma mark - Initialization

- (id)initWithObject:(id)object property:(NSString*)property toValue:(NSNumber*)toValue
{
	FUCheck(toValue != nil, FUToValueNilMessage);
	
	if ((self = [self initWithObject:object property:property])) {
		[self setToValue:toValue];
	}
	
	return self;
}

- (id)initWithObject:(id)object property:(NSString*)property fromValue:(NSNumber*)fromValue toValue:(NSNumber*)toValue
{
	FUCheck(fromValue != nil, FUFromValueNilMessage);
	FUCheck(toValue != nil, FUToValueNilMessage);

	if ((self = [self initWithObject:object property:property])) {
		[self setFromValue:fromValue];
		[self setToValue:toValue];
	}
	
	return self;
}

- (id)initWithObject:(id)object property:(NSString*)property byValue:(NSNumber*)byValue
{
	FUCheck(byValue != nil, FUByValueNilMessage);
	
	if ((self = [self initWithObject:object property:property])) {
		[self setByValue:byValue];
	}
	
	return self;
}

- (id)initWithObject:(id)object property:(NSString*)property
{
	FUCheck(object != nil, FUObjectNilMessage);
	FUCheck(FUStringIsValid(property), FUPropertyNilMessage);

#ifndef NS_BLOCK_ASSERTIONS
	NSNumber* currentValue;
	
	@try {
		currentValue = [object valueForKey:property];
	} @catch (NSException*) {
		_FUThrow(NSInvalidArgumentException, FUPropertyUndefinedMessage, property, object);
	}
	
	@try {
		[object setValue:currentValue forKey:property];
	}
	@catch (NSException* exception) {
		_FUThrow(NSInvalidArgumentException, FUPropertyReadonlyMessage, property, object);
	}
#endif
	
	if ((self = [super init])) {
		[self setObject:object];
		[self setProperty:property];
	}
	
	return self;
}

@end
