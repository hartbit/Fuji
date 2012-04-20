//
//  FUSceneSpec.m
//  Fuji
//
//  Created by Hart David on 24.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
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
