//
//  FUAssert.m
//  Fuji
//
//  Created by David Hart on 5/30/12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "FUAssert.h"


static NSString* const FUTargetNilMessage = @"Expected target to not be nil";
static NSString* const FUPropertyNilMessage = @"Expected property to not be nil or empty";
static NSString* const FUPropertyUndefinedMessage = @"The 'property=%@' is not defined for 'object=%@'";
static NSString* const FUPropertyNumericalMessage = @"Expected 'property=%@' on 'object=%@' to be of a numerical type";
static NSString* const FUPropertyReadonlyMessage = @"Expected 'property=%@' on 'object=%@' to be readwrite but was readonly";


void FUCheckTargetAndProperty(id target, NSString* property)
{
	FUCheck(target != nil, FUTargetNilMessage);
	FUCheck(FUStringIsValid(property), FUPropertyNilMessage);
	
	NSNumber* currentValue;
	
	@try {
		currentValue = [target valueForKey:property];
	} @catch (NSException*) {
		_FUThrow(NSInvalidArgumentException, FUPropertyUndefinedMessage, property, target);
	}
	
	FUCheck([currentValue isKindOfClass:[NSNumber class]], FUPropertyNumericalMessage, property, target);
	
	@try {
		[target setValue:currentValue forKey:property];
	}
	@catch (NSException*) {
		_FUThrow(NSInvalidArgumentException, FUPropertyReadonlyMessage, property, target);
	}
}