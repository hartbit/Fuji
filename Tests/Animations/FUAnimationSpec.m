//
//  FUAnimationSpec.m
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

SPEC_BEGIN(FUAnimation)

describe(@"An animation", ^{
	it(@"initialized with init", ^{
		__block FUAnimation* animation;
		
		beforeEach(^{
			animation = [FUAnimation new];
		});
		
		it(@"has a duration of 0", ^{
			expect([animation duration]).to.equal(0.0);
		});
		
		it(@"has a speed of 1", ^{
			expect([animation speed]).to.equal(1);
		});
		
		it(@"is not playing", ^{
			expect([animation isPlaying]).to.beFalsy();
		});
	});
});

SPEC_END
