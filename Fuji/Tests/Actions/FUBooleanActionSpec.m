//
//  FUBooleanActionSpec.m
//  Fuji
//
//  Created by David Hart
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#include "Prefix.pch"
#import "Fuji.h"
#import "FUTestSupport.h"


static NSString* const FUObjectNilMessage = @"Expected 'object' to not be nil";
static NSString* const FUPropEmptyMessage = @"Expected 'property' to not be nil or empty";
static NSString* const FUPropNonexistantMessage = @"The 'property=%@' does not exist on the 'object=%@'";
static NSString* const FUPropWrongTypeMessage = @"Expected 'property=%@' on 'object=%@' to be of a numerical type";
static NSString* const FUPropReadonlyMessage = @"The 'property=%@' on 'object=%@' is readonly";


#define FUTestBoolSetsValue(prop, value) \
	it(@"is not nil", ^{ \
		expect(action).toNot.beNil(); \
	}); \
	\
	context(@"updated the action", ^{ \
		beforeEach(^{ \
			[object setValue:[NSNumber numberWithBool:!value] forKey:prop]; \
			[action updateWithFactor:0.0f]; \
		}); \
		\
		it([NSString stringWithFormat:@"sets %@ to %@", prop, FUStringFromBool(value)], ^{ \
			expect([object valueForKey:prop]).to.equal(value); \
		}); \
		\
		context(@"updated the action", ^{ \
			beforeEach(^{ \
				[action updateWithFactor:0.0f]; \
			}); \
			\
			it([NSString stringWithFormat:@"still has %@ to %@", prop, FUStringFromBool(value)], ^{ \
				expect([object valueForKey:prop]).to.equal(value); \
			}); \
		}); \
	});

#define FUTestBoolTogglesValue(prop) \
	it(@"is not nil", ^{ \
		expect(action).toNot.beNil(); \
	}); \
	\
	context(@"updated the action", ^{ \
		beforeEach(^{ \
			[object setValue:[NSNumber numberWithBool:NO] forKey:prop]; \
			[action updateWithFactor:0.0f]; \
		}); \
		\
		it([NSString stringWithFormat:@"sets %@ to YES", prop], ^{ \
			expect([object valueForKey:prop]).to.beTruthy(); \
		}); \
		\
		context(@"updating the action", ^{ \
			it([NSString stringWithFormat:@"sets %@ to NO", prop], ^{ \
				[action updateWithFactor:0.0f]; \
				expect([object valueForKey:prop]).to.beFalsy(); \
			}); \
		}); \
	});

@interface FUTestObject : NSObject
@property (nonatomic, getter=isEnabled) BOOL enabled;
@end


SPEC_BEGIN(FUBooleanAction)

