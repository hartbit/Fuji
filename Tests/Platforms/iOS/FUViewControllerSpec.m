//
//  FUViewControllerSpec.m
//  Fuji
//
//  Created by Hart David on 22.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#include "Prefix.pch"
#import "Fuji.h"


SPEC_BEGIN(FUViewControllerSpec)

describe(@"A Fuji view controller", ^{
	it(@"is a subclass of UIViewController", ^{
		expect([FUViewController class]).to.beASubclassOf([UIViewController class]);
	});
	
	context(@"created and initialized", ^{
		__block FUViewController* viewController = nil;
		
		beforeEach(^{
			viewController = [FUViewController new];
		});
		
		it(@"has a valid opengl view", ^{
			expect([viewController view]).to.beKindOf([GLKView class]);
		});
	});
});

SPEC_END
