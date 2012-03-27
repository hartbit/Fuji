//
//  FUVisitableSpec.m
//  Fuji
//
//  Created by Hart David on 24.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#include "Prefix.pch"
#import "Fuji.h"
#import "FUTestVisitors.h"


SPEC_BEGIN(FUVisitable)

describe(@"A visitable object", ^{
	__block FUVisitable* visitable = nil;
	
	beforeEach(^{
		visitable = [FUVisitable new];
	});
	
	context(@"visiting with a visitor that does not handle that visitable", ^{
		it(@"does nothing", ^{
			NSString* visitor = mock([NSString class]);
			[visitable acceptVisitor:visitor];
		});
	});
	
	context(@"visiting with a visitor that handles that visitable", ^{
		it(@"calls the visit method", ^{
			FUTestVisitor* visitor = mock([FUTestVisitor class]);
			[visitable acceptVisitor:visitor];
			[verify(visitor) visitFUVisitable:visitable];
		});
	});
});

SPEC_END