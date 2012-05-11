//
//  FUEaseActionSpec.m
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


static NSString* const FUActionNilMessage = @"Expected 'action' to not be nil";
static NSString* const FUFunctionNullMessage = @"Expected 'function' to not be NULL";


SPEC_BEGIN(FUEaseAction)

describe(@"An ease action", ^{
	it(@"is a finite action", ^{
		expect([FUEaseAction class]).to.beSubclassOf([FUFiniteAction class]);
	});
	
	context(@"initializing with a nil action", ^{
		it(@"throws an exception", ^{
			assertThrows([[FUEaseAction alloc] initWithAction:nil function:^(FUTime t){ return t; }], NSInvalidArgumentException, FUActionNilMessage);
		});
	});
	
	context(@"initializing with a NULL function", ^{
		it(@"throws an exception", ^{
			FUFiniteAction* action = mock([FUFiniteAction class]);
			assertThrows([[FUEaseAction alloc] initWithAction:action function:NULL], NSInvalidArgumentException, FUFunctionNullMessage);
		});
	});
});

SPEC_END