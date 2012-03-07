//
//  MOTransformSpec.m
//  Mocha2D
//
//  Created by David Hart on 01.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//


SPEC_BEGIN(MOTransformSpec)

describe(@"MOTransform", ^{
	__block MOTransform* transform = nil;
	
	beforeEach(^{
		MOGameObject* gameObject = [MOGameObject new];
		transform = (MOTransform*)[gameObject addComponentWithClass:[MOTransform class]];
	});
	
	context(@"init", ^{
		it(@"should have an initial position of (0, 0)", ^{
			expect(GLKVector2AllEqualToVector2([transform position], GLKVector2Zero)).to.beTruthy();
		});
		
		it(@"should have an initial rotation of 0", ^{
			expect([transform rotation]).to.beEqualTo(0);
		});
		
		it(@"should have an initial scale of (1, 1)", ^{
			expect(GLKVector2AllEqualToVector2([transform scale], GLKVector2One)).to.beTruthy();
		});
	});
});

SPEC_END
