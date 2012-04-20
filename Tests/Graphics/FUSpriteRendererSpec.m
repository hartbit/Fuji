//
//  FUSpriteRendererSpec.m
//  Fuji
//
//  Created by David Hart on 01.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
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
			expect(GLKVector4AllEqualToVector4([spriteRenderer color], FUColorWhite)).to.beTruthy();
		});
		
		context(@"setting the color to brown", ^{
			it(@"has it's color property to brown", ^{
				[spriteRenderer setColor:FUColorBrown];
				expect(GLKVector4AllEqualToVector4([spriteRenderer color], FUColorBrown)).to.beTruthy();
			});
		});
	});
});

SPEC_END