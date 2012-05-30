//
//  FUCallActionSpec.m
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


static NSString* const FUBlockNullMessage = @"Expected block to not be NULL";


#define FUTestBoolSetsValue(prop, value) \
	it(@"is not nil", ^{ \
		expect(action).toNot.beNil(); \
	}); \
	\
	context(@"updated with a positive time", ^{ \
		beforeEach(^{ \
			[action consumeDeltaTime:1.0]; \
		}); \
		\
		it([NSString stringWithFormat:@"sets %@ to %@", prop, FUStringFromBool(value)], ^{ \
			[verify(target) setValue:[NSNumber numberWithBool:value] forKey:prop]; \
		}); \
		\
		context(@"updating with a negative time", ^{ \
			it([NSString stringWithFormat:@"sets %@ to %@", prop, FUStringFromBool(value)], ^{ \
				[action consumeDeltaTime:-1.0]; \
				[verifyCount(target, times(2)) setValue:[NSNumber numberWithBool:value] forKey:prop]; \
			}); \
		}); \
	});

#define FUTestBoolTogglesValue(prop) \
	it(@"is not nil", ^{ \
		expect(action).toNot.beNil(); \
	}); \
	\
	context(@"updated with a positive time", ^{ \
		beforeEach(^{ \
			[given([target valueForKey:prop]) willReturn:[NSNumber numberWithBool:NO]]; \
			[action consumeDeltaTime:1.0]; \
		}); \
		\
		it([NSString stringWithFormat:@"sets %@ to YES", prop], ^{ \
			[verify(target) setValue:[NSNumber numberWithBool:YES] forKey:prop]; \
		}); \
		\
		context(@"updating with a negative time", ^{ \
			it([NSString stringWithFormat:@"sets %@ to NO", prop], ^{ \
				[given([target valueForKey:prop]) willReturn:[NSNumber numberWithBool:YES]]; \
				[action consumeDeltaTime:-1.0]; \
				[verify(target) setValue:[NSNumber numberWithBool:NO] forKey:prop]; \
			}); \
		}); \
	});


SPEC_BEGIN(FUCallAction)

describe(@"A call action", ^{
	it(@"is a timed action", ^{
		expect([FUCallAction class]).to.beSubclassOf([FUTimedAction class]);
	});
	
	context(@"initizing with a NULL block", ^{
		it(@"throws an exception", ^{
			assertThrows([[FUCallAction alloc] initWithBlock:NULL], NSInvalidArgumentException, FUBlockNullMessage);
		});
	});
	
	context(@"initializing via the function with a block", ^{
		it(@"returns a FUCallAction", ^{
			expect(FUCall(^{})).to.beKindOf([FUCallAction class]);
		});
	});
	
	context(@"initialized with a block", ^{
		__block FUCallAction* action;
		__block NSUInteger callCount;
		__block NSTimeInterval timeLeft;
		
		beforeEach(^{
			callCount = 0;
			action = [[FUCallAction alloc] initWithBlock:^{
				callCount++;
			}];
		});
		
		it(@"is not nil", ^{
			expect(action).toNot.beNil();
		});
		
		it(@"was not called", ^{
			expect(callCount).to.equal(0);
		});
		
		context(@"called consumeDeltaTime: with 0.0 seconds", ^{
			beforeEach(^{
				timeLeft = [action consumeDeltaTime:0.0];
			});
			
			it(@"returns no time", ^{
				expect(timeLeft).to.equal(0.0);
			});
			
			it(@"does not call the block", ^{
				expect(callCount).to.equal(0);
			});
		});
			
		context(@"called consumeDeltaTime: with a positive time", ^{
			beforeEach(^{
				timeLeft = [action consumeDeltaTime:1.0];
			});
			
			it(@"returns all the time", ^{
				expect(timeLeft).to.equal(1.0);
			});
			
			it(@"calls the block", ^{
				expect(callCount).to.equal(1);
			});
			
			context(@"called consumeDeltaTime: a second time", ^{
				beforeEach(^{
					timeLeft = [action consumeDeltaTime:2.0];
				});
				
				it(@"returns all the time", ^{
					expect(timeLeft).to.equal(2.0);
				});
				
				it(@"does not call the block again", ^{
					expect(callCount).to.equal(1);
				});
			});
			
			context(@"created a copy of the action", ^{
				__block FUCallAction* actionCopy;
				
				beforeEach(^{
					actionCopy = [action copy];
				});
				
				it(@"is not nil", ^{
					expect(actionCopy).toNot.beNil();
				});
				
				it(@"is not the same instance", ^{
					expect(actionCopy).toNot.beIdenticalTo(action);
				});
				
				context(@"called consumeDeltaTime: on the copied action", ^{
					beforeEach(^{
						timeLeft = [actionCopy consumeDeltaTime:2.0];
					});
					
					it(@"returns all the time", ^{
						expect(timeLeft).to.equal(2.0);
					});
					
					it(@"does not call the block again", ^{
						expect(callCount).to.equal(1);
					});
				});
			});
			
			context(@"called consumeDeltaTime: with a negative time", ^{
				beforeEach(^{
					timeLeft = [action consumeDeltaTime:-2.0];
				});
				
				it(@"returned all the time", ^{
					expect(timeLeft).to.equal(-2.0);
				});
				
				it(@"calls the block", ^{
					expect(callCount).to.equal(2);
				});
				
				context(@"called consumeDeltaTime: a second time with a negative time", ^{
					beforeEach(^{
						timeLeft = [action consumeDeltaTime:-3.0];
					});
					
					it(@"returned all the time", ^{
						expect(timeLeft).to.equal(-3.0);
					});
					
					it(@"does not call the block again", ^{
						expect(callCount).to.equal(2);
					});
				});
			});
		});
	});
	
	context(@"initialized with the FUSwitchOn function", ^{
		__block FUBehavior* target;
		__block FUCallAction* action;
		
		beforeEach(^{
			target = mock([FUBehavior class]);
			action = FUSwitchOn(target, @"enabled");
		});
		
		FUTestBoolSetsValue(@"enabled", YES);
	});
	
	context(@"initialized with the FUSwitchOff function", ^{
		__block FUBehavior* target;
		__block FUCallAction* action;
		
		beforeEach(^{
			target = mock([FUBehavior class]);
			action = FUSwitchOff(target, @"enabled");
		});
		
		FUTestBoolSetsValue(@"enabled", NO);
	});
	
	context(@"initialized with the FUToggle function", ^{
		__block FUBehavior* target;
		__block FUCallAction* action;
		
		beforeEach(^{
			target = mock([FUBehavior class]);
			action = FUToggle(target, @"enabled");
		});
		
		FUTestBoolTogglesValue(@"enabled");
	});
	
	context(@"initialized with the FUEnable function", ^{
		__block FUBehavior* target;
		__block FUCallAction* action;
		
		beforeEach(^{
			target = mock([FUBehavior class]);
			action = FUEnable(target);
		});
		
		FUTestBoolSetsValue(@"enabled", YES);
	});
	
	context(@"initialized with the FUDisable function", ^{
		__block FUBehavior* target;
		__block FUCallAction* action;
		
		beforeEach(^{
			target = mock([FUBehavior class]);
			action = FUDisable(target);
		});
		
		FUTestBoolSetsValue(@"enabled", NO);
	});
	
	context(@"initialized with the FUToggleEnabled function", ^{
		__block FUBehavior* target;
		__block FUCallAction* action;
		
		beforeEach(^{
			target = mock([FUBehavior class]);
			action = FUToggleEnabled(target);
		});
		
		FUTestBoolTogglesValue(@"enabled");
	});
});

SPEC_END