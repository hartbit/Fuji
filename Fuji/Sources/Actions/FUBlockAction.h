//
//  FUBlockAction.h
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUTimedAction.h"


@interface FUBlockAction : FUTimedAction

- (id)initWithBlock:(void (^)())block;

@end


static OBJC_INLINE FUBlockAction* FUBlock(void (^block)())
{
	return [[FUBlockAction alloc] initWithBlock:block];
}

static OBJC_INLINE FUBlockAction* FUToggle(id target, NSString* property)
{
	return FUBlock(^{
		NSNumber* oldValue = [target valueForKey:property];
		NSNumber* newValue = [NSNumber numberWithBool:![oldValue boolValue]];
		[target setValue:newValue forKey:property];
	});
}

static OBJC_INLINE FUBlockAction* FUSwitchOn(id target, NSString* property)
{
	return FUBlock(^{ [target setValue:[NSNumber numberWithBool:YES] forKey:property]; });
}

static OBJC_INLINE FUBlockAction* FUSwitchOff(id target, NSString* property)
{
	return FUBlock(^{ [target setValue:[NSNumber numberWithBool:NO] forKey:property]; });
}

static OBJC_INLINE FUBlockAction* FUToggleEnabled(id target)
{
	return FUToggle(target, @"enabled");
}

static OBJC_INLINE FUBlockAction* FUEnable(id target)
{
	return FUSwitchOn(target, @"enabled");
}

static OBJC_INLINE FUBlockAction* FUDisable(id target)
{
	return FUSwitchOff(target, @"enabled");
}