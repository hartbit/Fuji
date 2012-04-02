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
#import "FUTestVisitors.h"


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
		
		context(@"created a valid visitor", ^{
			__block FUBehaviorVisitor* visitor = nil;
			
			beforeEach(^{
				visitor = mock([FUBehaviorVisitor class]);
			});
			
			context(@"updating it with the visitor", ^{
				it(@"calls the visitor update method", ^{
					[behavior updateVisitor:visitor];
					[verify(visitor) updateFUBehavior:behavior];
				});
			});
			
			context(@"drawing it with the visitor", ^{
				it(@"calls the visitor draw method", ^{
					[behavior drawVisitor:visitor];
					[verify(visitor) drawFUBehavior:behavior];
				});
			});
			
			context(@"set it to disabled", ^{
				beforeEach(^{
					[behavior setEnabled:NO];
				});
				
				it(@"sets it's enabled property to NO", ^{
					expect([behavior isEnabled]).to.beFalsy();
				});
				
				context(@"updating it with the visitor", ^{
					it(@"does not call the visitor update method", ^{
						[behavior updateVisitor:visitor];
						[verifyCount(visitor, times(0)) updateFUBehavior:behavior];
					});
				});
				
				context(@"drawing it with the visitor", ^{
					it(@"does not call the visitor draw method", ^{
						[behavior drawVisitor:visitor];
						[verifyCount(visitor, times(0)) drawFUBehavior:behavior];
					});
				});
			});
		});
	});
});

SPEC_END