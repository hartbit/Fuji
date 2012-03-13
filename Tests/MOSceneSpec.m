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

describe(@"MOScene", ^{
	__block MOScene* scene = nil;
	
	beforeEach(^{
		scene = [MOScene new];
	});
	
	it(@"should return a valid scene", ^{
		expect(scene).toNot.beNil();
	});
	
	context(@"backgroundColor", ^{
		it(@"should have an initial value of black", ^{
			expect(GLKVector4AllEqualToVector4([scene backgroundColor], MOColorCornflowerBlue)).to.beTruthy();
		});
		
		it(@"should be editable", ^{
			[scene setBackgroundColor:MOColorGray];
			expect(GLKVector4AllEqualToVector4([scene backgroundColor], MOColorGray)).to.beTruthy();
		});
	});
	
	context(@"addGameObject", ^{
		it(@"should return a valid game object", ^{
			MOGameObject* gameObject = [scene addGameObject];
			expect(gameObject).toNot.beNil();
			expect(gameObject).to.beAnInstanceOf([MOGameObject class]);
		});
	});
});

SPEC_END
