//
//  FUSpriteRendererSpec.m
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
		__block FUSpriteRenderer* spriteRenderer = nil;
		
		beforeEach(^{
			FUEntity* entity = mock([FUEntity class]);
			[given([entity scene]) willReturn:mock([FUScene class])];
			spriteRenderer = [[FUSpriteRenderer alloc] initWithEntity:entity];
		});
		
		it(@"is not nil", ^{
			expect(spriteRenderer).toNot.beNil();
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
		
		it(@"has a white color", ^{
			expect(FUColorAreEqual([spriteRenderer color], FUColorWhite)).to.beTruthy();
		});
		
		context(@"setting the color to brown", ^{
			it(@"has it's color property to brown", ^{
				[spriteRenderer setColor:FUColorBrown];
				expect(FUColorAreEqual([spriteRenderer color], FUColorBrown)).to.beTruthy();
			});
		});
	});
});

SPEC_END