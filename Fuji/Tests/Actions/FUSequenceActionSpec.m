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
#import "FUTestAction.h"


static NSString* const FUArrayNilMessage = @"Expected array to not be nil";
static NSString* const FUActionProtocolMessage = @"Expected 'action=%@' to conform to the FUAction protocol";


SPEC_BEGIN(FUSequenceAction)

describe(@"A sequence action", ^{
	it(@"is an action", ^{
		expect([[FUSequenceAction class] conformsToProtocol:@protocol(FUAction)]).to.beTruthy();
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
	
	context(@"initializing with an array containing an object that is not an FUAction", ^{
		it(@"throws an exception", ^{
			id object = [NSString string];
			NSArray* array = [NSArray arrayWithObject:object];
			assertThrows([[FUSequenceAction alloc] initWithActions:array], NSInvalidArgumentException, FUActionProtocolMessage, object);
		});
	});
	
	context(@"initializing via the function with no actions", ^{
		it(@"returns a FUSequenceAction", ^{
			expect(FUSequence()).to.beKindOf([FUSequenceAction class]);
		});
	});
	
	context(@"initilizing with three actions", ^{
		__block NSObject<FUAction>* action1;
		__block NSObject<FUAction>* action2;
		__block NSObject<FUAction>* action3;
		__block NSMutableArray* actions;
		__block FUSequenceAction* sequence;
		
		beforeEach(^{
			action1 = mockObjectAndProtocol([NSObject class], @protocol(FUAction));
			action2 = mockObjectAndProtocol([NSObject class], @protocol(FUAction));
			action3 = mockObjectAndProtocol([NSObject class], @protocol(FUAction));
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
		
		context(@"updating the sequence with 0.0 seconds", ^{
			it(@"updates no action", ^{
				[sequence updateWithDeltaTime:0.0];
				[[verifyCount(action1, never()) withMatcher:HC_anything()] updateWithDeltaTime:0.0];
				[[verifyCount(action2, never()) withMatcher:HC_anything()] updateWithDeltaTime:0.0];
				[[verifyCount(action3, never()) withMatcher:HC_anything()] updateWithDeltaTime:0.0];
			});
		});
		
		context(@"updated the sequence", ^{
			__block NSTimeInterval timeLeft1;
			
			beforeEach(^{
				timeLeft1 = [sequence updateWithDeltaTime:1.0];
			});
			
			it(@"returned no time left", ^{
				expect(timeLeft1).to.equal(0.0);
			});
			
			it(@"updates only the first action", ^{
				[verify(action1) updateWithDeltaTime:1.0];
				[[verifyCount(action2, never()) withMatcher:HC_anything()] updateWithDeltaTime:0.0];
				[[verifyCount(action3, never()) withMatcher:HC_anything()] updateWithDeltaTime:0.0];
			});

			context(@"updated the sequence and had the first and second action return time left", ^{
				__block NSTimeInterval timeLeft2;
				
				beforeEach(^{
					[given([action1 updateWithDeltaTime:2.0]) willReturnDouble:1.5];
					[given([action2 updateWithDeltaTime:1.5]) willReturnDouble:0.5];
					timeLeft2 = [sequence updateWithDeltaTime:2.0];
				});
				
				it(@"returned 0.0 seconds left", ^{
					expect(timeLeft2).to.equal(0.0);
				});
				
				it(@"updates the first and second action", ^{
					[verify(action1) updateWithDeltaTime:2.0];
					[verify(action2) updateWithDeltaTime:1.5];
					[verify(action3) updateWithDeltaTime:0.5];
				});
				
				context(@"updated the sequence and had the last action return time left", ^{
					__block NSTimeInterval timeLeft3;
					
					beforeEach(^{
						[given([action3 updateWithDeltaTime:1.0]) willReturnDouble:0.7];
						timeLeft3 = [sequence updateWithDeltaTime:1.0];
					});
					
					it(@"returned 0.7 seconds left", ^{
						expect(timeLeft3).to.equal(0.7);
					});
					
					it(@"updates the last action", ^{
						[[verifyCount(action1, times(2)) withMatcher:HC_anything()] updateWithDeltaTime:0.0];
						[[verifyCount(action2, times(1)) withMatcher:HC_anything()] updateWithDeltaTime:0.0];
						[verify(action3) updateWithDeltaTime:1.0];
					});
				});
				
				context(@"updated the sequence with -5.0 seconds and have all actions return time left", ^{
					__block NSTimeInterval timeLeft4;
					
					beforeEach(^{
						[given([action3 updateWithDeltaTime:-5.0]) willReturnDouble:-4.5];
						[given([action2 updateWithDeltaTime:-4.5]) willReturnDouble:-3.5];
						[given([action1 updateWithDeltaTime:-3.5]) willReturnDouble:-2.0];
						timeLeft4 = [sequence updateWithDeltaTime:-5.0];
					});
					
					it(@"returned -2.0 seconds left", ^{
						expect(timeLeft4).to.equal(-2.0);
					});
					
					it(@"updates all actions backwards", ^{
						[verify(action3) updateWithDeltaTime:-5.0];
						[verify(action2) updateWithDeltaTime:-4.5];
						[verify(action1) updateWithDeltaTime:-3.5];
					});
				});
				
				context(@"updated a copy of the sequence with 3.0 seconds", ^{
					__block FUSequenceAction* sequenceCopy;
					__block id<FUAction> action1Copy;
					__block id<FUAction> action2Copy;
					__block id<FUAction> action3Copy;
					
					beforeEach(^{
						action1Copy = mockProtocol(@protocol(FUAction));
						[given([action1 copy]) willReturn:action1Copy];
						
						action2Copy = mockProtocol(@protocol(FUAction));
						[given([action2 copy]) willReturn:action2Copy];
						
						action3Copy = mockProtocol(@protocol(FUAction));
						[given([action3 copy]) willReturn:action3Copy];
						
						sequenceCopy = [sequence copy];
						[sequenceCopy updateWithDeltaTime:3.0];
					});
					
					it(@"is not nil", ^{
						expect(sequenceCopy).toNot.beNil();
					});
					
					it(@"is not the same instance", ^{
						expect(sequenceCopy).toNot.beIdenticalTo(sequence);
					});
					
					it(@"does not update the original actions", ^{
						[[verifyCount(action1, times(2)) withMatcher:HC_anything()] updateWithDeltaTime:0.0];
						[[verifyCount(action2, times(1)) withMatcher:HC_anything()] updateWithDeltaTime:0.0];
						[[verifyCount(action3, times(1)) withMatcher:HC_anything()] updateWithDeltaTime:0.0];
					});
					
					it(@"updates the last copied actions", ^{
						[[verifyCount(action1Copy, never()) withMatcher:HC_anything()] updateWithDeltaTime:0.0];
						[[verifyCount(action2Copy, never()) withMatcher:HC_anything()] updateWithDeltaTime:0.0];
						[verify(action3Copy) updateWithDeltaTime:3.0];
					});
				});
			});
		});
		
		context(@"updating the sequence with an action added to the actions array", ^{
			it(@"does not update the extra action", ^{
				id<FUAction> extraAction = mockProtocol(@protocol(FUAction));
				[actions addObject:extraAction];
				
				[given([action1 updateWithDeltaTime:10.0]) willReturnDouble:10.0];
				[given([action2 updateWithDeltaTime:10.0]) willReturnDouble:10.0];
				[given([action3 updateWithDeltaTime:10.0]) willReturnDouble:10.0];
				[sequence updateWithDeltaTime:10.0];

				[[verifyCount(extraAction, never()) withMatcher:HC_anything()] updateWithDeltaTime:0.0];
			});
		});
	});
});

SPEC_END