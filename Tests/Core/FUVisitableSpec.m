//
//  FUVisitableSpec.m
//  Fuji
//
//  Created by Hart David on 24.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#include "Prefix.pch"
#import "Fuji.h"


SPEC_BEGIN(FUVisitable)

describe(@"A visitable object", ^{
	__block FUVisitable* visitable = nil;
	
	beforeEach(^{
		visitable = [FUVisitable new];
	});
});

SPEC_END