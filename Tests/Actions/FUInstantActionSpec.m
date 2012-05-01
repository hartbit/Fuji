//
//  FUInstantActionSpec.m
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


SPEC_BEGIN(FUInstantAction)

describe(@"An instant action", ^{
	it(@"is a finite action", ^{
		expect([FUInstantAction class]).to.beSubclassOf([FUFiniteAction class]);
	});
	
	context(@"initialized", ^{
		__block FUInstantAction* instantAction;
		
		beforeEach(^{
			instantAction = [FUInstantAction new];
		});
		
		it(@"is not nil", ^{
			expect(instantAction).toNot.beNil();
		});
		
		it(@"has a duration of 0", ^{
			expect([instantAction duration]).to.equal(0);
		});
		
		it(@"the reverse is itself", ^{
			expect([instantAction reverse]).to.beIdenticalTo(instantAction);
		});
	});
});

SPEC_END
