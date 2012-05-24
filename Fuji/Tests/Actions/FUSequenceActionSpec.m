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
		
		it(@"contains all three actions", ^{
			NSArray* actionsArray = [sequence actions];
			expect(actionsArray).to.haveCountOf(3);
			expect(actionsArray).to.contain(action1);
			expect(actionsArray).to.contain(action2);
			expect(actionsArray).to.contain(action3);
		});
		
		context(@"calling consumeDeltaTime: with 0.0 seconds", ^{
			it(@"does not call consumeDeltaTime: on the subactions", ^{
				[sequence consumeDeltaTime:0.0];
				[[verifyCount(action1, never()) withMatcher:HC_anything()] consumeDeltaTime:0.0];
				[[verifyCount(action2, never()) withMatcher:HC_anything()] consumeDeltaTime:0.0];
				[[verifyCount(action3, never()) withMatcher:HC_anything()] consumeDeltaTime:0.0];
			});
		});
		
		context(@"calling consumeDeltaTime: with a positive time", ^{
			__block NSTimeInterval timeLeft1;
			
			beforeEach(^{
				timeLeft1 = [sequence consumeDeltaTime:1.0];
			});
			
			it(@"returns no time left", ^{
				expect(timeLeft1).to.equal(0.0);
			});
			
			it(@"calls consumeDeltaTime: only on the first action", ^{
				[verify(action1) consumeDeltaTime:1.0];
				[[verifyCount(action2, never()) withMatcher:HC_anything()] consumeDeltaTime:0.0];
				[[verifyCount(action3, never()) withMatcher:HC_anything()] consumeDeltaTime:0.0];
			});

			context(@"called consumeDeltaTime: with the first and second action returning some time left", ^{
				__block NSTimeInterval timeLeft2;
				
				beforeEach(^{
					[given([action1 consumeDeltaTime:2.0]) willReturnDouble:1.5];
					[given([action2 consumeDeltaTime:1.5]) willReturnDouble:0.5];
					timeLeft2 = [sequence consumeDeltaTime:2.0];
				});
				
				it(@"returns no time left", ^{
					expect(timeLeft2).to.equal(0.0);
				});
				
				it(@"calls consumeDeltaTime: on the first and second action", ^{
					[verify(action1) consumeDeltaTime:2.0];
					[verify(action2) consumeDeltaTime:1.5];
					[verify(action3) consumeDeltaTime:0.5];
				});
				
				context(@"called consumeDeltaTime: with the last action returning some time left", ^{
					__block NSTimeInterval timeLeft3;
					
					beforeEach(^{
						[given([action3 consumeDeltaTime:1.0]) willReturnDouble:0.7];
						timeLeft3 = [sequence consumeDeltaTime:1.0];
					});
					
					it(@"returns the time left from the last action", ^{
						expect(timeLeft3).to.equal(0.7);
					});
					
					it(@"calls consumeDeltaTime: on the last action", ^{
						[[verifyCount(action1, times(2)) withMatcher:HC_anything()] consumeDeltaTime:0.0];
						[[verifyCount(action2, times(1)) withMatcher:HC_anything()] consumeDeltaTime:0.0];
						[verify(action3) consumeDeltaTime:1.0];
					});
				});
				
				context(@"called consumeDeltaTime: with a negative time and with all actions returning some time left", ^{
					__block NSTimeInterval timeLeft4;
					
					beforeEach(^{
						[given([action3 consumeDeltaTime:-5.0]) willReturnDouble:-4.5];
						[given([action2 consumeDeltaTime:-4.5]) willReturnDouble:-3.5];
						[given([action1 consumeDeltaTime:-3.5]) willReturnDouble:-2.0];
						timeLeft4 = [sequence consumeDeltaTime:-5.0];
					});
					
					it(@"returns the time left from the first action", ^{
						expect(timeLeft4).to.equal(-2.0);
					});
					
					it(@"calls consumeDeltaTime: on all actions from last to first", ^{
						[verify(action3) consumeDeltaTime:-5.0];
						[verify(action2) consumeDeltaTime:-4.5];
						[verify(action1) consumeDeltaTime:-3.5];
					});
				});
				
				context(@"created a copy of the sequence", ^{
					__block FUSequenceAction* sequenceCopy;
					__block NSObject<FUAction>* action1Copy;
					__block NSObject<FUAction>* action2Copy;
					__block NSObject<FUAction>* action3Copy;
					
					beforeEach(^{
						action1Copy = mockObjectAndProtocol([NSObject class], @protocol(FUAction));
						[given([action1 copy]) willReturn:action1Copy];
						
						action2Copy = mockObjectAndProtocol([NSObject class], @protocol(FUAction));
						[given([action2 copy]) willReturn:action2Copy];
						
						action3Copy = mockObjectAndProtocol([NSObject class], @protocol(FUAction));
						[given([action3 copy]) willReturn:action3Copy];
						
						sequenceCopy = [sequence copy];
					});
					
					it(@"is not nil", ^{
						expect(sequenceCopy).toNot.beNil();
					});
					
					it(@"is not the same instance", ^{
						expect(sequenceCopy).toNot.beIdenticalTo(sequence);
					});
					
					it(@"contains all three copied actions", ^{
						NSArray* actionsArray = [sequenceCopy actions];
						expect(actionsArray).to.haveCountOf(3);
						expect(actionsArray).to.contain(action1Copy);
						expect(actionsArray).to.contain(action2Copy);
						expect(actionsArray).to.contain(action3Copy);
					});
					
					context(@"called consumeDeltaTime: on the copied sequence", ^{
						beforeEach(^{
							[sequenceCopy consumeDeltaTime:3.0];
						});
						
						it(@"does not call consumeDeltaTime: on the original actions", ^{
							[[verifyCount(action1, times(2)) withMatcher:HC_anything()] consumeDeltaTime:0.0];
							[[verifyCount(action2, times(1)) withMatcher:HC_anything()] consumeDeltaTime:0.0];
							[[verifyCount(action3, times(1)) withMatcher:HC_anything()] consumeDeltaTime:0.0];
						});
						
						it(@"calls consumeDeltaTime: on the last copied actions", ^{
							[[verifyCount(action1Copy, never()) withMatcher:HC_anything()] consumeDeltaTime:0.0];
							[[verifyCount(action2Copy, never()) withMatcher:HC_anything()] consumeDeltaTime:0.0];
							[verify(action3Copy) consumeDeltaTime:3.0];
						});
					});
				});
			});
		});
		
		context(@"added an action to the actions array", ^{
			__block NSObject<FUAction>* extraAction;
			
			beforeEach(^{
				extraAction = mockObjectAndProtocol([NSObject class], @protocol(FUAction));
				[actions addObject:extraAction];
			});
			
			it(@"does not contain the extra action", ^{
				expect([sequence actions]).toNot.contain(extraAction);
			});
			
			context(@"calling consumeDeltaTime: on the sequence", ^{
				it(@"does not call consumeDeltaTime: on the extra action", ^{
					[sequence consumeDeltaTime:10.0];
					[[verifyCount(extraAction, never()) withMatcher:HC_anything()] consumeDeltaTime:0.0];
				});
			});
		});
	});
});

SPEC_END