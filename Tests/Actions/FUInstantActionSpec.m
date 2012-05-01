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
});

SPEC_END