describe(@"A boolean action", ^{
	it(@"is a finite action", ^{
		expect([FUBooleanAction class]).to.beSubclassOf([FUFiniteAction class]);
	});
	
	context(@"initializing with a nil object, valid property and value", ^{
		it(@"throws an exception", ^{
			assertThrows([[FUBooleanAction alloc] initWithObject:nil property:@"property" value:NO], NSInvalidArgumentException, FUObjectNilMessage);
		});
	});
	
	context(@"initializing with a nil object and valid property", ^{
		it(@"throws an exception", ^{
			assertThrows([[FUBooleanAction alloc] initWithObject:nil property:@"property"], NSInvalidArgumentException, FUObjectNilMessage);
		});
	});

	context(@"initializing with a valid object, nil property and value", ^{
		it(@"throws an exception", ^{
			assertThrows([[FUBooleanAction alloc] initWithObject:[NSString string] property:nil value:NO], NSInvalidArgumentException, FUPropEmptyMessage);
		});
	});
	
	context(@"initializing with a valid object and nil property", ^{
		it(@"throws an exception", ^{
			assertThrows([[FUBooleanAction alloc] initWithObject:[NSString string] property:nil], NSInvalidArgumentException, FUPropEmptyMessage);
		});
	});

	context(@"initializing with a valid object, empty property and value", ^{
		it(@"throws an exception", ^{
			assertThrows([[FUBooleanAction alloc] initWithObject:[NSString string] property:@"" value:NO], NSInvalidArgumentException, FUPropEmptyMessage);
		});
	});
	
	context(@"initializing with a valid object and empty property", ^{
		it(@"throws an exception", ^{
			assertThrows([[FUBooleanAction alloc] initWithObject:[NSString string] property:@""], NSInvalidArgumentException, FUPropEmptyMessage);
		});
	});

	context(@"initializing with a property that does exist on the object, and value", ^{
		it(@"throws an exception", ^{
			id object = [NSString string];
			NSString* property = @"undefined";
			assertThrows([[FUBooleanAction alloc] initWithObject:object property:property value:NO], NSInvalidArgumentException, FUPropNonexistantMessage, property, object);
		});
	});
	
	context(@"initializing with a property that does exist on the object", ^{
		it(@"throws an exception", ^{
			id object = [NSString string];
			NSString* property = @"undefined";
			assertThrows([[FUBooleanAction alloc] initWithObject:object property:property], NSInvalidArgumentException, FUPropNonexistantMessage, property, object);
		});
	});

	context(@"initializing with a property that is not a numerical type, and value", ^{
		it(@"throws an exception", ^{
			id object = [NSString string];
			NSString* property = @"pathComponents";
			assertThrows([[FUBooleanAction alloc] initWithObject:object property:property value:NO], NSInvalidArgumentException, FUPropWrongTypeMessage, property, object);
		});
	});
	
	context(@"initializing with a property that is not a numerical type", ^{
		it(@"throws an exception", ^{
			id object = [NSString string];
			NSString* property = @"pathComponents";
			assertThrows([[FUBooleanAction alloc] initWithObject:object property:property], NSInvalidArgumentException, FUPropWrongTypeMessage, property, object);
		});
	});

	context(@"initializing with a valid object, property that is readonly and value", ^{
		it(@"throws an exception", ^{
			id object = [NSString string];
			NSString* property = @"isAbsolutePath";
			assertThrows([[FUBooleanAction alloc] initWithObject:object property:property value:NO], NSInvalidArgumentException, FUPropReadonlyMessage, property, object);
		});
	});
	
	context(@"initializing with a valid object, property that is readonly", ^{
		it(@"throws an exception", ^{
			id object = [NSString string];
			NSString* property = @"isAbsolutePath";
			assertThrows([[FUBooleanAction alloc] initWithObject:object property:property], NSInvalidArgumentException, FUPropReadonlyMessage, property, object);
		});
	});

	context(@"initialized with a valid object, property and value", ^{
		__block FUTestObject* object;
		__block NSMutableString* property;
		__block FUBooleanAction* action;
		
		beforeEach(^{
			object = [FUTestObject new];
			property = [NSMutableString stringWithString:@"enabled"];
			action = [[FUBooleanAction alloc] initWithObject:object property:property value:YES];
		});
		
		it(@"is not nil", ^{
			expect(action).toNot.beNil();
		});
		
		context(@"updated the action", ^{
			beforeEach(^{
				[action updateWithFactor:0.0f];
			});
			
			it(@"sets the value to YES", ^{
				expect([object isEnabled]).to.beTruthy();
			});
			
			context(@"updated the action", ^{
				beforeEach(^{
					[action updateWithFactor:0.0f];
				});
				
				it(@"still has the value to YES", ^{
					expect([object isEnabled]).to.beTruthy();
				});
			});
		});
		
		context(@"created a copy of the action", ^{
			__block FUBooleanAction* actionCopy;
			
			beforeEach(^{
				actionCopy = [action copy];
			});
			
			it(@"is not identical to the original action", ^{
				expect(actionCopy).toNot.beIdenticalTo(action);
			});
			
			context(@"updating the copied action", ^{
				it(@"sets the value to YES", ^{
					[actionCopy updateWithFactor:0.0f];
					expect([object isEnabled]).to.beTruthy();
				});
			});
		});
		
		context(@"updating the action after modifiying the original property", ^{
			it(@"sets the value to YES", ^{
				[property setString:@"undefined"];
				[action updateWithFactor:0.0f];
				expect([object isEnabled]).to.beTruthy();
			});
		});
	});
	
	context(@"initialized with a valid object and property", ^{
		__block FUTestObject* object;
		__block NSMutableString* property;
		__block FUBooleanAction* action;
		
		beforeEach(^{
			object = [FUTestObject new];
			property = [NSMutableString stringWithString:@"enabled"];
			action = [[FUBooleanAction alloc] initWithObject:object property:property];
		});
		
		it(@"is not nil", ^{
			expect(action).toNot.beNil();
		});
		
		context(@"updated the action", ^{
			beforeEach(^{
				[action updateWithFactor:0.0f];
			});
			
			it(@"sets the value to YES", ^{
				expect([object isEnabled]).to.beTruthy();
			});
			
			context(@"updated the action", ^{
				beforeEach(^{
					[action updateWithFactor:0.0f];
				});
				
				it(@"sets the value to NO", ^{
					expect([object isEnabled]).to.beFalsy();
				});
			});
			
			context(@"created a copy of the action", ^{
				__block FUBooleanAction* actionCopy;
				
				beforeEach(^{
					actionCopy = [action copy];
				});
				
				it(@"is not identical to the original action", ^{
					expect(actionCopy).toNot.beIdenticalTo(action);
				});
				
				context(@"updating the copied action", ^{
					it(@"sets the value to NO", ^{
						[actionCopy updateWithFactor:0.0f];
						expect([object isEnabled]).to.beFalsy();
					});
				});
			});
		});
		
		context(@"updating the action after modifiying the original property", ^{
			it(@"sets the value to YES", ^{
				[property setString:@"undefined"];
				[action updateWithFactor:0.0f];
				expect([object isEnabled]).to.beTruthy();
			});
		});
	});
	
	context(@"initialized with the FUSwitchOn function", ^{
		__block FUTestObject* object;
		__block FUBooleanAction* action;
		
		beforeEach(^{
			object = [FUTestObject new];
			action = FUSwitchOn(object, @"enabled");
		});
		
		FUTestBoolSetsValue(@"enabled", YES);
	});
	
	context(@"initialized with the FUSwitchOff function", ^{
		__block FUTestObject* object;
		__block FUBooleanAction* action;
		
		beforeEach(^{
			object = [FUTestObject new];
			[object setEnabled:YES];
			action = FUSwitchOff(object, @"enabled");
		});
		
		FUTestBoolSetsValue(@"enabled", NO);
	});
	
	context(@"initialized with the FUToggle function", ^{
		__block FUTestObject* object;
		__block FUBooleanAction* action;
		
		beforeEach(^{
			object = [FUTestObject new];
			action = FUToggle(object, @"enabled");
		});
	
		FUTestBoolTogglesValue(@"enabled");
	});
	
	context(@"initialized with the FUEnable function", ^{
		__block FUTestObject* object;
		__block FUBooleanAction* action;
		
		beforeEach(^{
			object = [FUTestObject new];
			action = FUEnable(object);
		});
		
		FUTestBoolSetsValue(@"enabled", YES);
	});
	
	context(@"initialized with the FUDisable function", ^{
		__block FUTestObject* object;
		__block FUBooleanAction* action;
		
		beforeEach(^{
			object = [FUTestObject new];
			action = FUDisable(object);
		});
		
		FUTestBoolSetsValue(@"enabled", NO);
	});
	
	context(@"initialized with the FUToggleEnabled function", ^{
		__block FUTestObject* object;
		__block FUBooleanAction* action;
		
		beforeEach(^{
			object = [FUTestObject new];
			action = FUToggleEnabled(object);
		});
		
		FUTestBoolTogglesValue(@"enabled");
	});
});

SPEC_END


@implementation FUTestObject
@synthesize enabled = _enabled;
@end