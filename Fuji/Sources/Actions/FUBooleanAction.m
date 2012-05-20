//
//  FUBooleanAction.m
//  Fuji
//
//  Created by Hart David on 14.05.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "FUBooleanAction.h"


static NSString* const FUObjectNilMessage = @"Expected 'object' to not be nil";
static NSString* const FUPropEmptyMessage = @"Expected 'property' to not be nil or empty";
static NSString* const FUPropNonexistantMessage = @"The 'property=%@' does not exist on the 'object=%@'";
static NSString* const FUPropWrongTypeMessage = @"Expected 'property=%@' on 'object=%@' to be of a numerical type";
static NSString* const FUPropReadonlyMessage = @"The 'property=%@' on 'object=%@' is readonly";


@interface FUBooleanAction ()

@property (nonatomic, WEAK) id object;
@property (nonatomic, copy) NSString* property;
@property (nonatomic, getter=isToggleEnabled) BOOL toggleEnabled;
@property (nonatomic) BOOL value;

@end


@implementation FUBooleanAction

@synthesize object = _object;
@synthesize property = _property;
@synthesize toggleEnabled = _toggleEnabled;
@synthesize value = _value;

#pragma mark - Class Methods

+ (void)validateObject:(id)object property:(NSString*)property
{
	FUCheck(object != nil, FUObjectNilMessage);
	FUCheck(FUStringIsValid(property), FUPropEmptyMessage);
	
	id currentValue;
	
	@try {
		currentValue = [object valueForKey:property];
	}
	@catch (NSException *exception) {
		_FUThrow(NSInvalidArgumentException, FUPropNonexistantMessage, property, object);
	}
	
	FUCheck([currentValue isKindOfClass:[NSNumber class]], FUPropWrongTypeMessage, property, object);
	
	@try {
		[object setValue:currentValue forKey:property];
	}
	@catch (NSException *exception) {
		_FUThrow(NSInvalidArgumentException, FUPropReadonlyMessage, property, object);
	}
}

#pragma mark - Initialization

- (id)initWithObject:(id)object property:(NSString*)property
{
	[[self class] validateObject:object property:property];
	
	if ((self = [super initWithDuration:0.0f])) {
		[self setObject:object];
		[self setProperty:property];
		[self setToggleEnabled:YES];
	}
	
	return self;
}

- (id)initWithObject:(id)object property:(NSString*)property value:(BOOL)value
{
	[[self class] validateObject:object property:property];
	
	if ((self = [super initWithDuration:0.0f])) {
		[self setObject:object];
		[self setProperty:property];
		[self setValue:value];
	}
	
	return self;
}

#pragma mark - NSCopying Methods

- (id)copyWithZone:(NSZone*)zone
{
	FUBooleanAction* copy = [super copyWithZone:zone];
	[copy setObject:[self object]];
	[copy setProperty:[self property]];
	[copy setToggleEnabled:[self isToggleEnabled]];
	[copy setValue:[self value]];
	return copy;
}

#pragma mark - FUFiniteAction Methods

- (void)updateWithFactor:(float)factor
{
	id object = [self object];
	NSString* property = [self property];
	NSNumber* newValue = nil;
	
	if ([self isToggleEnabled]) {
		NSNumber* oldValue = [object valueForKey:property];
		newValue = [NSNumber numberWithBool:![oldValue boolValue]];
	} else {
		newValue = [NSNumber numberWithBool:[self value]];
	}
	
	[object setValue:newValue forKey:property];
}

@end
