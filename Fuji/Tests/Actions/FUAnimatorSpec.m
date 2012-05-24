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

#include "Prefix.pch"
#import "Fuji.h"
#import "FUTestSupport.h"
#import "FUTestAction.h"


static NSString* const FUActionNilMessage = @"Expected 'action' to not be nil";


SPEC_BEGIN(FUAnimator)

describe(@"An animator", ^{	
	context(@"initialized", ^{
		__block FUAnimator* animator;
		
		beforeEach(^{
			animator = [FUAnimator new];
		});
		
		it(@"is not nil", ^{
			expect(animator).toNot.beNil();
		});
		
		context(@"adding a nil action", ^{
			it(@"throws an exception", ^{
				assertThrows([animator runAction:nil], NSInvalidArgumentException, FUActionNilMessage);
			});
		});
		
		context(@"adding two actions", ^{
			__block NSObject<FUAction>* action1;
			__block NSObject<FUAction>* action2;
			
			beforeEach(^{
				action1 = mock([FUTestAction class]);
				[animator runAction:action1];
				
				action2 = mock([FUTestAction class]);
				[animator runAction:action2];
			});
			
			context(@"called consumeDeltaTime: with 0.0 seconds", ^{
				it(@"does not call consumeDeltaTime: on the actions", ^{
					[animator updateWithDeltaTime:0.0];
					[[verifyCount(action1, never()) withMatcher:HC_anything()] consumeDeltaTime:0.0];
					[[verifyCount(action2, never()) withMatcher:HC_anything()] consumeDeltaTime:0.0];
				});
			});
			
			context(@"updated with the second action returning some time left", ^{
				beforeEach(^{
					[given([action2 consumeDeltaTime:1.0]) willReturnDouble:0.5];
					[animator updateWithDeltaTime:1.0];
				});
				
				it(@"calls consumeDeltaTime: with the same time on both actions", ^{
					[verify(action1) consumeDeltaTime:1.0];
					[verify(action2) consumeDeltaTime:1.0];
				});
				
				context(@"updating again", ^{
					it(@"only calls consumeDeltaTime: on the first action", ^{
						[animator updateWithDeltaTime:2.0];
						[verify(action1) consumeDeltaTime:2.0];
						[[verifyCount(action2, times(1)) withMatcher:HC_anything()] consumeDeltaTime:0.0];
					});
				});
				
				context(@"created a copy", ^{
					__block FUAnimator* animatorCopy;
					__block id<FUAction> action1Copy;
					__block id<FUAction> action2Copy;
					
					beforeEach(^{
						action1Copy = mockProtocol(@protocol(FUAction));
						[given([action1 copy]) willReturn:action1Copy];
						
						action2Copy = mockProtocol(@protocol(FUAction));
						[given([action2 copy]) willReturn:action2Copy];
						
						animatorCopy = [animator copy];
					});
					
					it(@"is not nil", ^{
						expect(animatorCopy).toNot.beNil();
					});
					
					it(@"is not the same instance", ^{
						expect(animatorCopy).toNot.beIdenticalTo(animator);
					});
					
					context(@"updating", ^{
						it(@"calls consumeDeltaTime: only on the first copied action", ^{
							[animatorCopy updateWithDeltaTime:2.0];
							[[verifyCount(action1, times(1)) withMatcher:HC_anything()] consumeDeltaTime:0.0];
							[[verifyCount(action2, times(1)) withMatcher:HC_anything()] consumeDeltaTime:0.0];
							[verify(action1Copy) consumeDeltaTime:2.0];
							[[verifyCount(action2Copy, never()) withMatcher:HC_anything()] consumeDeltaTime:0.0];
						});
					});
				});
			});
		});
	});
});

SPEC_END
