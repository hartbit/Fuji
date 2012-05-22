//
//  FUSequenceActionSpec.m
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


SPEC_BEGIN(FUSequenceAction)

describe(@"A sequence action", ^{
	it(@"is a finite action", ^{
		expect([FUSequenceAction class]).to.beSubclassOf([FUFiniteAction class]);
	});
	
	context(@"initilized with a nil array", ^{
		it(@"throws an exception", ^{
			assertThrows([[FUSequenceAction alloc] initWithActions:nil], NSInvalidArgumentException, FUArrayNilMessage);
		});
	});
	
	context(@"initilized with an empty array", ^{
		it(@"does not throw", ^{
			assertNoThrow([[FUSequenceAction alloc] initWithActions:[NSArray array]]);
		});
	});
	
	context(@"initializing with an array containing an object that is not a FUFiniteAction", ^{
		it(@"throws an exception", ^{
			id object = [NSString string];
			NSArray* array = [NSArray arrayWithObject:object];
			assertThrows([[FUSequenceAction alloc] initWithActions:array], NSInvalidArgumentException, FUFiniteActionSubclassMessage, object);
		});
	});
	
	context(@"initializing via the function with no actions", ^{
		it(@"returns a FUSequenceAction", ^{
			expect(FUSequence()).to.beKindOf([FUSequenceAction class]);
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
			[given([action3 duration]) willReturnDouble:0.5];
			
			actions = [NSMutableArray arrayWithObjects:action1, action2, action3, nil];
			sequence = [[FUSequenceAction alloc] initWithActions:actions];
		});
		
		context(@"initializing via the function with three actions", ^{
			it(@"returns a FUSequenceAction", ^{
				expect(FUSequence(action1, action2, action3)).to.beKindOf([FUSequenceAction class]);
			});
		});
		
		it(@"is not nil", ^{
			expect(sequence).toNot.beNil();
		});
		
		it(@"is not complete", ^{
			expect([sequence isComplete]).to.beFalsy();
		});
		
		it(@"has it's duration as the sum of the action's durations", ^{
			expect([sequence duration]).to.equal(4.0f);
		});
		
		context(@"updating the sequence with 1.2 seconds", ^{
			beforeEach(^{
				[sequence updateWithDeltaTime:1.2];
			});
			
			it(@"is not complete", ^{
				expect([sequence isComplete]).to.beFalsy();
			});
			
			it(@"updates only the first action", ^{
				[[verify(action1) withMatcher:HC_closeTo(0.8f, FLT_EPSILON)] updateWithFactor:0.8f];
				[[verifyCount(action2, never()) withMatcher:HC_anything()] updateWithFactor:0.0f];
				[[verifyCount(action3, never()) withMatcher:HC_anything()] updateWithFactor:0.0f];
			});
			
			context(@"updating the sequence with 0.8 seconds", ^{
				beforeEach(^{
					[sequence updateWithDeltaTime:0.8];
				});
				
				it(@"is not complete", ^{
					expect([sequence isComplete]).to.beFalsy();
				});
				
				it(@"updates the first and second action", ^{
					[verify(action1) updateWithFactor:1.0f];
					[[verify(action2) withMatcher:HC_closeTo(0.25f, FLT_EPSILON)] updateWithFactor:0.25f];
					[[verifyCount(action3, never()) withMatcher:HC_anything()] updateWithFactor:0.0f];
				});
				
				context(@"updating the sequence with 3.0 seconds", ^{
					beforeEach(^{
						[sequence updateWithDeltaTime:3.0];
					});
					
					it(@"is complete", ^{
						expect([sequence isComplete]).to.beTruthy();
					});
					
					it(@"updates the second and third actions", ^{
						[[verifyCount(action1, times(2)) withMatcher:HC_anything()] updateWithFactor:0.0f];
						[verify(action2) updateWithFactor:1.0f];
						[verify(action3) updateWithFactor:1.0f];
					});
				});
				
				context(@"updating a copy of the sequence with 3.0 seconds", ^{
					__block FUSequenceAction* sequenceCopy;
					__block FUFiniteAction* action1Copy;
					__block FUFiniteAction* action2Copy;
					__block FUFiniteAction* action3Copy;
					
					beforeEach(^{
						action1Copy = mock([FUFiniteAction class]);
						[given([action1 copy]) willReturn:action1Copy];
						[given([action1Copy duration]) willReturnDouble:1.5];
						
						action2Copy = mock([FUFiniteAction class]);
						[given([action2 copy]) willReturn:action2Copy];
						[given([action2Copy duration]) willReturnDouble:2.0];
						
						action3Copy = mock([FUFiniteAction class]);
						[given([action3 copy]) willReturn:action3Copy];
						[given([action3Copy duration]) willReturnDouble:0.5];
						
						sequenceCopy = [sequence copy];
						[sequenceCopy updateWithDeltaTime:3.0];
					});

					it(@"is not nil", ^{
						expect(sequenceCopy).toNot.beNil();
					});
					
					it(@"is not the same instance", ^{
						expect(sequenceCopy).toNot.beIdenticalTo(sequence);
					});
					
					it(@"has the same duration", ^{
						expect([sequenceCopy duration]).to.equal([sequence duration]);
					});
					
					it(@"has the original not complete", ^{
						expect([sequence isComplete]).to.beFalsy();
					});
					
					it(@"has the copy complete", ^{
						expect([sequenceCopy isComplete]).to.beTruthy();
					});
					
					it(@"does not update the original actions", ^{
						[[verifyCount(action1, times(2)) withMatcher:HC_anything()] updateWithFactor:0.0f];
						[[verifyCount(action2, times(1)) withMatcher:HC_anything()] updateWithFactor:0.0f];
						[[verifyCount(action3, never()) withMatcher:HC_anything()] updateWithFactor:0.0f];
					});
					
					it(@"updates the second and third copied actions", ^{
						[[verifyCount(action1Copy, never()) withMatcher:HC_anything()] updateWithFactor:0.0f];
						[verify(action2Copy) updateWithFactor:1.0f];
						[verify(action3Copy) updateWithFactor:1.0f];
					});
				});
				
				context(@"updating the sequence with -5.0 seconds", ^{
					beforeEach(^{
						[sequence updateWithDeltaTime:-5.0];
					});
					
					it(@"is complete", ^{
						expect([sequence isComplete]).to.beTruthy();
					});
					
					it(@"updates the first and second action backwards", ^{
						[[verifyCount(action3, never()) withMatcher:HC_anything()] updateWithFactor:0.0f];
						[verify(action2) updateWithFactor:0.0f];
						[verify(action1) updateWithFactor:0.0f];
					});
				});
				
				context(@"updating the sequence with a factor of -0.075f", ^{
					beforeEach(^{
						[sequence updateWithFactor:-0.075f];
					});
					
					it(@"is not complete", ^{
						expect([sequence isComplete]).to.beFalsy();
					});
					
					it(@"updates the first and second action backwards", ^{
						[[verifyCount(action3, never()) withMatcher:HC_anything()] updateWithFactor:0.0f];
						[verify(action2) updateWithFactor:0.0f];
						[verify(action1) updateWithFactor:-0.2f];
					});
				});
				
				context(@"updating the sequence with a factor of 1.125f", ^{
					beforeEach(^{
						[sequence updateWithFactor:1.125f];
					});
					
					it(@"is not complete", ^{
						expect([sequence isComplete]).to.beFalsy();
					});
					
					it(@"updates the second and third action forwards", ^{
						[[verifyCount(action1, times(2)) withMatcher:HC_anything()] updateWithFactor:0.0f];
						[verify(action2) updateWithFactor:1.0f];
						[[verify(action3) withMatcher:HC_closeTo(2.0f, FLT_EPSILON)] updateWithFactor:2.0f];
					});
				});
			});
		});
	});
	
	pending(@"test that adding actions to an NSMutableArray does not add extra actions to the sequence");
});

SPEC_END