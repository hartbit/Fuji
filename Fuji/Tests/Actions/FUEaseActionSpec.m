//
//  FUEaseActionSpec.m
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
#import "FUTestSupport.h"


static NSString* const FUActionNilMessage = @"Expected 'action' to not be nil";


SPEC_BEGIN(FUEaseAction)

describe(@"An ease action", ^{
	it(@"is a finite action", ^{
		expect([FUEaseAction class]).to.beSubclassOf([FUFiniteAction class]);
	});
});

SPEC_END