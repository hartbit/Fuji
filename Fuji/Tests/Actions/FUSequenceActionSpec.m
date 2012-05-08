//
//  FUSequenceActionSpec.m
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


static NSString* const FUArrayNilMessage = @"Expected array to not be nil";
static NSString* const FUFiniteActionSubclassMessage = @"Expected 'action=%@' to not be a subclass of FUFiniteAction";


SPEC_BEGIN(FUSequenceAction)

describe(@"A sequence action", ^{
	it(@"is a finite action", ^{
		expect([FUSequenceAction class]).to.beSubclassOf([FUFiniteAction class]);
	});
	
	context(@"initilized with a nil array", ^{
		it(@"throws an exception", ^{
			assertThrows([FUSequenceAction sequenceWithArray:nil], NSInvalidArgumentException, FUArrayNilMessage);
		});
	});
	
	context(@"initilized with an empty nil-terminated list", ^{
		it(@"does not throw", ^{
			assertNoThrow([FUSequenceAction sequenceWithActions:nil]);
		});
	});
	
	context(@"initializing with an array containing an object that is not a FUFiniteAction", ^{
		it(@"throws an exception", ^{
			id object = [NSString string];
			NSArray* array = [NSArray arrayWithObject:object];
			assertThrows([FUSequenceAction sequenceWithArray:array], NSInvalidArgumentException, FUFiniteActionSubclassMessage, object);
		});
	});
	
	context(@"initilizing with three actions", ^{
		__block FUFiniteAction* action1;
		__block FUFiniteAction* action2;
		__block FUFiniteAction* action3;
		__block NSMutableArray* actions;
		__block FUSequenceAction* sequence;
		
		beforeEach(^{
			action1 = mock([FUFiniteAction class]);
			[given([action1 isKindOfClass:[FUFiniteAction class]]) willReturnBool:YES];
			[given([action1 duration]) willReturnDouble:1.5];
			
			action2 = mock([FUFiniteAction class]);
			[given([action2 isKindOfClass:[FUFiniteAction class]]) willReturnBool:YES];
			[given([action2 duration]) willReturnDouble:2.0];
			
			action3 = mock([FUFiniteAction class]);
			[given([action3 isKindOfClass:[FUFiniteAction class]]) willReturnBool:YES];
			[given([action3 duration]) willReturnDouble:0.3];
			
			actions = [NSMutableArray arrayWithObjects:action1, action2, action3, nil];
			sequence = [FUSequenceAction sequenceWithArray:actions];
		});
		
		it(@"is not nil", ^{
			expect(sequence).toNot.beNil();
		});
		
		it(@"is not complete", ^{
			expect([sequence isComplete]).to.beFalsy();
		});
		
		it(@"has it's duration as the sum of the action's durations", ^{
			expect([sequence duration]).to.equal(3.8);
		});
		
		context(@"updating the sequence with 1 second", ^{
			it(@"updates only the first action", ^{
				[sequence updateWithDeltaTime:1];
				[verify(action1) updateWithDeltaTime:1];
				[verifyCount(action2, never()) updateWithDeltaTime:1];
				[verifyCount(action3, never()) updateWithDeltaTime:1];
			});
		});
		
		context(@"updating the sequence with 2 seconds", ^{
			it(@"updates the first and second action", ^{
				[sequence updateWithDeltaTime:2];
				[verify(action1) updateWithDeltaTime:2];
				[verify(action2) updateWithDeltaTime:0.5];
				[verifyCount(action3, never()) updateWithDeltaTime:2];
			});
		});
		
		context(@"updating the sequence with 3.6 seconds", ^{
			it(@"updates the first and second and third action", ^{
				[sequence updateWithDeltaTime:3.6];
				[verify(action1) updateWithDeltaTime:3.6];
				[verify(action2) updateWithDeltaTime:2.1];
				[verify(action3) updateWithDeltaTime:0.1];
			});
		});
	});
	
	pending(@"test that adding actions to an NSMutableArray does not add extra actions to the sequence");
});

SPEC_END