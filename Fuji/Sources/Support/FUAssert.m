//
//  FUAssert.m
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUAssert.h"


static NSString* const FUTargetNilMessage = @"Expected target to not be nil";
static NSString* const FUKeyNilMessage = @"Expected key to not be nil or empty";
static NSString* const FUKeyImmutableMessage = @"Expected 'key=%@' on 'target=%@' to be mutable";


id FUValueForKey(id target, NSString* key)
{
	FUCheck(target != nil, FUTargetNilMessage);
	FUCheck(FUStringIsValid(key), FUKeyNilMessage);
	
	id currentValue = [target valueForKey:key];
	
	@try {
		[target setValue:currentValue forKey:key];
	}
	@catch (NSException*) {
		_FUThrow(NSInvalidArgumentException, FUKeyImmutableMessage, key, target);
	}
	
	return currentValue;
}