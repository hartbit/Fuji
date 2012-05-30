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
static NSString* const FUTargetNilMessage = @"Expected target to not be nil";
static NSString* const FUPropertyNilMessage = @"Expected property to not be nil or empty";
static NSString* const FUPropertyUndefinedMessage = @"The 'property=%@' is not defined for 'object=%@'";
static NSString* const FUPropertyNumericalMessage = @"Expected 'property=%@' on 'object=%@' to be of a numerical type";
static NSString* const FUPropertyReadonlyMessage = @"Expected 'property=%@' on 'object=%@' to be readwrite but was readonly";


@interface FUBoolObject : NSObject
@property (nonatomic, getter=isEnabled) BOOL enabled;
@end


#define FUTestBoolTogglesValue(prop) \
	it(@"is not nil", ^{ \
		expect(action).toNot.beNil(); \
	}); \
	\
	context(@"updated with a positive time", ^{ \
		beforeEach(^{ \
			[target setValue:[NSNumber numberWithBool:NO] forKey:prop]; \
			[action consumeDeltaTime:1.0]; \
		}); \
		\
		it([NSString stringWithFormat:@"sets %@ to YES", prop], ^{ \
			expect([target valueForKey:prop]).to.equal([NSNumber numberWithBool:YES]); \
		}); \
		\
		context(@"updating with a negative time", ^{ \
			it([NSString stringWithFormat:@"sets %@ to NO", prop], ^{ \
				[action consumeDeltaTime:-1.0]; \
				expect([target valueForKey:prop]).to.equal([NSNumber numberWithBool:NO]); \
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
	
	context(@"FUSwitchOn function", ^{
		context(@"initializing with a nil object", ^{
			it(@"throws an exception", ^{
				assertThrows(FUSwitchOn(nil, @"length"), NSInvalidArgumentException, FUTargetNilMessage);
			});
		});
		
		context(@"initializing with a nil property", ^{
			it(@"throws an exception", ^{
				assertThrows(FUSwitchOn([NSMutableData data], nil), NSInvalidArgumentException, FUPropertyNilMessage);
			});
		});
		
		context(@"initializing with an empty property", ^{
			it(@"throws an exception", ^{
				assertThrows(FUSwitchOn([NSMutableData data], @""), NSInvalidArgumentException, FUPropertyNilMessage);
			});
		});
		
		context(@"initializing with a property that is not defined on the object", ^{
			it(@"throws an exception", ^{
				id object = [NSMutableData data];
				NSString* property = @"undefined";
				assertThrows(FUSwitchOn(object, property), NSInvalidArgumentException, FUPropertyUndefinedMessage, property, object);
			});
		});
		
		context(@"initializing with a property that is not of a numerical type", ^{
			it(@"throws an exception", ^{
				id object = [NSMutableURLRequest requestWithURL:nil];
				NSString* property = @"URL";
				assertThrows(FUSwitchOn(object, property), NSInvalidArgumentException, FUPropertyNumericalMessage, property, object);
			});
		});
		
		context(@"initializing with a property that is readonly", ^{
			it(@"throws an exception", ^{
				id object = [NSString string];
				NSString* property = @"length";
				assertThrows(FUSwitchOn(object, property), NSInvalidArgumentException, FUPropertyReadonlyMessage, property, object);
			});
		});
		
		context(@"initialized with valid arguments", ^{
			__block FUBoolObject* target;
			__block FUTimedAction* action;
			
			beforeEach(^{
				target = [FUBoolObject new];
				[target setEnabled:NO];
				action = FUSwitchOn(target, @"enabled");
			});
			
			it(@"is a timed action", ^{
				expect(action).to.beKindOf([FUTimedAction class]);
			});

			context(@"updated with a positive time", ^{
				beforeEach(^{
					[action consumeDeltaTime:1.0];
				});
				
				it(@"is enabled", ^{
					expect([target isEnabled]).to.beTruthy();
				});
				
				context(@"updating with a negative time", ^{
					it(@"is still enabled", ^{
						[action consumeDeltaTime:-1.0];
						expect([target isEnabled]).to.beTruthy();
					});
				});
			});
		});
	});
	
	context(@"FUSwitchOff function", ^{
		context(@"initializing with a nil object", ^{
			it(@"throws an exception", ^{
				assertThrows(FUSwitchOff(nil, @"length"), NSInvalidArgumentException, FUTargetNilMessage);
			});
		});
		
		context(@"initializing with a nil property", ^{
			it(@"throws an exception", ^{
				assertThrows(FUSwitchOff([NSMutableData data], nil), NSInvalidArgumentException, FUPropertyNilMessage);
			});
		});
		
		context(@"initializing with an empty property", ^{
			it(@"throws an exception", ^{
				assertThrows(FUSwitchOff([NSMutableData data], @""), NSInvalidArgumentException, FUPropertyNilMessage);
			});
		});
		
		context(@"initializing with a property that is not defined on the object", ^{
			it(@"throws an exception", ^{
				id object = [NSMutableData data];
				NSString* property = @"undefined";
				assertThrows(FUSwitchOff(object, property), NSInvalidArgumentException, FUPropertyUndefinedMessage, property, object);
			});
		});
		
		context(@"initializing with a property that is not of a numerical type", ^{
			it(@"throws an exception", ^{
				id object = [NSMutableURLRequest requestWithURL:nil];
				NSString* property = @"URL";
				assertThrows(FUSwitchOff(object, property), NSInvalidArgumentException, FUPropertyNumericalMessage, property, object);
			});
		});
		
		context(@"initializing with a property that is readonly", ^{
			it(@"throws an exception", ^{
				id object = [NSString string];
				NSString* property = @"length";
				assertThrows(FUSwitchOff(object, property), NSInvalidArgumentException, FUPropertyReadonlyMessage, property, object);
			});
		});
		
		context(@"initialized with valid arguments", ^{
			__block FUBoolObject* target;
			__block FUCallAction* action;
			
			beforeEach(^{
				target = [FUBoolObject new];
				[target setEnabled:YES];
				action = FUSwitchOff(target, @"enabled");
			});
			
			it(@"is a timed action", ^{
				expect(action).to.beKindOf([FUTimedAction class]);
			});
			
			context(@"updated with a positive time", ^{
				beforeEach(^{
					[action consumeDeltaTime:1.0];
				});
				
				it(@"is disabled", ^{
					expect([target isEnabled]).to.beFalsy();
				});
				
				context(@"updating with a negative time", ^{
					it(@"is still disabled", ^{
						[action consumeDeltaTime:-1.0];
						expect([target isEnabled]).to.beFalsy();
					});
				});
			});
		});
	});
	
	context(@"FUToggle function", ^{
		context(@"initializing with a nil object", ^{
			it(@"throws an exception", ^{
				assertThrows(FUToggle(nil, @"length"), NSInvalidArgumentException, FUTargetNilMessage);
			});
		});
		
		context(@"initializing with a nil property", ^{
			it(@"throws an exception", ^{
				assertThrows(FUToggle([NSMutableData data], nil), NSInvalidArgumentException, FUPropertyNilMessage);
			});
		});
		
		context(@"initializing with an empty property", ^{
			it(@"throws an exception", ^{
				assertThrows(FUToggle([NSMutableData data], @""), NSInvalidArgumentException, FUPropertyNilMessage);
			});
		});
		
		context(@"initializing with a property that is not defined on the object", ^{
			it(@"throws an exception", ^{
				id object = [NSMutableData data];
				NSString* property = @"undefined";
				assertThrows(FUToggle(object, property), NSInvalidArgumentException, FUPropertyUndefinedMessage, property, object);
			});
		});
		
		context(@"initializing with a property that is not of a numerical type", ^{
			it(@"throws an exception", ^{
				id object = [NSMutableURLRequest requestWithURL:nil];
				NSString* property = @"URL";
				assertThrows(FUToggle(object, property), NSInvalidArgumentException, FUPropertyNumericalMessage, property, object);
			});
		});
		
		context(@"initializing with a property that is readonly", ^{
			it(@"throws an exception", ^{
				id object = [NSString string];
				NSString* property = @"length";
				assertThrows(FUToggle(object, property), NSInvalidArgumentException, FUPropertyReadonlyMessage, property, object);
			});
		});
		
		context(@"initialized with valid arguments", ^{
			__block FUBoolObject* target;
			__block FUCallAction* action;
			
			beforeEach(^{
				target = [FUBoolObject new];
				[target setEnabled:NO];
				action = FUToggle(target, @"enabled");
			});
			
			it(@"is a timed action", ^{
				expect(action).to.beKindOf([FUTimedAction class]);
			});
			
			context(@"updated with a positive time", ^{
				beforeEach(^{
					[action consumeDeltaTime:1.0]; \
				});
				
				it(@"is enabled", ^{
					expect([target isEnabled]).to.beTruthy();
				});
			
				context(@"updating with a negative time", ^{
					it(@"has toggled to disabled", ^{
						[action consumeDeltaTime:-1.0];
						expect([target isEnabled]).to.beFalsy();
					});
				});
			});
		});
	});
	
	context(@"initialized with the FUEnable function", ^{
		__block FUBoolObject* target;
		__block FUCallAction* action;
		
		beforeEach(^{
			target = [FUBoolObject new];
			[target setEnabled:NO];
			action = FUEnable(target);
		});
		
		it(@"is a timed action", ^{
			expect(action).to.beKindOf([FUTimedAction class]);
		});
		
		context(@"updated with a positive time", ^{
			beforeEach(^{
				[action consumeDeltaTime:1.0];
			});
			
			it(@"is not enabled", ^{
				expect([target isEnabled]).to.beTruthy();
			});
			
			context(@"updating with a negative time", ^{
				it(@"is still enabled", ^{
					[action consumeDeltaTime:-1.0];
					expect([target isEnabled]).to.beTruthy();
				});
			});
		});
	});
	
	context(@"initialized with the FUDisable function", ^{
		__block FUBoolObject* target;
		__block FUCallAction* action;
		
		beforeEach(^{
			target = [FUBoolObject new];
			[target setEnabled:YES];
			action = FUDisable(target);
		});
		
		it(@"is a timed action", ^{
			expect(action).to.beKindOf([FUTimedAction class]);
		});
		
		context(@"updated with a positive time", ^{
			beforeEach(^{
				[action consumeDeltaTime:1.0];
			});
			
			it(@"is disabled", ^{
				expect([target isEnabled]).to.beFalsy();
			});
			
			context(@"updating with a negative time", ^{
				it(@"is still disabled", ^{
					[action consumeDeltaTime:-1.0];
					expect([target isEnabled]).to.beFalsy();
				});
			});
		});
	});
	
	context(@"initialized with the FUToggleEnabled function", ^{
		__block FUBoolObject* target;
		__block FUCallAction* action;
		
		beforeEach(^{
			target = [FUBoolObject new];
			action = FUToggleEnabled(target);
		});
		
		FUTestBoolTogglesValue(@"enabled");
	});
});

SPEC_END


@implementation FUBoolObject
@synthesize enabled = _enabled;
@end