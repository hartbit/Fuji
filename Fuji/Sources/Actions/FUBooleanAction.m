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


static OBJC_INLINE void FUValidateObjectAndKey(id object, NSString* key)
{
	
}


@interface FUBooleanAction ()

@property (nonatomic, WEAK) id object;
@property (nonatomic, copy) NSString* key;
@property (nonatomic) BOOL value;
@property (nonatomic, getter=isToggleEnabled) BOOL toggleEnabled;

@end


@implementation FUBooleanAction

@synthesize object = _object;
@synthesize key = _key;
@synthesize value = _value;
@synthesize toggleEnabled = _toggleEnabled;

#pragma mark - Class Methods

+ (void)validateObject:(id)object key:(NSString*)key
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
}

#pragma mark - Initialization

- (id)initWithObject:(id)object key:(NSString*)key
{
	[[self class] validateObject:object key:key];
	
	if ((self = [super initWithDuration:0.0f])) {
		[self setObject:object];
		[self setKey:key];
		[self setToggleEnabled:YES];
	}
	
	return self;
}

- (id)initWithObject:(id)object key:(NSString*)key value:(BOOL)value
{
	[[self class] validateObject:object key:key];
	
	if ((self = [super initWithDuration:0.0f])) {
		[self setObject:object];
		[self setKey:key];
		[self setValue:value];
	}
	
	return self;
}

#pragma mark - NSCopying Methods

- (id)copyWithZone:(NSZone*)zone
{
	return self;
}

#pragma mark - FUFiniteAction Methods

- (void)updateWithFactor:(float)factor
{
	id object = [self object];
	NSString* key = [self key];
	NSNumber* newValue = nil;
	
	if ([self isToggleEnabled]) {
		NSNumber* oldValue = [object valueForKey:key];
		newValue = [NSNumber numberWithBool:![oldValue boolValue]];
	} else {
		newValue = [NSNumber numberWithBool:[self value]];
	}
	
	[object setValue:newValue forKey:key];
}

@end
