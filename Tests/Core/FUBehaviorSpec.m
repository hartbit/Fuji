//
//  FUBehaviorSpec.m
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
#import "FUComponent-Internal.h"


@interface FUBehaviorEngine : FUEngine
- (void)registerFUBehavior:(FUBehavior*)behavior;
- (void)unregisterFUBehavior:(FUBehavior*)behavior;
@end


SPEC_BEGIN(FUBehavior)

describe(@"A behavior object", ^{
	it(@"is a subclass of FUComponent", ^{
		expect([FUBehavior class]).to.beSubclassOf([FUComponent class]);
	});
	
	context(@"initialized", ^{
		__block FUScene* scene = nil;
		__block FUBehavior* behavior = nil;
		
		beforeEach(^{
			scene = mock([FUScene class]);
			FUEntity* entity = mock([FUEntity class]);
			[given([entity scene]) willReturn:scene];
			behavior = [[FUBehavior alloc] initWithEntity:entity];
		});
		
		it(@"is not nil", ^{
			expect(behavior).toNot.beNil();
		});
		
		it(@"is enabled by default", ^{
			expect([behavior isEnabled]).to.beTruthy();
		});
		
		context(@"setting it to disabled", ^{
			it(@"sets it's enabled property to NO", ^{
				[behavior setEnabled:NO];
				expect([behavior isEnabled]).to.beFalsy();
			});
		});
	});
});

SPEC_END


@implementation FUBehaviorEngine
- (void)registerFUBehavior:(FUBehavior*)behavior { }
- (void)unregisterFUBehavior:(FUBehavior*)behavior { }
@end