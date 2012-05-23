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
		__block id<FUAction> subaction;
		__block FUSpeedAction* action;
		
		beforeEach(^{
			subaction = mockProtocol(@protocol(FUAction));
			action = [[FUSpeedAction alloc] initWithAction:subaction speed:1.0];
		});
		
		it(@"is not nil", ^{
			expect(action).toNot.beNil();
		});
		
		it(@"has a speed of 1.0", ^{
			expect([action speed]).to.equal(1.0);
		});
		
		context(@"updating with 1.3 seconds", ^{
			it(@"updates the subaction with 1.3 seconds", ^{
				[action updateWithDeltaTime:1.3];
				[verify(subaction) updateWithDeltaTime:1.3];
			});
		});
		
		context(@"set the speed at 0.0", ^{
			beforeEach(^{
				[action setSpeed:0.0];
			});
			
			it(@"has a speed of 0.0", ^{
				expect([action speed]).to.equal(0.0);
			});
			
			context(@"updating with 2.0 seconds", ^{
				it(@"does not update the subaction", ^{
					[action updateWithDeltaTime:2.0];
					[[verifyCount(subaction, never()) withMatcher:HC_anything()] updateWithDeltaTime:0.0];
				});
			});
		});
		
		context(@"set the speed at 1.5", ^{
			beforeEach(^{
				[action setSpeed:1.5];
			});
			
			it(@"has a speed of 1.5", ^{
				expect([action speed]).to.equal(1.5);
			});
			
			context(@"updating with 2.0 seconds", ^{
				it(@"updates the subaction with 3.0 seconds", ^{
					[action updateWithDeltaTime:2.0];
					[verify(subaction) updateWithDeltaTime:3.0];
				});
			});
			
			context(@"updating with -1.0 seconds", ^{
				it(@"updates the subaction with -1.5 seconds", ^{
					[action updateWithDeltaTime:-1.0];
					[verify(subaction) updateWithDeltaTime:-1.5];
				});
			});
			
			context(@"updating with 2.0 seconds and the subaction completing with 1.5 seconds left", ^{
				it(@"completes with 1.0 seconds left", ^{
					[given([subaction updateWithDeltaTime:3.0]) willReturnDouble:1.5];
					expect([action updateWithDeltaTime:2.0]).to.beCloseTo(1.0);
				});
			});
			
			context(@"updating with -2.0 seconds and the subaction completing with -1.5 seconds left", ^{
				it(@"completes with -1.0 seconds left", ^{
					[given([subaction updateWithDeltaTime:-3.0]) willReturnDouble:-1.5];
					expect([action updateWithDeltaTime:-2.0]).to.beCloseTo(-1.0);
				});
			});
			
			context(@"created a copy", ^{
				__block id<FUAction> subactionCopy;
				__block FUSpeedAction* actionCopy;
				
				beforeEach(^{
					subactionCopy = mockProtocol(@protocol(FUAction));
					[[given([subaction copyWithZone:nil]) withMatcher:HC_anything()] willReturn:subactionCopy];
					
					actionCopy = [action copy];
				});
				
				it(@"is not nil", ^{
					expect(actionCopy).toNot.beNil();
				});
				
				it(@"is not the same instance", ^{
					expect(actionCopy).toNot.beIdenticalTo(action);
				});
				
				it(@"has a speed of 1.5", ^{
					expect([actionCopy speed]).to.equal(1.5);
				});
				
				context(@"updating the copied action", ^{
					it(@"updates the copied subaction", ^{
						[actionCopy updateWithDeltaTime:1.0];
						[[verifyCount(subaction, never()) withMatcher:HC_anything()] updateWithDeltaTime:0.0];
						[verify(subactionCopy) updateWithDeltaTime:1.5];
					});
				});
			});
		});
		
		context(@"set the speed at -2.0", ^{
			beforeEach(^{
				[action setSpeed:-2.0];
			});
			
			it(@"has a speed of -2.0", ^{
				expect([action speed]).to.equal(-2.0);
			});
			
			context(@"updating with 2.0 seconds", ^{
				it(@"updates the subaction with -4.0 seconds", ^{
					[action updateWithDeltaTime:2.0];
					[verify(subaction) updateWithDeltaTime:-4.0];
				});
			});
			
			context(@"updating with -1.0 seconds", ^{
				it(@"updates the subaction with 2.0 seconds", ^{
					[action updateWithDeltaTime:-1.0];
					[verify(subaction) updateWithDeltaTime:2.0];
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