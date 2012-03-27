//
//  FUTransformSpec.m
//  Fuji
//
//  Created by David Hart on 01.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#include "Prefix.pch"
#import "Fuji.h"
#import	"FUComponent-Internal.h"
#import "FUTestFunctions.h"


SPEC_BEGIN(FUTransformSpec)

describe(@"A transform component", ^{
	it(@"is a subclass of FUComponent", ^{
		expect([FUTransform class]).to.beASubclassOf([FUComponent class]);
	});
	
	context(@"created and initialized", ^{
		__block FUTransform* transform = nil;
		
		beforeEach(^{
			id gameObject = mock([FUGameObject class]);
			transform = [[FUTransform alloc] initWithGameObject:gameObject];
		});
		
		it(@"has an initial position of (0, 0)", ^{
			expect([transform position].x).to.equal(0);
			expect([transform position].y).to.equal(0);
			expect([transform positionX]).to.equal(0);
			expect([transform positionY]).to.equal(0);
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
			expect(FUMatrix4EqualToMatrix4([transform matrix], GLKMatrix4Identity)).to.beTruthy();
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
				expect(FUMatrix4EqualToMatrix4([transform matrix], translationMatrix)).to.beTruthy();
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
				expect(FUMatrix4EqualToMatrix4([transform matrix], translationMatrix)).to.beTruthy();
			});
		});
		
		context(@"set the rotation to Pi", ^{
			beforeEach(^{
				[transform setRotation:M_PI];
			});
			
			it(@"has a rotation of Pi", ^{
				expect([transform rotation]).to.equal(M_PI);
			});
			
			it(@"has a matrix with a rotation of Pi around Z", ^{
				GLKMatrix4 rotationMatrix = GLKMatrix4MakeZRotation(M_PI);
				expect(FUMatrix4CloseToMatrix4([transform matrix], rotationMatrix)).to.beTruthy();
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
				expect(FUMatrix4EqualToMatrix4([transform matrix], scaleMatrix)).to.beTruthy();
			});
		});
		
		context(@"set the scale factors seperately to (1.4, 0.8)", ^{
			beforeEach(^{
				[transform setScaleX:1.4];
				[transform setScaleY:0.8];
			});
			
			it(@"has a scale of (1.4, 0.8)", ^{
				expect([transform scale].x).to.equal(1.4);
				expect([transform scale].y).to.equal(0.8);
				expect([transform scaleX]).to.equal(1.4);
				expect([transform scaleY]).to.equal(0.8);
			});
			
			it(@"has a matrix with a scale of (1.4, 0.8)", ^{
				GLKMatrix4 scaleMatrix = GLKMatrix4MakeScale(1.4, 0.8, 1);
				expect(FUMatrix4EqualToMatrix4([transform matrix], scaleMatrix)).to.beTruthy();
			});
		});
	});
});

SPEC_END
