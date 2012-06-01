//
//  FUCallAction.m
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUCallAction.h"
#import "FUAssert.h"


static NSString* const FUBlockNullMessage = @"Expected block to not be NULL";
static NSString* const FUKeyNumericalMessage = @"Expected 'key=%@' on 'object=%@' to be of a numerical type";
static NSString* const FUValueNilMessage = @"Expected value to not be nil";


@interface FUCallAction ()

@property (nonatomic, copy) FUCallBlock block;

@end


@implementation FUCallAction

@synthesize block = _block;

#pragma mark - Initialization

- (id)initWithBlock:(FUCallBlock)block
{
	FUCheck(block != NULL, FUBlockNullMessage);
	
	if ((self = [super initWithDuration:0.0])) {
		[self setBlock:block];
	}
	
	return self;
}

#pragma mark - NSCopying Methods

- (id)copyWithZone:(NSZone*)zone
{
	FUCallAction* copy = [super copyWithZone:zone];
	[copy setBlock:[self block]];
	return copy;
}

#pragma mark - FUTimedAction Methods

- (void)update
{
	[self block]();
}

@end


FUCallAction* FUCall(FUCallBlock block)
{
	return [[FUCallAction alloc] initWithBlock:block];
}

FUCallAction* FUToggle(id object, NSString* key)
{
	FUCheck([FUValueForKey(object, key) isKindOfClass:[NSNumber class]], FUKeyNumericalMessage, key, object);
	
	return FUCall(^{
		NSNumber* oldValue = [object valueForKey:key];
		NSNumber* newValue = [NSNumber numberWithBool:![oldValue boolValue]];
		[object setValue:newValue forKey:key];
	});
}

FUCallAction* FUSwitchOn(id object, NSString* key)
{
	FUCheck([FUValueForKey(object, key) isKindOfClass:[NSNumber class]], FUKeyNumericalMessage, key, object);
	
	return FUCall(^{
		[object setValue:[NSNumber numberWithBool:YES] forKey:key];
	});
}

FUCallAction* FUSwitchOff(id object, NSString* key)
{
	FUCheck([FUValueForKey(object, key) isKindOfClass:[NSNumber class]], FUKeyNumericalMessage, key, object);
	
	return FUCall(^{
		[object setValue:[NSNumber numberWithBool:NO] forKey:key];
	});
}

FUCallAction* FUToggleEnabled(id object)
{
	return FUToggle(object, @"enabled");
}

FUCallAction* FUEnable(id object)
{
	return FUSwitchOn(object, @"enabled");
}

FUCallAction* FUDisable(id object)
{
	return FUSwitchOff(object, @"enabled");
}
