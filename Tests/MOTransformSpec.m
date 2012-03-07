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
		it(@"should have an initial scale of (1, 1)", ^{
			expect(GLKVector2AllEqualToVector2([transform scale], GLKVector2One)).to.beTruthy();
		});
	});
	
	context(@"position", ^{
		it(@"should have an initial position of (0, 0)", ^{
			expect(GLKVector2AllEqualToVector2([transform position], GLKVector2Zero)).to.beTruthy();
			expect([transform positionX]).to.beEqualTo(0);
			expect([transform positionY]).to.beEqualTo(0);
		});
		
		it(@"should be possible to set the position", ^{
			GLKVector2 aPosition = GLKVector2Make(4, 7);
			[transform setPosition:aPosition];
			expect(GLKVector2AllEqualToVector2([transform position], aPosition)).to.beTruthy();
			expect([transform positionX]).to.beEqualTo(4);
			expect([transform positionY]).to.beEqualTo(7);
		});
		
		it(@"should be possible to set the position elements seperately", ^{
			[transform setPositionX:3];
			expect([transform positionX]).to.beEqualTo(3);
			expect([transform position].x).to.beEqualTo(3);
			[transform setPositionY:8];
			expect([transform positionY]).to.beEqualTo(8);
			expect([transform position].y).to.beEqualTo(8);
		});
	});
	
	context(@"rotation", ^{
		it(@"should have an initial rotation of 0", ^{
			expect([transform rotation]).to.beEqualTo(0);
		});
		
		it(@"should be possible to set the rotation", ^{
			[transform setRotation:M_PI];
			expect([transform rotation]).to.beEqualTo(M_PI);
		});
	});
	
	context(@"scale", ^{
		it(@"should have an initial scale of (1, 1)", ^{
			expect(GLKVector2AllEqualToVector2([transform scale], GLKVector2One)).to.beTruthy();
			expect([transform scaleX]).to.beEqualTo(1);
			expect([transform scaleY]).to.beEqualTo(1);
		});
		
		it(@"should be possible to set the scale", ^{
			GLKVector2 aScale = GLKVector2Make(2.3f, 6.5f);
			[transform setScale:aScale];
			expect(GLKVector2AllEqualToVector2([transform scale], aScale)).to.beTruthy();
			expect([transform scaleX]).to.beEqualTo(2.3f);
			expect([transform scaleY]).to.beEqualTo(6.5f);
		});
		
		it(@"should be possible to set the scale elements seperately", ^{
			[transform setScaleX:4.0f];
			expect([transform scaleX]).to.beEqualTo(4.0f);
			expect([transform scale].x).to.beEqualTo(4.0f);
			[transform setScaleY:0.5f];
			expect([transform scaleY]).to.beEqualTo(0.5f);
			expect([transform scale].y).to.beEqualTo(0.5f);
		});
	});
});

SPEC_END
