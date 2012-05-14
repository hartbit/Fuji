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
static NSString* const FUKeyEmptyMessage = @"Expected 'key' to not be nil or empty";
static NSString* const FUKeyNonexistantMessage = @"The 'key=%@' does not exist on the 'object=%@'";
static NSString* const FUKeyWrongTypeMessage = @"Expected 'key=%@' on 'object=%@' to be of a numerical type";
static NSString* const FUKeyReadonlyMessage = @"The 'key=%@' on 'object=%@' is readonly";


@interface FUTestObject : NSObject
@property (nonatomic, getter=isEnabled) BOOL enabled;
@end


SPEC_BEGIN(FUBooleanAction)

describe(@"A boolean action", ^{
	it(@"is a finite action", ^{
		expect([FUBooleanAction class]).to.beSubclassOf([FUFiniteAction class]);
	});
	
	context(@"initializing with a nil object, valid key and value", ^{
		it(@"throws an exception", ^{
			assertThrows([[FUBooleanAction alloc] initWithObject:nil key:@"key" value:NO], NSInvalidArgumentException, FUObjectNilMessage);
		});
	});
	
	context(@"initializing with a nil object and valid key", ^{
		it(@"throws an exception", ^{
			assertThrows([[FUBooleanAction alloc] initWithObject:nil key:@"key"], NSInvalidArgumentException, FUObjectNilMessage);
		});
	});

	context(@"initializing with a valid object, nil key and value", ^{
		it(@"throws an exception", ^{
			assertThrows([[FUBooleanAction alloc] initWithObject:[NSString string] key:nil value:NO], NSInvalidArgumentException, FUKeyEmptyMessage);
		});
	});
	
	context(@"initializing with a valid object and nil key", ^{
		it(@"throws an exception", ^{
			assertThrows([[FUBooleanAction alloc] initWithObject:[NSString string] key:nil], NSInvalidArgumentException, FUKeyEmptyMessage);
		});
	});

	context(@"initializing with a valid object, empty key and value", ^{
		it(@"throws an exception", ^{
			assertThrows([[FUBooleanAction alloc] initWithObject:[NSString string] key:@"" value:NO], NSInvalidArgumentException, FUKeyEmptyMessage);
		});
	});
	
	context(@"initializing with a valid object and empty key", ^{
		it(@"throws an exception", ^{
			assertThrows([[FUBooleanAction alloc] initWithObject:[NSString string] key:@""], NSInvalidArgumentException, FUKeyEmptyMessage);
		});
	});

	context(@"initializing with a key that does exist on the object, and value", ^{
		it(@"throws an exception", ^{
			id object = [NSString string];
			NSString* key = @"undefined";
			assertThrows([[FUBooleanAction alloc] initWithObject:object key:key value:NO], NSInvalidArgumentException, FUKeyNonexistantMessage, key, object);
		});
	});
	
	context(@"initializing with a key that does exist on the object", ^{
		it(@"throws an exception", ^{
			id object = [NSString string];
			NSString* key = @"undefined";
			assertThrows([[FUBooleanAction alloc] initWithObject:object key:key], NSInvalidArgumentException, FUKeyNonexistantMessage, key, object);
		});
	});

	context(@"initializing with a key that is not a numerical type, and value", ^{
		it(@"throws an exception", ^{
			id object = [NSString string];
			NSString* key = @"pathComponents";
			assertThrows([[FUBooleanAction alloc] initWithObject:object key:key value:NO], NSInvalidArgumentException, FUKeyWrongTypeMessage, key, object);
		});
	});
	
	context(@"initializing with a key that is not a numerical type", ^{
		it(@"throws an exception", ^{
			id object = [NSString string];
			NSString* key = @"pathComponents";
			assertThrows([[FUBooleanAction alloc] initWithObject:object key:key], NSInvalidArgumentException, FUKeyWrongTypeMessage, key, object);
		});
	});

	context(@"initializing with a valid object, key that is readonly and value", ^{
		it(@"throws an exception", ^{
			id object = [NSString string];
			NSString* key = @"isAbsolutePath";
			assertThrows([[FUBooleanAction alloc] initWithObject:object key:key value:NO], NSInvalidArgumentException, FUKeyReadonlyMessage, key, object);
		});
	});
	
	context(@"initializing with a valid object, key that is readonly", ^{
		it(@"throws an exception", ^{
			id object = [NSString string];
			NSString* key = @"isAbsolutePath";
			assertThrows([[FUBooleanAction alloc] initWithObject:object key:key value:NO], NSInvalidArgumentException, FUKeyReadonlyMessage, key, object);
		});
	});

	context(@"initialized with a valid object, key and value", ^{
		__block FUTestObject* object;
		__block NSMutableString* key;
		__block FUBooleanAction* action;
		
		beforeEach(^{
			object = [FUTestObject new];
			key = [NSMutableString stringWithString:@"enabled"];
			action = [[FUBooleanAction alloc] initWithObject:object key:key value:YES];
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
		
		context(@"updating the action after modifiying the original key", ^{
			it(@"sets the value to YES", ^{
				[key setString:@"undefined"];
				[action updateWithFactor:0.0f];
				expect([object isEnabled]).to.beTruthy();
			});
		});
	});
	
	context(@"initialized with a valid object and key", ^{
		__block FUTestObject* object;
		__block NSMutableString* key;
		__block FUBooleanAction* action;
		
		beforeEach(^{
			object = [FUTestObject new];
			key = [NSMutableString stringWithString:@"enabled"];
			action = [[FUBooleanAction alloc] initWithObject:object key:key];
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
		});
		
		context(@"updating the action after modifiying the original key", ^{
			it(@"sets the value to YES", ^{
				[key setString:@"undefined"];
				[action updateWithFactor:0.0f];
				expect([object isEnabled]).to.beTruthy();
			});
		});
	});
	
	context(@"initialized with the FUEnable function", ^{
		__block FUTestObject* object;
		__block NSMutableString* key;
		__block FUBooleanAction* action;
		
		beforeEach(^{
			object = [FUTestObject new];
			key = [NSMutableString stringWithString:@"enabled"];
			action = FUEnable(object, key);
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
	});
	
	context(@"initialized with the FUDisable function", ^{
		__block FUTestObject* object;
		__block NSMutableString* key;
		__block FUBooleanAction* action;
		
		beforeEach(^{
			object = [FUTestObject new];
			[object setEnabled:YES];
			key = [NSMutableString stringWithString:@"enabled"];
			action = FUDisable(object, key);
		});
		
		it(@"is not nil", ^{
			expect(action).toNot.beNil();
		});
		
		context(@"updated the action", ^{
			beforeEach(^{
				[action updateWithFactor:0.0f];
			});
			
			it(@"sets the value to NO", ^{
				expect([object isEnabled]).to.beFalsy();
			});
			
			context(@"updated the action", ^{
				beforeEach(^{
					[action updateWithFactor:0.0f];
				});
				
				it(@"still has the value to NO", ^{
					expect([object isEnabled]).to.beFalsy();
				});
			});
		});
	});
	
	context(@"initialized with the FUToggle function", ^{
		__block FUTestObject* object;
		__block NSMutableString* key;
		__block FUBooleanAction* action;
		
		beforeEach(^{
			object = [FUTestObject new];
			key = [NSMutableString stringWithString:@"enabled"];
			action = FUToggle(object, key);
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
		});
		
		context(@"updating the action after modifiying the original key", ^{
			it(@"sets the value to YES", ^{
				[key setString:@"undefined"];
				[action updateWithFactor:0.0f];
				expect([object isEnabled]).to.beTruthy();
			});
		});
	});
});

SPEC_END


@implementation FUTestObject
@synthesize enabled = _enabled;
@end