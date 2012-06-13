//
//  FUTransformSpec.m
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
#import "FUComponent-Internal.h"
#import "FUTestSupport.h"


SPEC_BEGIN(FUTransform)

describe(@"A transform component", ^{
	it(@"is a subclass of FUComponent", ^{
		expect([FUTransform class]).to.beASubclassOf([FUComponent class]);
	});
	
	context(@"initialized", ^{
		__block FUTransform* transform;
		
		beforeEach(^{
			FUEntity* entity = mock([FUEntity class]);
			[given([entity scene]) willReturn:mock([FUScene class])];
			transform = [[FUTransform alloc] initWithEntity:entity];
		});
		
		it(@"has an initial position of (0, 0)", ^{
			expect([transform position].x).to.equal(0);
			expect([transform position].y).to.equal(0);
			expect([transform positionX]).to.equal(0);
			expect([transform positionY]).to.equal(0);
		});
		
		it(@"has an initial depth of 0", ^{
			expect([transform depth]).to.equal(0);
		});
		
		it(@"has an initial rotation of 0", ^{
			expect([transform rotation]).to.equal(0);
		});
		
		it(@"has an initial scale of (1, 1)", ^{
			expect([transform scale].x).to.equal(1);
			expect([transform scale].y).to.equal(1);
			expect([transform scaleX]).to.equal(1);
			expect([transform scaleY]).to.equal(1);
		});
		
		it(@"has an initial matrix of identity", ^{
			expect(FUMatrix4AreEqual([transform matrix], GLKMatrix4Identity)).to.beTruthy();
		});
		
		context(@"set the position to (4, 7)", ^{
			beforeEach(^{
				[transform setPosition:GLKVector2Make(4, 7)];
			});
			
			it(@"has a position of (4, 7)", ^{
				expect([transform position].x).to.equal(4);
				expect([transform position].y).to.equal(7);
				expect([transform positionX]).to.equal(4);
				expect([transform positionY]).to.equal(7);
			});
			
			it(@"has a matrix with a translation of (4, 7)", ^{
				GLKMatrix4 translationMatrix = GLKMatrix4MakeTranslation(4, 7, 0);
				expect(FUMatrix4AreEqual([transform matrix], translationMatrix)).to.beTruthy();
			});
		});
		
		context(@"set the position coordinates seperately to (5, 9)", ^{
			beforeEach(^{
				[transform setPositionX:5];
				[transform setPositionY:9];
			});
			
			it(@"has a position of (5, 9)", ^{
				expect([transform position].x).to.equal(5);
				expect([transform position].y).to.equal(9);
				expect([transform positionX]).to.equal(5);
				expect([transform positionY]).to.equal(9);
			});
			
			it(@"has a matrix with a translation of (5, 9)", ^{
				GLKMatrix4 translationMatrix = GLKMatrix4MakeTranslation(5, 9, 0);
				expect(FUMatrix4AreEqual([transform matrix], translationMatrix)).to.beTruthy();
			});
		});
		
		context(@"set the depth to 5", ^{
			beforeEach(^{
				[transform setDepth:5];
			});
			
			it(@"has a depth of 5", ^{
				expect([transform depth]).to.equal(5);
			});
			
			it(@"has a matrix with a z translation of (5)", ^{
				GLKMatrix4 translationMatrix = GLKMatrix4MakeTranslation(0, 0, 5);
				expect(FUMatrix4AreEqual([transform matrix], translationMatrix)).to.beTruthy();
			});
		});
		
		context(@"set the rotation to Pi", ^{
			beforeEach(^{
				[transform setRotation:(float)M_PI];
			});
			
			it(@"has a rotation of Pi", ^{
				expect([transform rotation]).to.equal(M_PI);
			});
			
			it(@"has a matrix with a rotation of Pi around Z", ^{
				GLKMatrix4 rotationMatrix = GLKMatrix4MakeZRotation((float)M_PI);
				expect(FUMatrix4AreClose([transform matrix], rotationMatrix)).to.beTruthy();
			});
		});
		
		context(@"set the scale to (0.5, 2)", ^{
			beforeEach(^{
				[transform setScale:GLKVector2Make(0.5, 2)];
			});
			
			it(@"has a scale of (0.5, 2)", ^{
				expect([transform scale].x).to.equal(0.5);
				expect([transform scale].y).to.equal(2);
				expect([transform scaleX]).to.equal(0.5);
				expect([transform scaleY]).to.equal(2);
			});
			
			it(@"has a matrix with a scale of (0.5, 2)", ^{
				GLKMatrix4 scaleMatrix = GLKMatrix4MakeScale(0.5, 2, 1);
				expect(FUMatrix4AreEqual([transform matrix], scaleMatrix)).to.beTruthy();
			});
		});
		
		context(@"set the scale factors seperately to (1.4, 0.8)", ^{
			beforeEach(^{
				[transform setScaleX:1.4f];
				[transform setScaleY:0.8f];
			});
			
			it(@"has a scale of (1.4, 0.8)", ^{
				expect([transform scale].x).to.equal(1.4);
				expect([transform scale].y).to.equal(0.8);
				expect([transform scaleX]).to.equal(1.4);
				expect([transform scaleY]).to.equal(0.8);
			});
			
			it(@"has a matrix with a scale of (1.4, 0.8)", ^{
				GLKMatrix4 scaleMatrix = GLKMatrix4MakeScale(1.4f, 0.8f, 1.0f);
				expect(FUMatrix4AreEqual([transform matrix], scaleMatrix)).to.beTruthy();
			});
		});
	});
});

SPEC_END
