//
//  FUAnimatorSpec.m
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import <OCHamcrest/HCIsAnything.h>
#include "Prefix.pch"
#import "Fuji.h"
#import "FUComponent-Internal.h"
#import "FUTestSupport.h"
#import "FUTestAction.h"


static NSString* const FUActionNilMessage = @"Expected 'action' to not be nil";


SPEC_BEGIN(FUAnimator)

describe(@"An animator", ^{	
	it(@"is an updatable component", ^{
		expect([FUAnimator class]).to.beSubclassOf([FUUpdatableComponent class]);
	});
	
	context(@"initialized", ^{
		__block FUViewController*controller;
		__block FUAnimator* animator;
		
		beforeEach(^{
			controller = mock([FUViewController class]);
			FUScene* scene = mock([FUScene class]);
			FUEntity* entity = mock([FUEntity class]);

            [given([scene director]) willReturn:controller];
			[given([entity scene]) willReturn:scene];
			animator = [[FUAnimator alloc] initWithEntity:entity];
		});
		
		context(@"adding a nil action", ^{
			it(@"throws an exception", ^{
				assertThrows([animator runAction:nil], NSInvalidArgumentException, FUActionNilMessage);
			});
		});
		
		context(@"added two actions", ^{
			__block NSObject<FUAction>* action1;
			__block NSObject<FUAction>* action2;
			
			beforeEach(^{
				action1 = mock([FUTestAction class]);
				[animator runAction:action1];
				
				action2 = mock([FUTestAction class]);
				[animator runAction:action2];
			});
			
			context(@"called update with 0.0 since last update", ^{
				it(@"does not call consumeDeltaTime: on the actions", ^{
					[given([controller timeSinceLastUpdate]) willReturnDouble:0.0];
					[animator update];
					[[verifyCount(action1, never()) withMatcher:HC_anything()] consumeDeltaTime:0.0];
					[[verifyCount(action2, never()) withMatcher:HC_anything()] consumeDeltaTime:0.0];
				});
			});
			
			context(@"updated with the second action returning some time left", ^{
				beforeEach(^{
					[given([controller timeSinceLastUpdate]) willReturnDouble:1.0];
					[given([action2 consumeDeltaTime:1.0]) willReturnDouble:0.5];
					[animator update];
				});
				
				it(@"calls consumeDeltaTime: with the same time on both actions", ^{
					[verify(action1) consumeDeltaTime:1.0];
					[verify(action2) consumeDeltaTime:1.0];
				});
				
				context(@"updating again", ^{
					it(@"only calls consumeDeltaTime: on the first action", ^{
						[given([controller timeSinceLastUpdate]) willReturnDouble:2.0];
						[animator update];
						[verify(action1) consumeDeltaTime:2.0];
						[[verifyCount(action2, times(1)) withMatcher:HC_anything()] consumeDeltaTime:0.0];
					});
				});
			});
		});
	});
});

SPEC_END
