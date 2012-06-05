//
//  FURendererSpec.m
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


SPEC_BEGIN(FURenderer)

describe(@"A renderer component", ^{
	it(@"is a behavior", ^{
		expect([FURenderer class]).to.beSubclassOf([FUBehavior class]);
	});
	
	it(@"requires a FUTransform", ^{
		expect([FURenderer requiredComponents]).to.contain([FUTransform class]);
	});
	
	it(@"requires a FUGraphicsEngine", ^{
		expect([FURenderer requiredEngines]).to.contain([FUGraphicsEngine class]);
	});
	
	context(@"initiailized", ^{
		__block FURenderer* renderer;
		
		beforeEach(^{
			FUEntity* entity = mock([FUEntity class]);
			[given([entity scene]) willReturn:mock([FUScene class])];
			renderer = [[FURenderer alloc] initWithEntity:entity];
		});
		
		it(@"has a white tint", ^{
			expect(GLKVector4AllEqualToVector4([renderer tint], FUColorWhite)).to.beTruthy();
		});
		
		context(@"setting the tint to brown", ^{
			it(@"has it's tint property to brown", ^{
				[renderer setTint:FUColorBrown];
				expect(GLKVector4AllEqualToVector4([renderer tint], FUColorBrown)).to.beTruthy();
			});
		});
	});
});

SPEC_END