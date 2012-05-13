//
//  FUTimingActionSpec.m
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


SPEC_BEGIN(FUTimingAction)

describe(@"A timing action", ^{
	it(@"is a finite action", ^{
		expect([FUTimingAction class]).to.beSubclassOf([FUFiniteAction class]);
	});
	
	context(@"initializing with a nil action", ^{
		it(@"throws an exception", ^{
			assertThrows([[FUTimingAction alloc] initWithAction:nil function:FUTimingLinear], NSInvalidArgumentException, FUActionNilMessage);
		});
	});
	
	context(@"initializing with a NULL function", ^{
		it(@"throws an exception", ^{
			FUFiniteAction* action = mock([FUFiniteAction class]);
			assertThrows([[FUTimingAction alloc] initWithAction:action function:NULL], NSInvalidArgumentException, FUFunctionNullMessage);
		});
	});
	
	context(@"initializing with an action and a function", ^{
		__block FUTimingAction* action;
		__block FUFiniteAction* subaction;
		
		beforeEach(^{
			subaction = mock([FUFiniteAction class]);
			action = [[FUTimingAction alloc] initWithAction:subaction function:FUTimingEaseIn];
		});
		
		it(@"is not nil", ^{
			expect(action).toNot.beNil();
		});
		
		context(@"updating with a factor of -0.5f", ^{
			it(@"updates the subaction with a factor of 0.0f", ^{
				[action updateWithFactor:-0.5f];
				[verify(subaction) updateWithFactor:0.0f];
			});
		});
		
		context(@"updating with a factor of 0.0f", ^{
			it(@"updates the subaction with a factor of 0.0f", ^{
				[action updateWithFactor:0.0f];
				[verify(subaction) updateWithFactor:0.0f];
			});
		});
		
		context(@"updating with a factor of 0.5f", ^{
			it(@"updates the subaction with a factor of 0.5f on the ease in curve", ^{
				[action updateWithFactor:0.5f];
				[verify(subaction) updateWithFactor:FUTimingEaseIn(0.5f)];
			});
		});
		
		context(@"updating with a factor of 1.0f", ^{
			it(@"updates the subaction with a factor of 1.0f", ^{
				[action updateWithFactor:1.0f];
				[verify(subaction) updateWithFactor:FUTimingEaseIn(1.0f)];
			});
		});
		
		context(@"updating with a factor of 1.5f", ^{
			it(@"updates the subaction with a factor of 1.0f", ^{
				[action updateWithFactor:1.5f];
				[verify(subaction) updateWithFactor:FUTimingEaseIn(1.0f)];
			});
		});
		
		context(@"created a copy of the action", ^{
			__block FUTimingAction* actionCopy;
			__block FUFiniteAction* subactionCopy;
			
			beforeEach(^{
				subactionCopy = mock([FUFiniteAction class]);
				[[given([subaction copyWithZone:nil]) withMatcher:HC_anything()] willReturn:subactionCopy];
				
				actionCopy = [action copy];
			});
			
			it(@"is not nil", ^{
				expect(actionCopy).toNot.beNil();
			});
			
			context(@"updating the copied action", ^{
				it(@"updates the copied subaction", ^{
					[actionCopy updateWithFactor:0.5f];
					[[verifyCount(subaction, never()) withMatcher:HC_anything()] updateWithFactor:0.0f];
					[verify(subactionCopy) updateWithFactor:FUTimingEaseIn(0.5f)];
				});
			});
		});
	});
});

SPEC_END