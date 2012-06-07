//
//  FUUpdateEngineSpec.m
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#include "Prefix.pch"
#import "Fuji.h"


SPEC_BEGIN(FUUpdateEngine)

describe(@"An update engine", ^{
	it(@"is an engine", ^{
		expect([FUUpdateEngine class]).to.beSubclassOf([FUEngine class]);
	});
});

SPEC_END
