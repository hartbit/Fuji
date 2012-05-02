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


SPEC_BEGIN(FUBlockAction)

describe(@"A block action", ^{
	it(@"is a finite action", ^{
		expect([FUBlockAction class]).to.beSubclassOf([FUFiniteAction class]);
	});
	
	context(@"initialized with a block", ^{
		__block FUBlockAction* action;
		__block NSUInteger callCount;
		
		beforeEach(^{
			callCount = 0;
			action = [FUBlockAction actionWithBlock:^{
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
			
			context(@"updating the action a second time", ^{
				it(@"does not call the block again", ^{
					[action updateWithDeltaTime:1];
					expect(callCount).to.equal(1);
				});
			});
		});
	});
});

SPEC_END