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


SPEC_BEGIN(FUBooleanAction)

describe(@"A boolean action", ^{
	it(@"is a finite action", ^{
		expect([FUBooleanAction class]).to.beSubclassOf([FUFiniteAction class]);
	});
	
	context(@"initializing with a nil object", ^{
		it(@"throws an exception", ^{
			assertThrows([[FUBooleanAction alloc] initWithObject:nil key:@"key" value:NO], NSInvalidArgumentException, FUObjectNilMessage);
		});
	});

	context(@"initializing with a nil key", ^{
		it(@"throws an exception", ^{
			assertThrows([[FUBooleanAction alloc] initWithObject:[NSString string] key:nil value:NO], NSInvalidArgumentException, FUKeyEmptyMessage);
		});
	});

	context(@"initializing with an empty key", ^{
		it(@"throws an exception", ^{
			assertThrows([[FUBooleanAction alloc] initWithObject:[NSString string] key:@"" value:NO], NSInvalidArgumentException, FUKeyEmptyMessage);
		});
	});

	context(@"initializing with a key that does exist on the object", ^{
		it(@"throws an exception", ^{
			id object = [NSString string];
			NSString* key = @"undefined";
			assertThrows([[FUBooleanAction alloc] initWithObject:object key:key value:NO], NSInvalidArgumentException, FUKeyNonexistantMessage, key, object);
		});
	});

	context(@"initializing with a key that is not a numerical type", ^{
		it(@"throws an exception", ^{
			id object = [NSString string];
			NSString* key = @"pathComponents";
			assertThrows([[FUBooleanAction alloc] initWithObject:object key:key value:NO], NSInvalidArgumentException, FUKeyWrongTypeMessage, key, object);
		});
	});

	context(@"initializing with a key that is readonly", ^{
		it(@"throws an exception", ^{
			id object = [NSString string];
			NSString* key = @"isAbsolutePath";
			assertThrows([[FUBooleanAction alloc] initWithObject:object key:key value:NO], NSInvalidArgumentException, FUKeyReadonlyMessage, key, object);
		});
	});

//	context(@"initialized with a valid object key and value", ^{
//		__block FUBooleanAction* action;
//		
//		beforeEach(^{
//			action = [[FUBooleanAction alloc] initWithObject:object key:key value:NO];
//		});
//		
//		it(@"is not nil", ^{
//			expect(action).toNot.beNil();
//		});
//	});
});

SPEC_END