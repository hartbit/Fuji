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
#import "FUTestSupport.h"


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
	
	context(@"FUClampFloat", ^{
		it(@"throws an exception when the min value is greater than the max value", ^{
			assertThrows(FUClampFloat(0.0f, 1.0f, -1.0f), NSInvalidArgumentException, @"Expected 'min=1' to be less than or equal to 'max=-1'");
		});
		
		it(@"does not throw an exception when min = max", ^{
			assertNoThrow(FUClampFloat(0.0f, 0.0f, 0.0f));
		});
		
		it(@"returns the same value if within the range", ^{
			expect(FUClampFloat(1.0f, 0.1f, 4.5f)).to.equal(1.0f);
		});
		
		it(@"returns the min value if less than min", ^{
			expect(FUClampFloat(3.5f, 4.1f, 8.7f)).to.equal(4.1f);
		});
		
		it(@"returns the max value if greater than max", ^{
			expect(FUClampFloat(2.5f, -2.0f, 1.3f)).to.equal(1.3f);
		});
	});
	
	context(@"FUClampDouble", ^{
		it(@"throws an exception when the min value is greater than the max value", ^{
			assertThrows(FUClampDouble(0.0, 1.0, -1.0), NSInvalidArgumentException, @"Expected 'min=1' to be less than or equal to 'max=-1'");
		});
		
		it(@"does not throw an exception when min = max", ^{
			assertNoThrow(FUClampDouble(0.0, 0.0, 0.0));
		});
		
		it(@"returns the same value if within the range", ^{
			expect(FUClampDouble(1.0, 0.1, 4.5)).to.equal(1.0);
		});
		
		it(@"returns the min value if less than min", ^{
			expect(FUClampDouble(3.5, 4.1, 8.7)).to.equal(4.1);
		});
		
		it(@"returns the max value if greater than max", ^{
			expect(FUClampDouble(2.5, -2.0, 1.3)).to.equal(1.3);
		});
	});
});

SPEC_END
