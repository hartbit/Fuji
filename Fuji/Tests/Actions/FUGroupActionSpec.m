//
//  FUGroupActionSpec.m
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
#import "FUTestSupport.h"


static NSString* const FUArrayNilMessage = @"Expected array to not be nil";
static NSString* const FUFiniteActionSubclassMessage = @"Expected 'action=%@' to be a subclass of FUFiniteAction";


SPEC_BEGIN(FUGroupAction)

describe(@"A group action", ^{
	it(@"is a finite action", ^{
		expect([FUGroupAction class]).to.beSubclassOf([FUFiniteAction class]);
	});
	
	context(@"initilized with a nil array", ^{
		it(@"throws an exception", ^{
			assertThrows([[FUGroupAction alloc] initWithActions:nil], NSInvalidArgumentException, FUArrayNilMessage);
		});
	});
	
	context(@"initilized with an empty array", ^{
		it(@"does not throw", ^{
			assertNoThrow([[FUGroupAction alloc] initWithActions:[NSArray array]]);
		});
	});
	
	context(@"initializing with an array containing an object that is not a FUFiniteAction", ^{
		it(@"throws an exception", ^{
			id object = [NSString string];
			NSArray* array = [NSArray arrayWithObject:object];
			assertThrows([[FUGroupAction alloc] initWithActions:array], NSInvalidArgumentException, FUFiniteActionSubclassMessage, object);
		});
	});
	
	context(@"initializing via the function with no actions", ^{
		it(@"returns a FUSequenceAction", ^{
			expect(FUGroup()).to.beKindOf([FUGroupAction class]);
		});
	});
	
//	context(@"updating the sequence with an action added to the actions array", ^{
//		it(@"does not update the extra action", ^{
//			FUFiniteAction*	extraAction = mock([FUFiniteAction class]);
//			[given([extraAction isKindOfClass:[FUFiniteAction class]]) willReturnBool:YES];
//			[given([extraAction duration]) willReturnDouble:0.6];
//			[actions addObject:extraAction];
//			
//			[sequence updateWithDeltaTime:10.0f];
//			[[verifyCount(extraAction, never()) withMatcher:HC_anything()] updateWithFactor:0.0f];
//		});
//	});
});

SPEC_END