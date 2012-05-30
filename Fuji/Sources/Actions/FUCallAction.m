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

FUCallAction* FUToggle(id target, NSString* property)
{
	FUCheckTargetAndProperty(target, property);
	
	return FUCall(^{
		NSNumber* oldValue = [target valueForKey:property];
		NSNumber* newValue = [NSNumber numberWithBool:![oldValue boolValue]];
		[target setValue:newValue forKey:property];
	});
}

FUCallAction* FUSwitchOn(id target, NSString* property)
{
	FUCheckTargetAndProperty(target, property);
	
	return FUCall(^{
		[target setValue:[NSNumber numberWithBool:YES] forKey:property];
	});
}

FUCallAction* FUSwitchOff(id target, NSString* property)
{
	FUCheckTargetAndProperty(target, property);
	
	return FUCall(^{
		[target setValue:[NSNumber numberWithBool:NO] forKey:property];
	});
}

FUCallAction* FUToggleEnabled(id target)
{
	return FUToggle(target, @"enabled");
}

FUCallAction* FUEnable(id target)
{
	return FUSwitchOn(target, @"enabled");
}

FUCallAction* FUDisable(id target)
{
	return FUSwitchOff(target, @"enabled");
}
