//
//  FUGraphicsEngineSpec.m
//  Fuji
//
//  Created by Hart David on 24.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#include "Prefix.pch"
#import "FujiGraphics.h"


SPEC_BEGIN(FUGraphicsEngineSpec)

describe(@"The graphics engine", ^{
//	__block FUScene* scene = [FUScene new];
	__block FUGraphicsEngine* graphics = nil;
	
	beforeEach(^{
		graphics = [FUGraphicsEngine new];
	});
	
	it(@"is not nil", ^{
		expect(graphics).toNot.beNil();
	});
});

SPEC_END
