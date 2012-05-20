//
//  FUBooleanAction.h
//  Fuji
//
//  Created by Hart David on 14.05.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "FUFiniteAction.h"

@interface FUBooleanAction : FUFiniteAction

- (id)initWithObject:(id)object property:(NSString*)property;
- (id)initWithObject:(id)object property:(NSString*)property value:(BOOL)value;

@end


static OBJC_INLINE FUBooleanAction* FUToggle(id object, NSString* property)
{
	return [[FUBooleanAction alloc] initWithObject:object property:property];
}

static OBJC_INLINE FUBooleanAction* FUSwitchOn(id object, NSString* property)
{
	return [[FUBooleanAction alloc] initWithObject:object property:property value:YES];
}

static OBJC_INLINE FUBooleanAction* FUSwitchOff(id object, NSString* property)
{
	return [[FUBooleanAction alloc] initWithObject:object property:property value:NO];
}

static OBJC_INLINE FUBooleanAction* FUToggleEnabled(id object)
{
	return FUToggle(object, @"enabled");
}

static OBJC_INLINE FUBooleanAction* FUEnable(id object)
{
	return FUSwitchOn(object, @"enabled");
}

static OBJC_INLINE FUBooleanAction* FUDisable(id object)
{
	return FUSwitchOff(object, @"enabled");
}