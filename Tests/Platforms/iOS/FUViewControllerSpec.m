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
		
		it(@"has it's view at the same size as the screen", ^{
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
		
		it(@"has a nil scene", ^{
			expect([viewController scene]).to.beNil();
		});
		
		context(@"a scene is set", ^{
			__block FUScene* scene = nil;
			
			beforeEach(^{
				scene = mock([FUScene class]);
				[viewController setScene:scene];
			});
			
			it(@"has the scene property set", ^{
				expect([viewController scene]).to.beIdenticalTo(scene);
			});
			
			it(@"calls the scene's glkViewControllerUpdate: method", ^{
				[verify(scene) glkViewControllerUpdate:viewController];
			});
			
			it(@"calls the scene's glkView:drawInRect: method", ^{
				[verify(scene) glkView:(GLKView*)[viewController view] drawInRect:[[viewController view] bounds]];
			});
		});
	});
});

SPEC_END
