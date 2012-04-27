//
//  FUEngineSpec.m
//  Fuji
//
//  Created by David Hart
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#include "Prefix.pch"
#import "Fuji.h"
#import "FUEngine-Internal.h"
#import "FUSceneObject-Internal.h"


SPEC_BEGIN(FUEngine)

describe(@"An engine", ^{
	it(@"can react to interface rotations", ^{
		expect([[FUEngine class] conformsToProtocol:@protocol(FUInterfaceRotating)]).to.beTruthy();
	});
	
	context(@"initialized", ^{
		__block FUEngine* engine = nil;
		
		beforeEach(^{
			engine = [FUEngine new];
		});
		
		it(@"has no director", ^{
			expect([engine director]).to.beNil();
		});
		
		it(@"has no registration visitor", ^{
			expect([engine registrationVisitor]).to.beNil();
		});
		
		it(@"has no unregistration visitor", ^{
			expect([engine unregistrationVisitor]).to.beNil();
		});
	});
});

SPEC_END
