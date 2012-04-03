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


SPEC_BEGIN(FUSpriteRendererSpec)

describe(@"A sprite renderer component", ^{
	it(@"is a behavior", ^{
		expect([FUSpriteRenderer class]).to.beSubclassOf([FUBehavior class]);
	});
	
	context(@"created and initiailized", ^{
		__block FUSpriteRenderer* spriteRenderer = nil;
		
		beforeEach(^{
			spriteRenderer = [[FUSpriteRenderer alloc] initWithEntity:mock([FUEntity class])];
		});
		
		it(@"is not nil", ^{
			expect(spriteRenderer).toNot.beNil();
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