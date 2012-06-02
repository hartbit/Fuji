//
//  FUSpriteRendererSpec.m
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


SPEC_BEGIN(FUSpriteRenderer)

describe(@"A sprite renderer component", ^{
	it(@"is a behavior", ^{
		expect([FUSpriteRenderer class]).to.beSubclassOf([FUBehavior class]);
	});

	it(@"requires a FUTransform", ^{
		expect([FUSpriteRenderer requiredComponents]).to.contain([FUTransform class]);
	});
	
	context(@"initiailized", ^{
		__block FUSpriteRenderer* spriteRenderer;
		
		beforeEach(^{
			FUEntity* entity = mock([FUEntity class]);
			[given([entity scene]) willReturn:mock([FUScene class])];
			spriteRenderer = [[FUSpriteRenderer alloc] initWithEntity:entity];
		});
		
		it(@"has a nil texture", ^{
			expect([spriteRenderer texture]).to.beNil();
		});
		
		context(@"setting the texture to Test.png", ^{
			it(@"has it's texture property to Test.png", ^{
				[spriteRenderer setTexture:@"Test.png"];
				expect([spriteRenderer texture]).to.equal(@"Test.png");
			});
		});
		
		it(@"has a white tint", ^{
			expect(GLKVector4AllEqualToVector4([spriteRenderer tint], FUColorWhite)).to.beTruthy();
		});
		
		context(@"setting the tint to brown", ^{
			it(@"has it's tint property to brown", ^{
				[spriteRenderer setTint:FUColorBrown];
				expect(GLKVector4AllEqualToVector4([spriteRenderer tint], FUColorBrown)).to.beTruthy();
			});
		});
	});
});

SPEC_END