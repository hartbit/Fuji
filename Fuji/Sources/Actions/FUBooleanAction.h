//
//  FUBooleanAction.h
//  Fuji
//
//  Created by Hart David on 14.05.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "FUFiniteAction.h"

@interface FUBooleanAction : FUFiniteAction

- (id)initWithObject:(id)object key:(NSString*)key;
- (id)initWithObject:(id)object key:(NSString*)key value:(BOOL)value;

@end


static OBJC_INLINE FUBooleanAction* FUToggle(id object, NSString* key)
{
	return [[FUBooleanAction alloc] initWithObject:object key:key];
}

static OBJC_INLINE FUBooleanAction* FUEnable(id object, NSString* key)
{
	return [[FUBooleanAction alloc] initWithObject:object key:key value:YES];
}

static OBJC_INLINE FUBooleanAction* FUDisable(id object, NSString* key)
{
	return [[FUBooleanAction alloc] initWithObject:object key:key value:NO];
}