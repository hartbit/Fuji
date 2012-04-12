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


@interface FUBehaviorEngine : FUEngine

- (void)registerFUBehavior:(FUBehavior*)behavior;
- (void)unregisterFUBehavior:(FUBehavior*)behavior;

@end


@implementation FUBehaviorEngine

- (void)registerFUBehavior:(FUBehavior*)behavior { }
- (void)unregisterFUBehavior:(FUBehavior*)behavior { }

@end


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
		
		context(@"created a mock engine", ^{
			__block FUEngine* engine = nil;
			
			beforeEach(^{
				engine = mock([FUBehaviorEngine class]);
			});
			
			context(@"set it to disabled", ^{
				beforeEach(^{
					[behavior setEnabled:NO];
				});
				
				it(@"sets it's enabled property to NO", ^{
					expect([behavior isEnabled]).to.beFalsy();
				});
				
#warning Make the enable property call the register/unregister methods
			});
		});
	});
});

SPEC_END