//
//  FUGraphicsEngineSpec.m
//  Fuji
//
//  Created by Hart David on 24.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#include "Prefix.pch"
#import	"FujiCore.h"
#import "FujiGraphics.h"
#import	"FUComponent-Internal.h"


SPEC_BEGIN(FUGraphicsEngineSpec)

describe(@"The graphics engine", ^{
	it(@"is a subclass of FUBehavior", ^{
		expect([FUGraphicsEngine class]).to.beASubclassOf([FUBehavior class]);
	});
	
	context(@"created and initialized", ^{
		__block FUGraphicsEngine* graphics = nil;
		
		beforeEach(^{
			graphics = [[FUGraphicsEngine alloc] initWithGameObject:mock([FUGameObject class])];
		});
		
		it(@"is not nil", ^{
			expect(graphics).toNot.beNil();
		});
	});
});

SPEC_END
