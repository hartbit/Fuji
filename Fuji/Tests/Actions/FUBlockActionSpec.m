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
			[verify(object) setValue:[NSNumber numberWithBool:value] forKey:prop]; \
		}); \
		\
		context(@"updating with a negative time", ^{ \
			it([NSString stringWithFormat:@"sets %@ to %@", prop, FUStringFromBool(value)], ^{ \
				[action consumeDeltaTime:-1.0]; \
				[verifyCount(object, times(2)) setValue:[NSNumber numberWithBool:value] forKey:prop]; \
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
			[given([object valueForKey:prop]) willReturn:[NSNumber numberWithBool:NO]]; \
			[action consumeDeltaTime:1.0]; \
		}); \
		\
		it([NSString stringWithFormat:@"sets %@ to YES", prop], ^{ \
			[verify(object) setValue:[NSNumber numberWithBool:YES] forKey:prop]; \
		}); \
		\
		context(@"updating with a negative time", ^{ \
			it([NSString stringWithFormat:@"sets %@ to NO", prop], ^{ \
				[given([object valueForKey:prop]) willReturn:[NSNumber numberWithBool:YES]]; \
				[action consumeDeltaTime:-1.0]; \
				[verify(object) setValue:[NSNumber numberWithBool:NO] forKey:prop]; \
			}); \
		}); \
	});


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
		
		context(@"calling consumeDeltaTime: with 0.0 seconds", ^{
			__block NSTimeInterval timeLeft1;
			
			beforeEach(^{
				timeLeft1 = [action consumeDeltaTime:0.0];
			});
			
			it(@"returns no time", ^{
				expect(timeLeft1).to.equal(0.0);
			});
			
			it(@"does not call the block", ^{
				expect(callCount).to.equal(0);
			});
		});
			
		context(@"called consumeDeltaTime: with a positive time", ^{
			__block NSTimeInterval timeLeft2;
			
			beforeEach(^{
				timeLeft2 = [action consumeDeltaTime:1.0];
			});
			
			it(@"returns all the time", ^{
				expect(timeLeft2).to.equal(1.0);
			});
			
			it(@"calls the block", ^{
				expect(callCount).to.equal(1);
			});
			
			context(@"called consumeDeltaTime: a second time", ^{
				__block NSTimeInterval timeLeft3;
				
				beforeEach(^{
					timeLeft3 = [action consumeDeltaTime:2.0];
				});
				
				it(@"returns all the time", ^{
					expect(timeLeft3).to.equal(2.0);
				});
				
				it(@"does not call the block again", ^{
					expect(callCount).to.equal(1);
				});
			});
			
			context(@"created a copy of the action", ^{
				__block FUBlockAction* actionCopy;
				
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
					__block NSTimeInterval timeLeft4;
					
					beforeEach(^{
						timeLeft4 = [actionCopy consumeDeltaTime:2.0];
					});
					
					it(@"returns all the time", ^{
						expect(timeLeft4).to.equal(2.0);
					});
					
					it(@"does not call the block again", ^{
						expect(callCount).to.equal(1);
					});
				});
			});
			
			context(@"called consumeDeltaTime: with a negative time", ^{
				__block NSTimeInterval timeLeft5;
				
				beforeEach(^{
					timeLeft5 = [action consumeDeltaTime:-2.0];
				});
				
				it(@"returned all the time", ^{
					expect(timeLeft5).to.equal(-2.0);
				});
				
				it(@"calls the block", ^{
					expect(callCount).to.equal(2);
				});
				
				context(@"called consumeDeltaTime: a second time with a negative time", ^{
					__block NSTimeInterval timeLeft6;
					
					beforeEach(^{
						timeLeft6 = [action consumeDeltaTime:-3.0];
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
	
	context(@"initialized with the FUSwitchOn function", ^{
		__block FUBehavior* object;
		__block FUBlockAction* action;
		
		beforeEach(^{
			object = mock([FUBehavior class]);
			action = FUSwitchOn(object, @"enabled");
		});
		
		FUTestBoolSetsValue(@"enabled", YES);
	});
	
	context(@"initialized with the FUSwitchOff function", ^{
		__block FUBehavior* object;
		__block FUBlockAction* action;
		
		beforeEach(^{
			object = mock([FUBehavior class]);
			action = FUSwitchOff(object, @"enabled");
		});
		
		FUTestBoolSetsValue(@"enabled", NO);
	});
	
	context(@"initialized with the FUToggle function", ^{
		__block FUBehavior* object;
		__block FUBlockAction* action;
		
		beforeEach(^{
			object = mock([FUBehavior class]);
			action = FUToggle(object, @"enabled");
		});
		
		FUTestBoolTogglesValue(@"enabled");
	});
	
	context(@"initialized with the FUEnable function", ^{
		__block FUBehavior* object;
		__block FUBlockAction* action;
		
		beforeEach(^{
			object = mock([FUBehavior class]);
			action = FUEnable(object);
		});
		
		FUTestBoolSetsValue(@"enabled", YES);
	});
	
	context(@"initialized with the FUDisable function", ^{
		__block FUBehavior* object;
		__block FUBlockAction* action;
		
		beforeEach(^{
			object = mock([FUBehavior class]);
			action = FUDisable(object);
		});
		
		FUTestBoolSetsValue(@"enabled", NO);
	});
	
	context(@"initialized with the FUToggleEnabled function", ^{
		__block FUBehavior* object;
		__block FUBlockAction* action;
		
		beforeEach(^{
			object = mock([FUBehavior class]);
			action = FUToggleEnabled(object);
		});
		
		FUTestBoolTogglesValue(@"enabled");
	});
});

SPEC_END