//
//  FUBlockActionSpec.m
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


static NSString* const FUBlockNullMessage = @"Expected block to not be nil";


SPEC_BEGIN(FUBlockAction)

describe(@"A block action", ^{
	it(@"is a finite action", ^{
		expect([FUBlockAction class]).to.beSubclassOf([FUFiniteAction class]);
	});
	
	context(@"initizing with a NULL block", ^{
		it(@"throws an exception", ^{
			assertThrows([[FUBlockAction alloc] initWithBlock:NULL], NSInvalidArgumentException, FUBlockNullMessage);
		});
	});
	
	context(@"initializing via the function with a block", ^{
		it(@"returns a FUBlockAction", ^{
			expect(FUBlock(^{})).to.beKindOf([FUBlockAction class]);
		});
	});
	
	context(@"initialized with a block", ^{
		__block FUBlockAction* action;
		__block NSUInteger callCount;
		
		beforeEach(^{
			callCount = 0;
			action = [[FUBlockAction alloc] initWithBlock:^{
				callCount++;
			}];
		});
		
		it(@"is not nil", ^{
			expect(action).toNot.beNil();
		});
		
		it(@"is not complete", ^{
			expect([action isComplete]).to.beFalsy();
		});
		
		it(@"was not called", ^{
			expect(callCount).to.equal(0);
		});
		
		context(@"updated the action", ^{
			beforeEach(^{
				[action updateWithDeltaTime:0];
			});
			
			it(@"is complete", ^{
				expect([action isComplete]).to.beTruthy();
			});
			
			it(@"called the block", ^{
				expect(callCount).to.equal(1);
			});
			
			context(@"creating a copy", ^{
				__block FUBlockAction* copy;
				
				beforeEach(^{
					copy = [action copy];
				});
				
				it(@"is not nil", ^{
					expect(copy).toNot.beNil();
				});
				
				it(@"is not the same instance", ^{
					expect(copy).toNot.beIdenticalTo(action);
				});
				
				it(@"is complete", ^{
					expect([copy isComplete]).to.beTruthy();
				});
			});
			
			context(@"updating the action a second time", ^{
				it(@"calls the block again", ^{
					[action updateWithDeltaTime:1];
					expect(callCount).to.equal(2);
				});
			});
		});
		
		context(@"created a copy", ^{
			__block FUBlockAction* copy;
			
			beforeEach(^{
				copy = [action copy];
			});
			
			it(@"is not nil", ^{
				expect(copy).toNot.beNil();
			});
			
			it(@"is not the same instance", ^{
				expect(copy).toNot.beIdenticalTo(action);
			});
			
			it(@"is not complete", ^{
				expect([copy isComplete]).to.beFalsy();
			});
			
			context(@"updated the copy", ^{
				beforeEach(^{
					[copy updateWithDeltaTime:0];
				});
				
				it(@"is complete", ^{
					expect([copy isComplete]).to.beTruthy();
				});
				
				it(@"called the block", ^{
					expect(callCount).to.equal(1);
				});
			});
		});
	});
});

SPEC_END