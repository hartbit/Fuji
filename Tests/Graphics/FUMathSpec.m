//
//  FUSceneSpec.m
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


SPEC_BEGIN(FUMath)

describe(@"FUMath", ^{
	it(@"has a GLKVector2 constant that equals (0, 0)", ^{
		GLKVector2 zero = GLKVector2Make(0, 0);
		expect(GLKVector2AllEqualToVector2(GLKVector2Zero, zero)).to.beTruthy();
	});
		
	it(@"has a GLKVector2 constant that equals (1, 1)", ^{
		GLKVector2 one = GLKVector2Make(1, 1);
		expect(GLKVector2AllEqualToVector2(GLKVector2One, one)).to.beTruthy();
	});
	
	context(@"FUClamp", ^{
		it(@"throws an exception when the min value is greater than the max value", ^{
			STAssertThrows(FUClamp(0, 1, -1), nil);
		});
		
		it(@"does not throw an exception when min = max", ^{
			STAssertNoThrow(FUClamp(0, 0, 0), nil);
		});
		
		it(@"returns the same value if within the range", ^{
			expect(FUClamp(1.0, 0.1, 4.5)).to.equal(1.0);
		});
		
		it(@"returns the min value if less than min", ^{
			expect(FUClamp(3.5, 4.1, 8.7)).to.equal(4.1);
		});
		
		it(@"returns the max value if greater than max", ^{
			expect(FUClamp(2.5, -2.0, 1.3)).to.equal(1.3);
		});
	});
});

SPEC_END
