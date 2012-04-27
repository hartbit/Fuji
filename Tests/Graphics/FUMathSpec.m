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
});

SPEC_END
