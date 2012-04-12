//
//  FUGraphicsSettingsSpec.m
//  Fuji
//
//  Created by Hart David on 24.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#include "Prefix.pch"
#import "Fuji.h"
#import "FUComponent-Internal.h"


SPEC_BEGIN(FUGraphicsSettingsSpec)

describe(@"The graphics settings", ^{
	it(@"is a subclass of FUComponent", ^{
		expect([FUGraphicsSettings class]).to.beASubclassOf([FUComponent class]);
	});
	
	context(@"created and initialized", ^{
		__block FUGraphicsSettings* graphics = nil;
		
		beforeEach(^{
			FUScene* scene = mock([FUScene class]);
			FUEntity* entity = mock([FUEntity class]);
			[given([entity scene]) willReturn:scene];
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
