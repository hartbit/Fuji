//
//  FUFiniteActionSpec.m
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


SPEC_BEGIN(FUFiniteAction)

describe(@"A finite action", ^{
	it(@"is an action", ^{
		expect([[FUFiniteAction class] conformsToProtocol:@protocol(FUAction)]).to.beTruthy();
	});
	
	context(@"initialized", ^{
		__block FUFiniteAction* finiteAction;
		
		beforeEach(^{
			finiteAction = [FUFiniteAction new];
		});
		
		it(@"is not nil", ^{
			expect(finiteAction).toNot.beNil();
		});
		
		it(@"has a duration of 0", ^{
			expect([finiteAction duration]).to.equal(0);
		});
		
		it(@"the reverse is itself", ^{
			expect([finiteAction reverse]).to.beIdenticalTo(finiteAction);
		});
	});
});

SPEC_END
