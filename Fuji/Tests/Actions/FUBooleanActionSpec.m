//
//  FUBooleanActionSpec.m
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


static NSString* const FUObjectNilMessage = @"Expect 'object' to not be nil";


SPEC_BEGIN(FUBooleanAction)

describe(@"A boolean action", ^{
	it(@"is a finite action", ^{
		expect([FUBooleanAction class]).to.beSubclassOf([FUFiniteAction class]);
	});
	
	context(@"initializing with a nil object", ^{
		it(@"throws an exception", ^{
			assertThrows([[FUBooleanAction alloc] initWithObject:nil property:@"property" value:NO], NSInvalidArgumentException, FUObjectNilMessage);
		});
	});
});

SPEC_END