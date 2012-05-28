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
#import "FUGroupAction.h"


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

static OBJC_INLINE FUGroupAction* FUMoveTo(id target, NSTimeInterval duration, GLKVector2 toValue)
{
	return FUGroup(FUTweenTo(target, @"positionX", duration, [NSNumber numberWithFloat:toValue.x]),
				   FUTweenTo(target, @"positionY", duration, [NSNumber numberWithFloat:toValue.y]));
}

static OBJC_INLINE FUGroupAction* FUMoveFromTo(id target, NSTimeInterval duration, GLKVector2 fromValue, GLKVector2 toValue)
{
	return FUGroup(FUTweenFromTo(target, @"positionX", duration, [NSNumber numberWithFloat:fromValue.x], [NSNumber numberWithFloat:toValue.x]),
				   FUTweenFromTo(target, @"positionY", duration, [NSNumber numberWithFloat:fromValue.y], [NSNumber numberWithFloat:toValue.y]));
}

static OBJC_INLINE FUGroupAction* FUMoveBy(id target, NSTimeInterval duration, GLKVector2 byValue)
{
	return FUGroup(FUTweenBy(target, @"positionX", duration, [NSNumber numberWithFloat:byValue.x]),
				   FUTweenBy(target, @"positionY", duration, [NSNumber numberWithFloat:byValue.y]));
}

static OBJC_INLINE FUTweenAction* FURotateTo(id target, NSTimeInterval duration, float toValue)
{
	return FUTweenTo(target, @"rotation", duration, [NSNumber numberWithFloat:toValue]);
}

static OBJC_INLINE FUTweenAction* FURotateFromTo(id target, NSTimeInterval duration, float fromValue, float toValue)
{
	return FUTweenFromTo(target, @"rotation", duration, [NSNumber numberWithFloat:fromValue], [NSNumber numberWithFloat:toValue]);
}

static OBJC_INLINE FUTweenAction* FURotateBy(id target, NSTimeInterval duration, float byValue)
{
	return FUTweenBy(target, @"rotation", duration, [NSNumber numberWithFloat:byValue]);
}

static OBJC_INLINE FUGroupAction* FUScaleTo(id target, NSTimeInterval duration, GLKVector2 toValue)
{
	return FUGroup(FUTweenTo(target, @"scaleX", duration, [NSNumber numberWithFloat:toValue.x]),
				   FUTweenTo(target, @"scaleY", duration, [NSNumber numberWithFloat:toValue.y]));
}

static OBJC_INLINE FUGroupAction* FUScaleFromTo(id target, NSTimeInterval duration, GLKVector2 fromValue, GLKVector2 toValue)
{
	return FUGroup(FUTweenFromTo(target, @"scaleX", duration, [NSNumber numberWithFloat:fromValue.x], [NSNumber numberWithFloat:toValue.x]),
				   FUTweenFromTo(target, @"scaleY", duration, [NSNumber numberWithFloat:fromValue.y], [NSNumber numberWithFloat:toValue.y]));
}

static OBJC_INLINE FUGroupAction* FUScaleBy(id target, NSTimeInterval duration, GLKVector2 byValue)
{
	return FUGroup(FUTweenBy(target, @"scaleX", duration, [NSNumber numberWithFloat:byValue.x]),
				   FUTweenBy(target, @"scaleY", duration, [NSNumber numberWithFloat:byValue.y]));
}