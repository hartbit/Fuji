//
//  FUAssert.m
//  Fuji
//
//  Created by David Hart on 5/30/12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "FUAssert.h"


static NSString* const FUObjectNilMessage = @"Expected object to not be nil";
static NSString* const FUKeyNilMessage = @"Expected key to not be nil or empty";
static NSString* const FUKeyImmutableMessage = @"Expected 'key=%@' on 'object=%@' to be mutable";


id FUValueForKey(id object, NSString* key)
{
	FUCheck(object != nil, FUObjectNilMessage);
	FUCheck(FUStringIsValid(key), FUKeyNilMessage);
	
	id currentValue = [object valueForKey:key];
	
	@try {
		[object setValue:currentValue forKey:key];
	}
	@catch (NSException*) {
		_FUThrow(NSInvalidArgumentException, FUKeyImmutableMessage, key, object);
	}
	
	return currentValue;
}