//
//  FUBlockActionSpec.m
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


static NSString* const FUBlockNullMessage = @"Expected block to not be nil";


SPEC_BEGIN(FUBlockAction)

describe(@"A block action", ^{
	it(@"is as action", ^{
		expect([[FUBlockAction class] conformsToProtocol:@protocol(FUAction)]).to.beTruthy();
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
		
		it(@"was not called", ^{
			expect(callCount).to.equal(0);
		});
		
		context(@"updating the action with 0.0", ^{
			__block NSTimeInterval timeLeft1;
			
			beforeEach(^{
				timeLeft1 = [action updateWithDeltaTime:0.0];
			});
			
			it(@"returned no time", ^{
				expect(timeLeft1).to.equal(0.0);
			});
			
			it(@"does not call the block", ^{
				expect(callCount).to.equal(0);
			});
		});
			
		context(@"updating the action with a positive time", ^{
			__block NSTimeInterval timeLeft2;
			
			beforeEach(^{
				timeLeft2 = [action updateWithDeltaTime:1.0];
			});
			
			it(@"returned all the time", ^{
				expect(timeLeft2).to.equal(1.0);
			});
			
			it(@"calls the block", ^{
				expect(callCount).to.equal(1);
			});
			
			context(@"updating the action a second time", ^{
				__block NSTimeInterval timeLeft3;
				
				beforeEach(^{
					timeLeft3 = [action updateWithDeltaTime:2.0];
				});
				
				it(@"returned all the time", ^{
					expect(timeLeft3).to.equal(2.0);
				});
				
				it(@"does not call the block again", ^{
					expect(callCount).to.equal(1);
				});
			});
			
			context(@"updating a copy of the action", ^{
				__block FUBlockAction* actionCopy;
				__block NSTimeInterval timeLeft4;
				
				beforeEach(^{
					actionCopy = [action copy];
					timeLeft4 = [actionCopy updateWithDeltaTime:2.0];
				});
				
				it(@"is not nil", ^{
					expect(actionCopy).toNot.beNil();
				});
				
				it(@"is not the same instance", ^{
					expect(actionCopy).toNot.beIdenticalTo(action);
				});
				
				it(@"returned all the time", ^{
					expect(timeLeft4).to.equal(2.0);
				});
				
				it(@"does not call the block again", ^{
					expect(callCount).to.equal(1);
				});
			});
			
			context(@"updating the action with a negative time", ^{
				__block NSTimeInterval timeLeft5;
				
				beforeEach(^{
					timeLeft5 = [action updateWithDeltaTime:-2.0];
				});
				
				it(@"returned all the time", ^{
					expect(timeLeft5).to.equal(-2.0);
				});
				
				it(@"calls the block", ^{
					expect(callCount).to.equal(2);
				});
				
				context(@"updating the action a second time with a negative time", ^{
					__block NSTimeInterval timeLeft6;
					
					beforeEach(^{
						timeLeft6 = [action updateWithDeltaTime:-3.0];
					});
					
					it(@"returned all the time", ^{
						expect(timeLeft6).to.equal(-3.0);
					});
					
					it(@"does not call the block again", ^{
						expect(callCount).to.equal(2);
					});
				});
			});
		});
	});
});

SPEC_END