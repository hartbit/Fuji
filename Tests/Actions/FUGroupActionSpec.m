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


static NSString* const FUArrayNilEmptyMessage = @"Expected array to not be nil or empty";
static NSString* const FUActionSubclassMessage = @"Expected 'action=%@' to be a subclass of FUTimedAction";
static NSString* const FUDurationDifferentMessage = @"Expected actions to have the same duration";


SPEC_BEGIN(FUGroupAction)

describe(@"A group action", ^{
	it(@"is a timed action", ^{
		expect([FUGroupAction class]).to.beSubclassOf([FUTimedAction class]);
	});
	
	context(@"initilized with a nil array", ^{
		it(@"throws an exception", ^{
			assertThrows([[FUGroupAction alloc] initWithActions:nil], NSInvalidArgumentException, FUArrayNilEmptyMessage);
		});
	});
	
	context(@"initilized with an empty array", ^{
		it(@"throws an exception", ^{
			assertThrows([[FUGroupAction alloc] initWithActions:@[]], NSInvalidArgumentException, FUArrayNilEmptyMessage);
		});
	});
	
	context(@"initializing with an array containing an object that is not a FUTimedAction", ^{
		it(@"throws an exception", ^{
			id object = [FUSpawnAction new];
			NSArray* array = @[object];
			assertThrows([[FUGroupAction alloc] initWithActions:array], NSInvalidArgumentException, FUActionSubclassMessage, object);
		});
	});
	
	context(@"initializing with an array containing actions with different durations", ^{
		it(@"throws an exception", ^{
			FUTimedAction* action1 = [[FUTimedAction alloc] initWithDuration:1.0];
			FUTimedAction* action2 = [[FUTimedAction alloc] initWithDuration:2.0];
			NSArray* array = @[action1, action2];
			assertThrows([[FUGroupAction alloc] initWithActions:array], NSInvalidArgumentException, FUDurationDifferentMessage);
		});
	});
	
	context(@"created three timed actions", ^{
		__block FUTimedAction* action1;
		__block FUTimedAction* action2;
		__block FUTimedAction* action3;
		__block NSMutableArray* actions;
		
		beforeEach(^{
			action1 = mock([FUTimedAction class]);
			[given([action1 isKindOfClass:[FUTimedAction class]]) willReturnBool:YES];
			[given([action1 duration]) willReturnDouble:2.0];
			
			action2 = mock([FUTimedAction class]);
			[given([action2 isKindOfClass:[FUTimedAction class]]) willReturnBool:YES];
			[given([action2 duration]) willReturnDouble:2.0];
			
			action3 = mock([FUTimedAction class]);
			[given([action3 isKindOfClass:[FUTimedAction class]]) willReturnBool:YES];
			[given([action3 duration]) willReturnDouble:2.0];
			
			actions = [NSMutableArray arrayWithObjects:action1, action2, action3, nil];
		});
		
		context(@"initializing with the default initializer", ^{
			__block FUGroupAction* group;
			
			beforeEach(^{
				group = [[FUGroupAction alloc] initWithActions:actions];
			});
			
			it(@"has the same duration as the actions", ^{
				expect([group duration]).to.equal(2.0);
			});
			
			it(@"contains all three actions", ^{
				NSArray* actionsArray = [group actions];
				expect(actionsArray).to.haveCountOf(3);
				expect(actionsArray).to.contain(action1);
				expect(actionsArray).to.contain(action2);
				expect(actionsArray).to.contain(action3);
			});
			
			context(@"setting a normalized time between 0 and 1", ^{
				it(@"sets the same normalized time on the subactions", ^{
					[group setNormalizedTime:0.5f];
					[verify(action1) setNormalizedTime:0.5f];
					[verify(action2) setNormalizedTime:0.5f];
					[verify(action3) setNormalizedTime:0.5f];
				});
			});
			
			context(@"setting a normalized time less than 0", ^{
				it(@"sets the same normalized time on the subactions", ^{
					[group setNormalizedTime:-0.5f];
					[verify(action1) setNormalizedTime:-0.5f];
					[verify(action2) setNormalizedTime:-0.5f];
					[verify(action3) setNormalizedTime:-0.5f];
				});
			});
			
			context(@"setting a normalized time greather than 1", ^{
				it(@"sets the same normalized time on the subactions", ^{
					[group setNormalizedTime:1.5f];
					[verify(action1) setNormalizedTime:1.5f];
					[verify(action2) setNormalizedTime:1.5f];
					[verify(action3) setNormalizedTime:1.5f];
				});
			});
			
			context(@"created a copy of the group", ^{
				__block FUGroupAction* groupCopy;
				__block NSObject<FUAction>* action1Copy;
				__block NSObject<FUAction>* action2Copy;
				__block NSObject<FUAction>* action3Copy;
				
				beforeEach(^{
					action1Copy = mock([FUTimedAction class]);
					[given([action1 copy]) willReturn:action1Copy];
					
					action2Copy = mock([FUTimedAction class]);
					[given([action2 copy]) willReturn:action2Copy];
					
					action3Copy = mock([FUTimedAction class]);
					[given([action3 copy]) willReturn:action3Copy];
					
					groupCopy = [group copy];
				});
				
				it(@"is not the same instance", ^{
					expect(groupCopy).toNot.beIdenticalTo(group);
				});
				
				it(@"contains all three copied actions", ^{
					NSArray* actionsArray = [groupCopy actions];
					expect(actionsArray).to.haveCountOf(3);
					expect(actionsArray).to.contain(action1Copy);
					expect(actionsArray).to.contain(action2Copy);
					expect(actionsArray).to.contain(action3Copy);
				});
				
				context(@"set the normalized time on the copied group", ^{
					beforeEach(^{
						[groupCopy setNormalizedTime:0.6f];
					});
					
					it(@"does not set the normalized time of the original actions", ^{
						[[verifyCount(action1, never()) withMatcher:HC_anything()] setNormalizedTime:0.0f];
						[[verifyCount(action2, never()) withMatcher:HC_anything()] setNormalizedTime:0.0f];
						[[verifyCount(action3, never()) withMatcher:HC_anything()] setNormalizedTime:0.0f];
					});
					
					it(@"sets the normalized time of the copied actions", ^{
						[verify(action1Copy) setNormalizedTime:0.6f];
						[verify(action2Copy) setNormalizedTime:0.6f];
						[verify(action3Copy) setNormalizedTime:0.6f];
					});
				});
			});
			
			context(@"added an action to the actions array", ^{
				__block NSObject<FUAction>* extraAction;
				
				beforeEach(^{
					extraAction = mock([FUTimedAction class]);
					[actions addObject:extraAction];
				});
				
				it(@"does not contain the extra action", ^{
					expect([group actions]).toNot.contain(extraAction);
				});
				
				context(@"setting a normalized time", ^{
					it(@"does not set the normalized time on the extra action", ^{
						[group setNormalizedTime:0.6f];
						[[verifyCount(extraAction, never()) withMatcher:HC_anything()] setNormalizedTime:0.0f];
					});
				});
			});
		});
		
		context(@"initializing via the function", ^{
			__block FUGroupAction* group;
			
			beforeEach(^{
				group = FUGroup(@[action1, action2, action3]);
			});
			
			it(@"is a group action", ^{
				expect(group).to.beKindOf([FUGroupAction class]);
			});
			
			it(@"contains all three actions", ^{
				NSArray* actionsArray = [group actions];
				expect(actionsArray).to.haveCountOf(3);
				expect(actionsArray).to.contain(action1);
				expect(actionsArray).to.contain(action2);
				expect(actionsArray).to.contain(action3);
			});
		});
	});
});

SPEC_END
