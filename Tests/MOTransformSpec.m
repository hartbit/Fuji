//
//  MOTransformSpec.m
//  Mocha2D
//
//  Created by David Hart on 01.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#define SPT_CEDAR_SYNTAX
#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"
#import "Mocha2D.h"
#import "MOTestFunctions.h"


SPEC_BEGIN(MOTransformSpec)

describe(@"MOTransform", ^{
	__block MOTransform* transform = nil;
	
	beforeEach(^{
		MOGameObject* gameObject = [[MOScene new] addGameObject];
		transform = (MOTransform*)[gameObject addComponentWithClass:[MOTransform class]];
	});
	
	context(@"position", ^{
		it(@"should have an initial position of (0, 0)", ^{
			expect(GLKVector2AllEqualToVector2([transform position], GLKVector2Zero)).to.beTruthy();
			expect([transform positionX]).to.equal(0);
			expect([transform positionY]).to.equal(0);
		});
		
		it(@"should be possible to set the position", ^{
			GLKVector2 aPosition = GLKVector2Make(4, 7);
			[transform setPosition:aPosition];
			expect(GLKVector2AllEqualToVector2([transform position], aPosition)).to.beTruthy();
			expect([transform positionX]).to.equal(4);
			expect([transform positionY]).to.equal(7);
		});
		
		it(@"should be possible to set the position elements seperately", ^{
			[transform setPositionX:3];
			expect([transform positionX]).to.equal(3);
			expect([transform position].x).to.equal(3);
			[transform setPositionY:8];
			expect([transform positionY]).to.equal(8);
			expect([transform position].y).to.equal(8);
		});
	});
	
	context(@"rotation", ^{
		it(@"should have an initial rotation of 0", ^{
			expect([transform rotation]).to.equal(0);
		});
		
		it(@"should be possible to set the rotation", ^{
			[transform setRotation:M_PI];
			expect([transform rotation]).to.equal(M_PI);
		});
	});
	
	context(@"scale", ^{
		it(@"should have an initial scale of (1, 1)", ^{
			expect(GLKVector2AllEqualToVector2([transform scale], GLKVector2One)).to.beTruthy();
			expect([transform scaleX]).to.equal(1);
			expect([transform scaleY]).to.equal(1);
		});
		
		it(@"should be possible to set the scale", ^{
			GLKVector2 aScale = GLKVector2Make(2.3f, 6.5f);
			[transform setScale:aScale];
			expect(GLKVector2AllEqualToVector2([transform scale], aScale)).to.beTruthy();
			expect([transform scaleX]).to.equal(2.3f);
			expect([transform scaleY]).to.equal(6.5f);
		});
		
		it(@"should be possible to set the scale elements seperately", ^{
			[transform setScaleX:4.0f];
			expect([transform scaleX]).to.equal(4.0f);
			expect([transform scale].x).to.equal(4.0f);
			[transform setScaleY:0.5f];
			expect([transform scaleY]).to.equal(0.5f);
			expect([transform scale].y).to.equal(0.5f);
		});
	});
	
	context(@"transform", ^{
		it(@"should have an initial value of identity", ^{
			expect(GLKMatrix4EqualToMatrix4([transform matrix], GLKMatrix4Identity)).to.beTruthy();
		});
		
		it(@"should contain the position", ^{
			[transform setPosition:GLKVector2Make(2, 8)];
			
			GLKMatrix4 matrix = GLKMatrix4Make(1,0,0,0,0,1,0,0,0,0,1,0,2,8,0,1);
			expect(GLKMatrix4EqualToMatrix4([transform matrix], matrix)).to.beTruthy();
		});
		
		it(@"should contain the rotation", ^{
			[transform setRotation:M_PI/2];
			
			GLKMatrix4 matrix = GLKMatrix4Make(0,1,0,0,-1,0,0,0,0,0,1,0,0,0,0,1);
			expect(GLKMatrix4CloseToMatrix4([transform matrix], matrix)).to.beTruthy();			
		});
		
		it(@"should contain the scale", ^{
			[transform setScale:GLKVector2Make(0.5, 2)];
			
			GLKMatrix4 matrix = GLKMatrix4Make(0.5,0,0,0,0,2,0,0,0,0,1,0,0,0,0,1);
			expect(GLKMatrix4EqualToMatrix4([transform matrix], matrix)).to.beTruthy();
		});
	});
});

SPEC_END
