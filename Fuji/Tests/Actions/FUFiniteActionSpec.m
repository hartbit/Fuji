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
#import "FUFiniteAction-Internal.h"


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
			expect([action duration]).to.equal(0.0);
		});
		
		it(@"has a time of 0", ^{
			expect([action time]).to.equal(0.0);
		});
		
		it(@"is not complete", ^{
			expect([action isComplete]).to.beFalsy();
		});
		
		context(@"advancing time", ^{
			it(@"makes it complete", ^{
				[action updateWithDeltaTime:0];
				expect([action isComplete]).to.beTruthy();
			});
		});
	});
	
	context(@"initialized a one second duration action", ^{
		__block FUFiniteAction* action;
		
		beforeEach(^{
			action = [[FUFiniteAction alloc] initWithDuration:1];
		});
		
		it(@"is not nil", ^{
			expect(action).toNot.beNil();
		});
		
		it(@"has a duration of 1.0", ^{
			expect([action duration]).to.equal(1.0);
		});
		
		it(@"has a time of 0", ^{
			expect([action time]).to.equal(0.0);
		});
		
		it(@"is not complete", ^{
			expect([action isComplete]).to.beFalsy();
		});
		
		context(@"advanced time of 0.5 seconds", ^{
			beforeEach(^{
				[action updateWithDeltaTime:0.5];
			});
			
			it(@"has a time of 0.5", ^{
				expect([action time]).to.equal(0.5);
			});
			
			it(@"is not complete", ^{
				expect([action isComplete]).to.beFalsy();
			});
			
			context(@"advanced time of 0.5 seconds", ^{
				beforeEach(^{
					[action updateWithDeltaTime:0.5];
				});
				
				it(@"has a time of 1.0", ^{
					expect([action time]).to.equal(1.0);
				});
				
				it(@"is complete", ^{
					expect([action isComplete]).to.beTruthy();
				});
				
				context(@"created a copy", ^{
					__block FUFiniteAction* copy;
					
					beforeEach(^{
						copy = [action copy];
					});
					
					it(@"is not nil", ^{
						expect(copy).toNot.beNil();
					});
					
					it(@"is not the same instance", ^{
						expect(copy).toNot.beIdenticalTo(action);
					});
					
					it(@"has a duration of 1.0", ^{
						expect([copy duration]).to.equal(1.0);
					});
					
					it(@"has a time of 1.0", ^{
						expect([copy time]).to.equal(1.0);
					});
					
					it(@"is complete", ^{
						expect([copy isComplete]).to.beTruthy();
					});
				});
				
				context(@"advanced time of -0.5 seconds", ^{
					beforeEach(^{
						[action updateWithDeltaTime:-0.5];
					});
					
					it(@"has a time of 1.0", ^{
						expect([action time]).to.equal(0.5);
					});
					
					it(@"is not complete", ^{
						expect([action isComplete]).to.beFalsy();
					});
				});
			});
			
			context(@"advanced time of -0.5 seconds", ^{
				beforeEach(^{
					[action updateWithDeltaTime:-0.5];
				});
				
				it(@"has a time of 0.0", ^{
					expect([action time]).to.equal(0.0);
				});
				
				it(@"is not complete", ^{
					expect([action isComplete]).to.beFalsy();
				});
			});
			
			context(@"advanced time of -0.51 seconds", ^{
				beforeEach(^{
					[action updateWithDeltaTime:-0.51];
				});
				
				it(@"has a time of 0.0", ^{
					expect([action time]).to.equal(0.0);
				});
				
				it(@"is complete", ^{
					expect([action isComplete]).to.beTruthy();
				});
				
				context(@"advanced time of 0.5 seconds", ^{
					beforeEach(^{
						[action updateWithDeltaTime:0.5];
					});
					
					it(@"has a time of 0.5", ^{
						expect([action time]).to.equal(0.5);
					});
					
					it(@"is not complete", ^{
						expect([action isComplete]).to.beFalsy();
					});
				});
			});
		});
	});
});

SPEC_END