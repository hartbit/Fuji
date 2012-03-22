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
		
		it(@"it's view is the size of the screen", ^{
			CGSize viewSize = [[viewController view] bounds].size;
			CGSize screenSize = [[UIScreen mainScreen] bounds].size;
			expect(CGSizeEqualToSize(viewSize, screenSize)).to.beTruthy();
		});
		
		it(@"automatically rotates in all orientations", ^{
			expect([viewController shouldAutorotateToInterfaceOrientation:UIInterfaceOrientationPortrait]).to.beTruthy();
			expect([viewController shouldAutorotateToInterfaceOrientation:UIInterfaceOrientationPortraitUpsideDown]).to.beTruthy();
			expect([viewController shouldAutorotateToInterfaceOrientation:UIInterfaceOrientationLandscapeLeft]).to.beTruthy();
			expect([viewController shouldAutorotateToInterfaceOrientation:UIInterfaceOrientationLandscapeRight]).to.beTruthy();
		});
	});
});

SPEC_END
