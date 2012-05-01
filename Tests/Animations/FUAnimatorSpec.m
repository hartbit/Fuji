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
	it(@"is animatable", ^{
		expect([[FUAnimator class] conformsToProtocol:@protocol(FUAnimatable)]).to.beTruthy();
	});
	
	context(@"initialized", ^{
		__block FUAnimator* animator;
		
		beforeEach(^{
			animator = [FUAnimator new];
		});
		
		it(@"is not nil", ^{
			expect(animator).toNot.beNil();
		});
		
		context(@"adding two animatables", ^{
			__block id<FUAnimatable> animatable1;
			__block id<FUAnimatable> animatable2;
			
			beforeEach(^{
				animatable1 = mockProtocol(@protocol(FUAnimatable));
				[animator playAnimatable:animatable1];
				animatable2 = mockProtocol(@protocol(FUAnimatable));
				[animator playAnimatable:animatable2];
			});
			
			context(@"advancing time", ^{
				it(@"advances time on the animatables", ^{
					[animator advanceTime:1.5f];
					[verify(animatable1) advanceTime:1.5f];
					[verify(animatable2) advanceTime:1.5f];
				});
			});
		});
	});
});

SPEC_END
