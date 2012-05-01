//
//  FUAnimatorSpec.m
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


SPEC_BEGIN(FUAnimator)

describe(@"An animator", ^{
	it(@"is an action", ^{
		expect([[FUAnimator class] conformsToProtocol:@protocol(FUAction)]).to.beTruthy();
	});
	
	context(@"initialized", ^{
		__block FUAnimator* animator;
		
		beforeEach(^{
			animator = [FUAnimator new];
		});
		
		it(@"is not nil", ^{
			expect(animator).toNot.beNil();
		});
		
		context(@"adding two actions", ^{
			__block id<FUAction> action1;
			__block id<FUAction> action2;
			
			beforeEach(^{
				action1 = mockProtocol(@protocol(FUAction));
				[given([action2 isComplete]) willReturnBool:NO];
				[animator playAction:action1];
				
				action2 = mockProtocol(@protocol(FUAction));
				[given([action2 isComplete]) willReturnBool:YES];
				[animator playAction:action2];
			});
			
			context(@"advancing time", ^{
				it(@"advances time on the incomplete action", ^{
					[animator advanceTime:1.5f];
					[verify(action1) advanceTime:1.5f];
					[verifyCount(action2, never()) advanceTime:1.5f];
				});
			});
			
			context(@"advancing time with an action that completes later", ^{
				it(@"advances time on none of the actions", ^{
					[given([action1 isComplete]) willReturnBool:NO];
					[animator advanceTime:1.5f];
					[verifyCount(action2, never()) advanceTime:1.5f];
					[verifyCount(action2, never()) advanceTime:1.5f];
				});
			});
		});
	});
});

SPEC_END
