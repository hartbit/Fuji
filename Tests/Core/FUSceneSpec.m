//
//  FUSceneSpec.m
//  Fuji
//
//  Created by Hart David on 24.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#include "Prefix.pch"
#import "FujiCore.h"


SPEC_BEGIN(FUSceneSpec)

describe(@"A scene", ^{
	__block FUScene* scene = nil;
	
	beforeEach(^{
		scene = [FUScene new];
	});
	
	it(@"is not nil", ^{
		expect(scene).toNot.beNil();
	});
	/*
	it(@"has an initial background color of Cornflower Blue", ^{
		expect(GLKVector4AllEqualToVector4([scene backgroundColor], FUColorCornflowerBlue)).to.beTruthy();
	});
	
	context(@"set the background color to gray", ^{
		beforeEach(^{
			[scene setBackgroundColor:FUColorGray];
		});
		
		it(@"has a background color of gray", ^{
			expect(GLKVector4AllEqualToVector4([scene backgroundColor], FUColorGray)).to.beTruthy();
		});
	});
	*/
	context(@"created a game object", ^{
		__block FUGameObject* gameObject = nil;
		
		beforeEach(^{
			gameObject = [scene createGameObject];
		});
		
		it(@"returns a valid game object with the scene property set", ^{
			expect(gameObject).toNot.beNil();
			expect(gameObject).to.beAnInstanceOf([FUGameObject class]);
			expect([gameObject scene]).to.beIdenticalTo((__bridge void*)scene);
		});
	});
});

SPEC_END
