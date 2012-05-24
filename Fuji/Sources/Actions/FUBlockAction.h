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

#import "FUFiniteAction.h"


@interface FUBlockAction : NSObject<FUAction>

- (id)initWithBlock:(void (^)())block;

@end


static OBJC_INLINE FUBlockAction* FUBlock(void (^block)())
{
	return [[FUBlockAction alloc] initWithBlock:block];
}

static OBJC_INLINE FUBlockAction* FUToggle(id object, NSString* property)
{
	return FUBlock(^{
		NSNumber* oldValue = [object valueForKey:property];
		NSNumber* newValue = [NSNumber numberWithBool:![oldValue boolValue]];
		[object setValue:newValue forKey:property];
	});
}

static OBJC_INLINE FUBlockAction* FUSwitchOn(id object, NSString* property)
{
	return FUBlock(^{ [object setValue:[NSNumber numberWithBool:YES] forKey:property]; });
}

static OBJC_INLINE FUBlockAction* FUSwitchOff(id object, NSString* property)
{
	return FUBlock(^{ [object setValue:[NSNumber numberWithBool:NO] forKey:property]; });
}

static OBJC_INLINE FUBlockAction* FUToggleEnabled(id object)
{
	return FUToggle(object, @"enabled");
}

static OBJC_INLINE FUBlockAction* FUEnable(id object)
{
	return FUSwitchOn(object, @"enabled");
}

static OBJC_INLINE FUBlockAction* FUDisable(id object)
{
	return FUSwitchOff(object, @"enabled");
}