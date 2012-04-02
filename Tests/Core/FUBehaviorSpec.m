//
//  FUBehaviorSpec.m
//  Fuji
//
//  Created by David Hart on 01.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#include "Prefix.pch"
#import "Fuji.h"
#import "FUComponent-Internal.h"


SPEC_BEGIN(FUBehaviorSpec)

describe(@"A behavior object", ^{
	it(@"is a subclass of FUComponent", ^{
		expect([FUBehavior class]).to.beSubclassOf([FUComponent class]);
	});
	
	context(@"created and initialized", ^{
		__block FUBehavior* behavior = nil;
		
		beforeEach(^{
			behavior = [[FUBehavior alloc] initWithEntity:mock([FUEntity class])];
		});
		
		it(@"is not nil", ^{
			expect(behavior).toNot.beNil();
		});
		
		it(@"is enabled by default", ^{
			expect([behavior isEnabled]).to.beTruthy();
		});
		
		context(@"disabling it", ^{
			it(@"sets it's enabled property to NO", ^{
				[behavior setEnabled:NO];
				expect([behavior isEnabled]).to.beFalsy();
			});
		});
	});
});

SPEC_END