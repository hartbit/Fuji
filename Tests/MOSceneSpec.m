//
//  MOSceneSpec.m
//  Mocha2D
//
//  Created by Hart David on 24.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#define SPT_CEDAR_SYNTAX
#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"
#import "Mocha2D.h"


SPEC_BEGIN(MOSceneSpec)

describe(@"A scene", ^{
	__block MOScene* scene = nil;
	
	beforeEach(^{
		scene = [MOScene new];
	});
	
	it(@"is not nil", ^{
		expect(scene).toNot.beNil();
	});
	
	it(@"has an initial background color of Cornflower Blue", ^{
		expect(GLKVector4AllEqualToVector4([scene backgroundColor], MOColorCornflowerBlue)).to.beTruthy();
	});
	
	context(@"set the background color to gray", ^{
		beforeEach(^{
			[scene setBackgroundColor:MOColorGray];
		});
		
		it(@"has a background color of gray", ^{
			expect(GLKVector4AllEqualToVector4([scene backgroundColor], MOColorGray)).to.beTruthy();
		});
	});
	
	context(@"created a game object", ^{
		__block MOGameObject* gameObject = nil;
		
		beforeEach(^{
			gameObject = [scene createGameObject];
		});
		
		it(@"returns a valid game object with the scene property set", ^{
			expect(gameObject).toNot.beNil();
			expect(gameObject).to.beAnInstanceOf([MOGameObject class]);
			expect([gameObject scene]).to.beIdenticalTo((__bridge void*)scene);
		});
	});
});

SPEC_END
