//
//  FUDirectorSpec.m
//  Fuji
//
//  Created by Hart David on 22.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#include "Prefix.pch"
#import "Fuji.h"


SPEC_BEGIN(FUDirectorSpec)

describe(@"A director", ^{
	it(@"is a subclass of GLKViewController", ^{
		expect([FUDirector class]).to.beASubclassOf([GLKViewController class]);
	});
	
	context(@"created and initialized", ^{
		__block FUDirector* director = nil;
		
		beforeEach(^{
			director = [FUDirector new];
		});
		
		it(@"has a valid opengl view", ^{
			expect([director view]).to.beKindOf([GLKView class]);
		});
		
		it(@"has it's view at the same size as the screen", ^{
			CGSize viewSize = [[director view] bounds].size;
			CGSize screenSize = [[UIScreen mainScreen] bounds].size;
			expect(CGSizeEqualToSize(viewSize, screenSize)).to.beTruthy();
		});
		
		it(@"automatically rotates in all orientations", ^{
			expect([director shouldAutorotateToInterfaceOrientation:UIInterfaceOrientationPortrait]).to.beTruthy();
			expect([director shouldAutorotateToInterfaceOrientation:UIInterfaceOrientationPortraitUpsideDown]).to.beTruthy();
			expect([director shouldAutorotateToInterfaceOrientation:UIInterfaceOrientationLandscapeLeft]).to.beTruthy();
			expect([director shouldAutorotateToInterfaceOrientation:UIInterfaceOrientationLandscapeRight]).to.beTruthy();
		});
		
		it(@"has a nil scene", ^{
			expect([director scene]).to.beNil();
		});
		
		context(@"a scene is set", ^{
			__block FUScene* scene = nil;
			
			beforeEach(^{
				scene = mock([FUScene class]);
				[director setScene:scene];
			});
			
			it(@"has the scene property set", ^{
				expect([director scene]).to.beIdenticalTo(scene);
			});
			
			it(@"sets the scene as the GLKViewController delegate", ^{
				expect([director delegate]).to.beIdenticalTo(scene);
			});
				
			it(@"sets the scene as the GLKView delegate", ^{
				expect([(GLKView*)[director view] delegate]).to.beIdenticalTo(scene);
			});
		});
	});
});

SPEC_END
