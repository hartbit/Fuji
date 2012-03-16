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
	
	it(@"is a subclass of FUGameObject", ^{
		expect([FUScene class]).to.beSubclassOf([FUGameObject class]);
	});
	
	context(@"created a scene", ^{
		beforeEach(^{
			scene = [FUScene scene];
		});
		
		it(@"is not nil", ^{
			expect(scene).toNot.beNil();
		});
		
		it(@"has it's scene property point to itself", ^{
			expect([scene scene]).to.beIdenticalTo(scene);
		});
		
		context(@"created a game object", ^{
			__block FUGameObject* gameObject = nil;
			
			beforeEach(^{
				gameObject = [scene createGameObject];
			});
			
			it(@"returns a valid game object with the scene property set", ^{
				expect(gameObject).toNot.beNil();
				expect(gameObject).to.beAnInstanceOf([FUGameObject class]);
				expect([gameObject scene]).to.beIdenticalTo(scene);
			});
		});
	});
});

SPEC_END
