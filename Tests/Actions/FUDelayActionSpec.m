//
//  FUDelayActionSpec.m
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


SPEC_BEGIN(FUDelayAction)

describe(@"A dekay action", ^{
	it(@"is a finite action", ^{
		expect([FUDelayAction class]).to.beSubclassOf([FUFiniteAction class]);
	});
	
	context(@"initialized with a delay", ^{
		__block FUDelayAction* action;
		
		beforeEach(^{
			action = [FUDelayAction actionWithDelay:2.5];
		});
		
		it(@"is not nil", ^{
			expect(action).toNot.beNil();
		});
		
		it(@"has a duration of 2.5", ^{
			expect([action duration]).to.equal(2.5);
		});
		
		context(@"creating a copy", ^{
			it(@"has a duration of 2.5", ^{
				FUDelayAction* copy = [action copy];
				expect([copy duration]).to.equal(2.5);
			});
		});
	});
});

SPEC_END