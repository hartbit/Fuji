//
//  FUEngineSpec.m
//  Fuji
//
//  Created by Hart David on 22.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#include "Prefix.pch"
#import "Fuji.h"


SPEC_BEGIN(FUEngineSpec)

describe(@"An engine", ^{
	it(@"conforms to FUInterfaceOrientation", ^{
		expect([[FUEngine class] conformsToProtocol:@protocol(FUInterfaceRotation)]).to.beTruthy();
	});
	
	context(@"created and initialized", ^{
		__block FUEngine* engine = nil;
		
		beforeEach(^{
			engine = [FUEngine new];
		});
		
		it(@"has no director", ^{
			expect([engine director]).to.beNil();
		});
	});
});

SPEC_END