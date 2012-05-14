//
//  FUBooleanAction.m
//  Fuji
//
//  Created by Hart David on 14.05.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "FUBooleanAction.h"


static NSString* const FUObjectNilMessage = @"Expected 'object' to not be nil";
static NSString* const FUKeyEmptyMessage = @"Expected 'key' to not be nil or empty";
static NSString* const FUKeyNonexistantMessage = @"The 'key=%@' does not exist on the 'object=%@'";
static NSString* const FUKeyWrongTypeMessage = @"Expected 'key=%@' on 'object=%@' to be of a numerical type";
static NSString* const FUKeyReadonlyMessage = @"The 'key=%@' on 'object=%@' is readonly";


@implementation FUBooleanAction

#pragma mark - Initialization

- (id)initWithObject:(id)object key:(NSString*)key value:(BOOL)value
{
	FUCheck(object != nil, FUObjectNilMessage);
	FUCheck(FUStringIsValid(key), FUKeyEmptyMessage);
	
	id currentValue;
	
	@try {
		currentValue = [object valueForKey:key];
	}
	@catch (NSException *exception) {
		_FUThrow(NSInvalidArgumentException, FUKeyNonexistantMessage, key, object);
	}
	
	FUCheck([currentValue isKindOfClass:[NSNumber class]], FUKeyWrongTypeMessage, key, object);
	
	@try {
		[object setValue:currentValue forKey:key];
	}
	@catch (NSException *exception) {
		_FUThrow(NSInvalidArgumentException, FUKeyReadonlyMessage, key, object);
	}
	
	if ((self = [super initWithDuration:0.0f])) {
	}
	
	return self;
}

@end
