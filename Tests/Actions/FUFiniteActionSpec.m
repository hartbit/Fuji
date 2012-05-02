//
//  FUFiniteActionSpec.m
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


@interface FUOneSecondDurationAction : FUFiniteAction @end


SPEC_BEGIN(FUFiniteAction)

describe(@"A finite action", ^{
	it(@"is an action", ^{
		expect([[FUFiniteAction class] conformsToProtocol:@protocol(FUAction)]).to.beTruthy();
	});
	
	context(@"initialized", ^{
		__block FUFiniteAction* action;
		
		beforeEach(^{
			action = [FUFiniteAction new];
		});
		
		it(@"is not nil", ^{
			expect(action).toNot.beNil();
		});
		
		it(@"has a duration of 0", ^{
			expect([action duration]).to.equal(0);
		});
		
		it(@"the reverse is itself", ^{
			expect([action reverse]).to.beIdenticalTo(action);
		});
		
		it(@"is not complete", ^{
			expect([action isComplete]).to.beFalsy();
		});
		
		context(@"advancing time", ^{
			it(@"makes it complete", ^{
				[action advanceTime:0];
				expect([action isComplete]).to.beTruthy();
			});
		});
	});
	
	context(@"initialized a one second duration action", ^{
		__block FUOneSecondDurationAction* action;
		
		beforeEach(^{
			action = [FUOneSecondDurationAction new];
		});
		
		it(@"is not nil", ^{
			expect(action).toNot.beNil();
		});
		
		it(@"has a duration of 0", ^{
			expect([action duration]).to.equal(1.0);
		});
		
		it(@"is not complete", ^{
			expect([action isComplete]).to.beFalsy();
		});
		
		context(@"advanced time of 0.5 seconds", ^{
			beforeEach(^{
				[action advanceTime:0.5];
			});
			
			it(@"is not complete", ^{
				expect([action isComplete]).to.beFalsy();
			});
			
			context(@"advanced time of 0.5 seconds", ^{
				beforeEach(^{
					[action advanceTime:0.5];
				});
				
				it(@"is complete", ^{
					expect([action isComplete]).to.beTruthy();
				});
			});
			
			context(@"advanced time of -0.51 seconds", ^{
				beforeEach(^{
					[action advanceTime:0.51];
				});
				
				it(@"is not complete", ^{
					expect([action isComplete]).to.beTruthy();
				});
			});
		});
	});
});

SPEC_END


@implementation FUOneSecondDurationAction
- (NSTimeInterval)duration
{
	return 1.0;
}
@end