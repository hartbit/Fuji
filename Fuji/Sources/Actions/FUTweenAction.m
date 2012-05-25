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
	FUCheck(object != nil, FUObjectNilMessage);
	FUCheck(FUStringIsValid(property), FUPropertyNilMessage);
	FUCheck(toValue != nil, FUToValueNilMessage);
	return nil;
}

- (id)initWithObject:(id)object property:(NSString*)property fromValue:(NSNumber*)fromValue toValue:(NSNumber*)toValue
{
	FUCheck(object != nil, FUObjectNilMessage);
	FUCheck(FUStringIsValid(property), FUPropertyNilMessage);
	FUCheck(fromValue != nil, FUFromValueNilMessage);
	FUCheck(toValue != nil, FUToValueNilMessage);
	return nil;
}

- (id)initWithObject:(id)object property:(NSString*)property byValue:(NSNumber*)byValue
{
	FUCheck(object != nil, FUObjectNilMessage);
	FUCheck(FUStringIsValid(property), FUPropertyNilMessage);
	FUCheck(byValue != nil, FUByValueNilMessage);
	return nil;
}

@end
