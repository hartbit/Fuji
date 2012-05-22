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


static NSString* const FUActionNilMessage = @"Expected 'action' to not be nil";


@interface FUTestAction : NSObject <FUAction> @end


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
				[given([action1 isComplete]) willReturnBool:NO];
				[animator runAction:action1];
				
				action2 = mock([FUTestAction class]);
				[given([action2 isComplete]) willReturnBool:YES];
				[animator runAction:action2];
			});
			
			it(@"advanced time by 0.0 to kick-off initilization on un-complete actions", ^{
				[verify(action1) updateWithDeltaTime:0.0];
				[[verifyCount(action2, never()) withMatcher:HC_anything()] updateWithDeltaTime:0.0];
			});
			
			context(@"advancing time", ^{
				it(@"advances time on the incomplete action", ^{
					[animator updateWithDeltaTime:1.5];
					[verify(action1) updateWithDeltaTime:1.5];
					[[verifyCount(action2, never()) withMatcher:HC_anything()] updateWithDeltaTime:0.0];
				});
			});
			
			context(@"advancing time with all actions complete", ^{
				it(@"advances time on none of the actions", ^{
					[given([action1 isComplete]) willReturnBool:YES];
					[animator updateWithDeltaTime:2.0];
					[[verifyCount(action2, never()) withMatcher:HC_anything()] updateWithDeltaTime:0.0];
					[[verifyCount(action2, never()) withMatcher:HC_anything()] updateWithDeltaTime:0.0];
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
				
				context(@"advancing time", ^{
					it(@"advances time on the incomplete copied actions", ^{
						[animatorCopy updateWithDeltaTime:1.0];
						[[verify(action1) withMatcher:HC_anything()] updateWithDeltaTime:0.0];
						[[verifyCount(action2, never()) withMatcher:HC_anything()] updateWithDeltaTime:0.0];
						[verify(action1Copy) updateWithDeltaTime:1.0];
						[[verifyCount(action2Copy, never()) withMatcher:HC_anything()] updateWithDeltaTime:0.0];
					});
				});
			});
		});
	});
});

SPEC_END


@implementation FUTestAction
- (id)copyWithZone:(NSZone*)zone { return nil; }
- (BOOL)isComplete { return NO; }
- (void)updateWithDeltaTime:(NSTimeInterval)deltaTime { }
@end