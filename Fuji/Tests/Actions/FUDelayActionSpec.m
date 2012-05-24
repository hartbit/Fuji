//
//  FUDelayActionSpec.m
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#include "Prefix.pch"
#import "Fuji.h"
#import "FUTestSupport.h"


static NSString* const FUDelayNegativeMessage = @"Expected 'delay=%g' to be positive";


SPEC_BEGIN(FUDelayAction)

describe(@"A dekay action", ^{
	it(@"is a timed action", ^{
		expect([FUDelayAction class]).to.beSubclassOf([FUTimedAction class]);
	});
	
	context(@"initizing with a negative delay", ^{
		it(@"throws an exception", ^{
			assertThrows([[FUDelayAction alloc] initWithDelay:-0.1f], NSInvalidArgumentException, FUDelayNegativeMessage, -0.1f);
		});
	});
	
	context(@"initizing with a null delay", ^{
		it(@"is valid", ^{
			assertNoThrow([[FUDelayAction alloc] initWithDelay:0.0f]);
		});
	});
	
	context(@"initializing via the function", ^{
		it(@"returns a FUDelayAction", ^{
			expect(FUDelay(1.0f)).to.beKindOf([FUDelayAction class]);
		});
	});
	
	context(@"initialized with a postive delay", ^{
		__block FUDelayAction* action;
		
		beforeEach(^{
			action = [[FUDelayAction alloc] initWithDelay:2.5];
		});
		
		it(@"is not nil", ^{
			expect(action).toNot.beNil();
		});
		
		it(@"has a duration of 2.5", ^{
			expect([action duration]).to.equal(2.5);
		});
	});
});

SPEC_END