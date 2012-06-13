//
//  FUGraphicsSettingsSpec.m
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


SPEC_BEGIN(FUGraphicsSettings)

describe(@"The graphics settings", ^{
	it(@"is a subclass of FUComponent", ^{
		expect([FUGraphicsSettings class]).to.beASubclassOf([FUComponent class]);
	});
	
	it(@"requires a FUGraphicsEngine", ^{
		expect([FURenderer requiredEngines]).to.contain([FUGraphicsEngine class]);
	});
	
	context(@"initialized", ^{
		__block FUGraphicsSettings* graphics;
		
		beforeEach(^{
			FUEntity* entity = mock([FUEntity class]);
			[given([entity scene]) willReturn:mock([FUScene class])];
			graphics = [[FUGraphicsSettings alloc] initWithEntity:entity];
		});
		
		it(@"is not nil", ^{
			expect(graphics).toNot.beNil();
		});
		
		it(@"has a default background color of Cornflower Blue", ^{
			expect(GLKVector4AllEqualToVector4([graphics backgroundColor], FUColorCornflowerBlue)).to.beTruthy();
		});
		
		it(@"setting the background color to Gray", ^{
			it(@"has a background color of Gray", ^{
				[graphics setBackgroundColor:FUColorGray];
				expect(GLKVector4AllEqualToVector4([graphics backgroundColor], FUColorGray)).to.beTruthy();
			});
		});
	});
});

SPEC_END
