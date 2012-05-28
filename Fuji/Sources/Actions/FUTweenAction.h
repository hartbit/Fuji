//
//  FUTweenAction.h
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUTimedAction.h"


@interface FUTweenAction : FUTimedAction

- (id)initWithTarget:(id)target property:(NSString*)property duration:(NSTimeInterval)duration toValue:(NSNumber*)toValue;
- (id)initWithTarget:(id)target property:(NSString*)property duration:(NSTimeInterval)duration fromValue:(NSNumber*)fromValue toValue:(NSNumber*)toValue;
- (id)initWithTarget:(id)target property:(NSString*)property duration:(NSTimeInterval)duration byValue:(NSNumber*)byValue;

@property (nonatomic, strong, readonly) id target;
@property (nonatomic, copy, readonly) NSString* property;
@property (nonatomic, strong, readonly) NSNumber* fromValue;
@property (nonatomic, strong, readonly) NSNumber* toValue;

@end


static OBJC_INLINE FUTweenAction* FUTweenTo(id target, NSString* property, NSTimeInterval duration, NSNumber* toValue)
{
	return [[FUTweenAction alloc] initWithTarget:target property:property duration:duration toValue:toValue];
}

static OBJC_INLINE FUTweenAction* FUTweenFromTo(id target, NSString* property, NSTimeInterval duration, NSNumber* fromValue, NSNumber* toValue)
{
	return [[FUTweenAction alloc] initWithTarget:target property:property duration:duration fromValue:fromValue toValue:toValue];
}

static OBJC_INLINE FUTweenAction* FUTweenBy(id target, NSString* property, NSTimeInterval duration, NSNumber* byValue)
{
	return [[FUTweenAction alloc] initWithTarget:target property:property duration:duration byValue:byValue];
}