//
//  FUGraphicsEngineSpec.m
//  Fuji
//
//  Created by Hart David on 24.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#include "Prefix.pch"
#import "Fuji.h"
#import	"FUComponent-Internal.h"


SPEC_BEGIN(FUGraphicsEngineSpec)

describe(@"The graphics engine", ^{
	it(@"is a subclass of FUBehavior", ^{
		expect([FUGraphicsSettings class]).to.beASubclassOf([FUComponent class]);
	});
	
	context(@"created and initialized", ^{
		__block FUGraphicsSettings* graphicsSettings = nil;
		
		beforeEach(^{
			graphicsSettings = [[FUGraphicsSettings alloc] initWithEntity:mock([FUEntity class])];
		});
		
		it(@"is not nil", ^{
			expect(graphicsSettings).toNot.beNil();
		});
		
		it(@"has a default background color of Cornflower Blue", ^{
			expect(GLKVector4AllEqualToVector4([graphicsSettings backgroundColor], FUColorCornflowerBlue)).to.beTruthy();
		});
		
		it(@"setting the background color to Gray", ^{
			it(@"has a background color of Gray", ^{
				[graphicsSettings setBackgroundColor:FUColorGray];
				expect(GLKVector4AllEqualToVector4([graphicsSettings backgroundColor], FUColorGray)).to.beTruthy();
			});
		});
	});
});

SPEC_END
