//
//  FUCallAction.h
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUTimedAction.h"


@interface FUCallAction : FUTimedAction

- (id)initWithBlock:(void (^)())block;

@end


static OBJC_INLINE FUCallAction* FUCall(void (^block)())
{
	return [[FUCallAction alloc] initWithBlock:block];
}

static OBJC_INLINE FUCallAction* FUToggle(id target, NSString* property)
{
	return FUCall(^{
		NSNumber* oldValue = [target valueForKey:property];
		NSNumber* newValue = [NSNumber numberWithBool:![oldValue boolValue]];
		[target setValue:newValue forKey:property];
	});
}

static OBJC_INLINE FUCallAction* FUSwitchOn(id target, NSString* property)
{
	return FUCall(^{ [target setValue:[NSNumber numberWithBool:YES] forKey:property]; });
}

static OBJC_INLINE FUCallAction* FUSwitchOff(id target, NSString* property)
{
	return FUCall(^{ [target setValue:[NSNumber numberWithBool:NO] forKey:property]; });
}

static OBJC_INLINE FUCallAction* FUToggleEnabled(id target)
{
	return FUToggle(target, @"enabled");
}

static OBJC_INLINE FUCallAction* FUEnable(id target)
{
	return FUSwitchOn(target, @"enabled");
}

static OBJC_INLINE FUCallAction* FUDisable(id target)
{
	return FUSwitchOff(target, @"enabled");
}