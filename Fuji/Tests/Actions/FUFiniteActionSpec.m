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
#import "FUTestSupport.h"


static NSString* const FUDurationNegativeMessage = @"Expected 'duration=%g' to be positive";


SPEC_BEGIN(FUFiniteAction)

describe(@"A finite action", ^{
	it(@"is an action", ^{
		expect([[FUFiniteAction class] conformsToProtocol:@protocol(FUAction)]).to.beTruthy();
	});
	
	context(@"initializing with a negative duration", ^{
		it(@"throws an exception", ^{
			assertThrows([[FUFiniteAction alloc] initWithDuration:-1.0f], NSInvalidArgumentException, FUDurationNegativeMessage, -1.0f);
		});
	});
	
	context(@"initialized", ^{
		__block FUFiniteAction* action;
		
		beforeEach(^{
			action = [FUFiniteAction new];
		});
		
		it(@"is not nil", ^{
			expect(action).toNot.beNil();
		});
		
		it(@"has a duration of 0.0f", ^{
			expect([action duration]).to.equal(0.0f);
		});
		
		it(@"has a factor of 0.0f", ^{
			expect([action factor]).to.equal(0.0f);
		});
		
		it(@"is not complete", ^{
			expect([action isComplete]).to.beFalsy();
		});
		
		context(@"advanced time", ^{
			beforeEach(^{
				[action updateWithDeltaTime:0.0f];
			});
			
			it(@"has a factor of 1.0f", ^{
				expect([action factor]).to.equal(1.0f);
			});
			
			it(@"is complete", ^{
				expect([action isComplete]).to.beTruthy();
			});
		});
	});
	
	context(@"initialized a 2.0f duration action", ^{
		__block FUFiniteAction* action;
		
		beforeEach(^{
			action = [[FUFiniteAction alloc] initWithDuration:2.0f];
		});
		
		it(@"is not nil", ^{
			expect(action).toNot.beNil();
		});
		
		it(@"has a duration of 2.0f", ^{
			expect([action duration]).to.equal(2.0f);
		});
		
		it(@"has a factor of 0.0f", ^{
			expect([action factor]).to.equal(0.0f);
		});
		
		it(@"is not complete", ^{
			expect([action isComplete]).to.beFalsy();
		});
		
		context(@"updated with a factor of -0.3f", ^{
			beforeEach(^{
				[action updateWithFactor:-0.3f];
			});
			
			it(@"has a factor of -0.3f", ^{
				expect([action factor]).to.equal(-0.3f);
			});
			
			it(@"is not complete", ^{
				expect([action isComplete]).to.beFalsy();
			});
		});
		
		context(@"updated with a factor of 0.0f", ^{
			beforeEach(^{
				[action updateWithFactor:0.0f];
			});
			
			it(@"has a factor of 0.0f", ^{
				expect([action factor]).to.equal(0.0f);
			});
			
			it(@"is complete", ^{
				expect([action isComplete]).to.beTruthy();
			});
		});
		
		context(@"updated with a factor of 0.4f", ^{
			beforeEach(^{
				[action updateWithFactor:0.4f];
			});
			
			it(@"has a factor of 0.4f", ^{
				expect([action factor]).to.equal(0.4f);
			});
			
			it(@"is not complete", ^{
				expect([action isComplete]).to.beFalsy();
			});
		});
		
		context(@"updated with a factor of 1.0f", ^{
			beforeEach(^{
				[action updateWithFactor:1.0f];
			});
			
			it(@"has a factor of 1.0f", ^{
				expect([action factor]).to.equal(1.0f);
			});
			
			it(@"is complete", ^{
				expect([action isComplete]).to.beTruthy();
			});
		});
		
		context(@"updated with a factor of 1.2f", ^{
			beforeEach(^{
				[action updateWithFactor:1.2f];
			});
			
			it(@"has a factor of 1.2f", ^{
				expect([action factor]).to.equal(1.2f);
			});
			
			it(@"is not complete", ^{
				expect([action isComplete]).to.beFalsy();
			});
		});
		
		context(@"updated with a delta time of 1.0f seconds", ^{
			beforeEach(^{
				[action updateWithDeltaTime:1.0f];
			});
			
			it(@"has a factor of 0.5f", ^{
				expect([action factor]).to.beCloseTo(0.5f);
			});
			
			it(@"is not complete", ^{
				expect([action isComplete]).to.beFalsy();
			});
			
			context(@"updated with a delta time of 1.0f seconds", ^{
				beforeEach(^{
					[action updateWithDeltaTime:1.0f];
				});
				
				it(@"has a factor of 1.0f", ^{
					expect([action factor]).to.equal(1.0f);
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
					
					it(@"has a duration of 2.0f", ^{
						expect([copy duration]).to.equal(2.0f);
					});
					
					it(@"has a factor of 1.0f", ^{
						expect([action factor]).to.equal(1.0f);
					});
					
					it(@"is complete", ^{
						expect([copy isComplete]).to.beTruthy();
					});
				});
				
				context(@"updated with a delta time of -1.0f seconds", ^{
					beforeEach(^{
						[action updateWithDeltaTime:-1.0f];
					});
					
					it(@"has a factor of 0.5f", ^{
						expect([action factor]).to.beCloseTo(0.5f);
					});
					
					it(@"is not complete", ^{
						expect([action isComplete]).to.beFalsy();
					});
				});
			});
			
			context(@"updated with a delta time of 2.0f seconds", ^{
				beforeEach(^{
					[action updateWithDeltaTime:2.0f];
				});
				
				it(@"has a factor of 1.0f", ^{
					expect([action factor]).to.equal(1.0f);
				});
				
				it(@"is complete", ^{
					expect([action isComplete]).to.beTruthy();
				});
			});
			
			context(@"updated with a delta time of -1.0f seconds", ^{
				beforeEach(^{
					[action updateWithDeltaTime:-1.0f];
				});
				
				it(@"has a factor of 0.0f", ^{
					expect([action factor]).to.equal(0.0f);
				});
				
				it(@"is complete", ^{
					expect([action isComplete]).to.beTruthy();
				});
				
				context(@"updated with a delta time of 1.0f seconds", ^{
					beforeEach(^{
						[action updateWithDeltaTime:1.0f];
					});
					
					it(@"has a factor of 0.5f", ^{
						expect([action factor]).to.beCloseTo(0.5f);
					});
					
					it(@"is not complete", ^{
						expect([action isComplete]).to.beFalsy();
					});
				});
			});
			
			context(@"updated with a delta time of -2.0f seconds", ^{
				beforeEach(^{
					[action updateWithDeltaTime:-2.0f];
				});
				
				it(@"has a factor of 0.0f", ^{
					expect([action factor]).to.equal(0.0f);
				});
				
				it(@"is complete", ^{
					expect([action isComplete]).to.beTruthy();
				});
			});
		});
	});
});

SPEC_END