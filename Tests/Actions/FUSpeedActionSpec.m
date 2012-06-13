//
//  FUSpeedActionSpec.m
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


static NSString* const FUActionNilMessage = @"Expected 'action' to not be nil";


@interface FUTestAction : NSObject <FUAction> @end


SPEC_BEGIN(FUSpeedAction)

describe(@"A speed action", ^{
	it(@"is an action", ^{
		expect([[FUSpeedAction class] conformsToProtocol:@protocol(FUAction)]).to.beTruthy();
	});
	
	context(@"initializing with a nil action and a speed of 1.0f", ^{
		it(@"throws an exception", ^{
			assertThrows([[FUSpeedAction alloc] initWithAction:nil speed:1.0f], NSInvalidArgumentException, FUActionNilMessage);
		});
	});
	
	context(@"initialized with an action and a speed of 1.0f", ^{
		__block NSObject<FUAction>* subaction;
		__block FUSpeedAction* action;
		
		beforeEach(^{
			subaction = mockObjectAndProtocol([NSObject class], @protocol(FUAction));
			action = [[FUSpeedAction alloc] initWithAction:subaction speed:1.0];
		});
		
		it(@"has the action", ^{
			expect([action action]).to.beIdenticalTo(subaction);
		});
		
		it(@"has a speed of 1.0", ^{
			expect([action speed]).to.equal(1.0);
		});
		
		context(@"calling consumeDeltaTime: with a positive time", ^{
			it(@"calls consumeDeltaTime: with the same time on the subaction", ^{
				[action consumeDeltaTime:1.3];
				[verify(subaction) consumeDeltaTime:1.3];
			});
		});
		
		context(@"set the speed to 0.0", ^{
			beforeEach(^{
				[action setSpeed:0.0];
			});
			
			it(@"has a speed of 0.0", ^{
				expect([action speed]).to.equal(0.0);
			});
			
			context(@"calling consumeDeltaTime: with a positive time", ^{
				it(@"does not call consumeDeltaTime: on the subaction", ^{
					[action consumeDeltaTime:2.0];
					[[verifyCount(subaction, never()) withMatcher:HC_anything()] consumeDeltaTime:0.0];
				});
			});
		});
		
		context(@"set the speed to a positive value", ^{
			beforeEach(^{
				[action setSpeed:1.5];
			});
			
			it(@"has a speed the speed set", ^{
				expect([action speed]).to.equal(1.5);
			});
			
			context(@"calling consumeDeltaTime: with a positive time", ^{
				it(@"calls consumeDeltaTime: with a time multiplied by the speed on the subaction", ^{
					[action consumeDeltaTime:2.0];
					[verify(subaction) consumeDeltaTime:3.0];
				});
			});
			
			context(@"calling consumeDeltaTime: with a negative time", ^{
				it(@"calls consumeDeltaTime: with a negative time multiplied by the speed on the subaction", ^{
					[action consumeDeltaTime:-1.0];
					[verify(subaction) consumeDeltaTime:-1.5];
				});
			});
			
			context(@"calling consumeDeltaTime: with a positive time and with the subaction returning some time left", ^{
				it(@"returns the time left divided by the speed", ^{
					[given([subaction consumeDeltaTime:3.0]) willReturnDouble:1.5];
					expect([action consumeDeltaTime:2.0]).to.beCloseTo(1.0);
				});
			});
			
			context(@"calling consumeDeltaTime: with a negative time and with the subaction returning some time left", ^{
				it(@"returns the negative time left divided by the speed", ^{
					[given([subaction consumeDeltaTime:-3.0]) willReturnDouble:-1.5];
					expect([action consumeDeltaTime:-2.0]).to.beCloseTo(-1.0);
				});
			});
			
			context(@"created a copy", ^{
				__block NSObject<FUAction>* subactionCopy;
				__block FUSpeedAction* actionCopy;
				
				beforeEach(^{
					subactionCopy = mockObjectAndProtocol([NSObject class], @protocol(FUAction));
					[[given([subaction copyWithZone:nil]) withMatcher:HC_anything()] willReturn:subactionCopy];
					
					actionCopy = [action copy];
				});
				
				it(@"is not the same instance", ^{
					expect(actionCopy).toNot.beIdenticalTo(action);
				});
				
				it(@"has the same speed", ^{
					expect([actionCopy speed]).to.equal(1.5);
				});
				
				it(@"has the copied action", ^{
					expect([actionCopy action]).to.beIdenticalTo(subactionCopy);
				});
				
				context(@"calling consumeDeltaTime: on the copied action", ^{
					it(@"calls consumeDeltaTime: on the copied subaction", ^{
						[actionCopy consumeDeltaTime:1.0];
						[[verifyCount(subaction, never()) withMatcher:HC_anything()] consumeDeltaTime:0.0];
						[verify(subactionCopy) consumeDeltaTime:1.5];
					});
				});
			});
		});
		
		context(@"set the speed to a negative value", ^{
			beforeEach(^{
				[action setSpeed:-2.0];
			});
			
			it(@"has the same speed", ^{
				expect([action speed]).to.equal(-2.0);
			});
			
			context(@"calling consumeDeltaTime: with a positive time", ^{
				it(@"calls consumeDeltaTime: with a negative time from multiplying by the speed on the subaction", ^{
					[action consumeDeltaTime:2.0];
					[verify(subaction) consumeDeltaTime:-4.0];
				});
			});
			
			context(@"calling consumeDeltaTime: with a negative time", ^{
				it(@"calls consumeDeltaTime: with a positive time from multiplying by the speed on the subaction", ^{
					[action consumeDeltaTime:-1.0];
					[verify(subaction) consumeDeltaTime:2.0];
				});
			});
		});
	});
	
	context(@"initializing via the function with a valid action and a speed of 1.0f", ^{
		it(@"returns a FUSpeedAction", ^{
			NSObject<FUAction>* subaction = mockObjectAndProtocol([NSObject class], @protocol(FUAction));
			expect(FUSpeed(subaction, 1.0f)).to.beKindOf([FUSpeedAction class]);
		});
		
		pending(@"test all other tests");
	});
});

SPEC_END
