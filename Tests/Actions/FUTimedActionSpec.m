//
//  FUTimedActionSpec.m
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


static NSString* const FUDurationNegativeMessage = @"Expected 'duration=%g' to be positive";


@interface FUTestTimedAction : FUTimedAction
@property (nonatomic) NSUInteger callCount;
@property (nonatomic) float lastNormalizedTime;
@end


SPEC_BEGIN(FUTimedAction)

describe(@"A timed action", ^{
	__block NSTimeInterval timeLeft;
	
	it(@"is an action", ^{
		expect([[FUTimedAction class] conformsToProtocol:@protocol(FUAction)]).to.beTruthy();
	});
	
	context(@"initializing with a negative duration", ^{
		it(@"throws an exception", ^{
			assertThrows([[FUTimedAction alloc] initWithDuration:-1.0], NSInvalidArgumentException, FUDurationNegativeMessage, -1.0f);
		});
	});
	
	context(@"initialized", ^{
		__block FUTestTimedAction* action;
		
		beforeEach(^{
			action = [FUTestTimedAction new];
		});
		
		it(@"has a duration of 0.0", ^{
			expect([action duration]).to.equal(0.0);
		});
		
		context(@"called consumeDeltaTime: with a 0.0 time", ^{
			beforeEach(^{
				timeLeft = [action consumeDeltaTime:0.0];
			});
			
			it(@"does not call update", ^{
				expect([action callCount]).to.equal(0);
			});
			
			it(@"returns all/no time", ^{
				expect(timeLeft).to.equal(0.0);
			});
		});
		
		context(@"called consumeDeltaTime: with a positive time", ^{
			beforeEach(^{
				timeLeft = [action consumeDeltaTime:1.0];
			});
			
			it(@"calls update with a normalized time of 1.0f", ^{
				expect([action callCount]).to.equal(1);
				expect([action lastNormalizedTime]).to.equal(1.0f);
			});
			
			it(@"returns all of the time", ^{
				expect(timeLeft).to.equal(1.0);
			});
			
			context(@"called consumeDeltaTime: again with a positive time", ^{				
				beforeEach(^{
					timeLeft = [action consumeDeltaTime:2.0];
				});
				
				it(@"does not call update again", ^{
					expect([action callCount]).to.equal(1);
				});
				
				it(@"returns all of the time", ^{
					expect(timeLeft).to.equal(2.0);
				});
			});
			
			context(@"called consumeDeltaTime: again with a negative time", ^{				
				beforeEach(^{
					timeLeft = [action consumeDeltaTime:-1.0];
				});
				
				it(@"calls update with a normalized time of 0.0f", ^{
					expect([action callCount]).to.equal(2);
					expect([action lastNormalizedTime]).to.equal(0.0f);
				});
				
				it(@"returns all of the time", ^{
					expect(timeLeft).to.equal(-1.0);
				});
			});
		});
		
		context(@"called consumeDeltaTime: with a negative time", ^{
			beforeEach(^{
				timeLeft = [action consumeDeltaTime:-1.0];
			});
			
			it(@"does not call update", ^{
				expect([action callCount]).to.equal(0);
			});
			
			it(@"returns all of the time", ^{
				expect(timeLeft).to.equal(-1.0);
			});
			
			context(@"called consumeDeltaTime: again with a negative time", ^{
				beforeEach(^{
					timeLeft = [action consumeDeltaTime:-2.0];
				});
				
				it(@"does not call update", ^{
					expect([action callCount]).to.equal(0);
				});
				
				it(@"returns all of the time", ^{
					expect(timeLeft).to.equal(-2.0);
				});
			});
			
			context(@"called consumeDeltaTime: again with a positive time", ^{
				beforeEach(^{
					timeLeft = [action consumeDeltaTime:1.0];
				});
				
				it(@"calls update with a normalized time of 1.0f", ^{
					expect([action callCount]).to.equal(1);
					expect([action lastNormalizedTime]).to.equal(1.0f);
				});
				
				it(@"returns all of the time", ^{
					expect(timeLeft).to.equal(1.0);
				});
			});
		});
	});
	
	context(@"initialized with a duration of 2.0", ^{
		__block FUTestTimedAction* action;
		
		beforeEach(^{
			action = [[FUTestTimedAction alloc] initWithDuration:2.0];
		});
		
		it(@"has a duration of 2.0", ^{
			expect([action duration]).to.equal(2.0);
		});
		
		context(@"called consumeDeltaTime: with 1.0 seconds", ^{
			beforeEach(^{
				timeLeft = [action consumeDeltaTime:1.0];
			});
			
			it(@"calls update with a normalized time of 0.5f", ^{
				expect([action callCount]).to.equal(1);
				expect([action lastNormalizedTime]).to.beCloseTo(0.5f);
			});
			
			it(@"returns no time left", ^{
				expect(timeLeft).to.equal(0.0);
			});
			
			context(@"called consumeDeltaTime: with 1.5 seconds", ^{
				beforeEach(^{
					timeLeft = [action consumeDeltaTime:1.5];
				});
				
				it(@"calls update with a normalized time of 1.0f", ^{
					expect([action callCount]).to.equal(2);
					expect([action lastNormalizedTime]).to.equal(1.0f);
				});
				
				it(@"returns 0.5 seconds left", ^{
					expect(timeLeft).to.beCloseTo(0.5);
				});
				
				context(@"called consumeDeltaTime: with -1.0 seconds", ^{
					beforeEach(^{
						timeLeft = [action consumeDeltaTime:-1.0];
					});
					
					it(@"calls update with a normalized time of 0.5f", ^{
						expect([action callCount]).to.equal(3);
						expect([action lastNormalizedTime]).to.equal(0.5f);
					});
					
					it(@"returns no time left", ^{
						expect(timeLeft).to.equal(0.0);
					});
				});

				context(@"created a copy", ^{
					__block FUTestTimedAction* actionCopy;
					
					beforeEach(^{
						actionCopy = [action copy];
					});
					
					it(@"is not the same instance", ^{
						expect(actionCopy).toNot.beIdenticalTo(action);
					});
					
					it(@"has a duration of 2.0", ^{
						expect([actionCopy duration]).to.equal(2.0);
					});
					
					context(@"called consumeDeltaTime: on the copy", ^{
						beforeEach(^{
							timeLeft = [actionCopy consumeDeltaTime:1.0];
						});
						
						it(@"does not call update", ^{
							expect([actionCopy callCount]).to.equal(0);
						});
						
						it(@"returns all the time left", ^{
							expect(timeLeft).to.beCloseTo(1.0);
						});
					});
				});
			});
			
			context(@"called consumeDeltaTime: with -1.5 seconds", ^{
				beforeEach(^{
					timeLeft = [action consumeDeltaTime:-1.5];
				});
				
				it(@"calls update with a normalized time of 0.0f", ^{
					expect([action callCount]).to.equal(2);
					expect([action lastNormalizedTime]).to.equal(0.0f);
				});
				
				it(@"returns -0.5 seconds left", ^{
					expect(timeLeft).to.beCloseTo(-0.5);
				});
				
				context(@"called consumeDeltaTime: with 1.0 seconds", ^{
					beforeEach(^{
						timeLeft = [action consumeDeltaTime:1.0];
					});
					
					it(@"calls update with a normalized time of 0.5f", ^{
						expect([action callCount]).to.equal(3);
						expect([action lastNormalizedTime]).to.equal(0.5f);
					});
					
					it(@"returns no time left", ^{
						expect(timeLeft).to.equal(0.0);
					});
				});
			});
		});
	});
	
	context(@"initialized via the function FUDelay", ^{
		__block FUTimedAction* delay;
		
		beforeEach(^{
			delay = FUDelay(3.0);
		});
		
		it(@"is a FUTimedAction", ^{
			expect(delay).to.beKindOf([FUTimedAction class]);
		});
		
		it(@"has the correct duration", ^{
			expect([delay duration]).to.equal(3.0);
		});
	});
});

SPEC_END


@implementation FUTestTimedAction

- (void)update
{
	[self setCallCount:[self callCount] + 1];
	[self setLastNormalizedTime:[self normalizedTime]];
}

@end