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
static NSString* const FUActionProtocolMessage = @"Expected 'action=%@' to conform to the FUAction protocol";


SPEC_BEGIN(FUGroupAction)

describe(@"A group action", ^{
	it(@"is an action", ^{
		expect([[FUGroupAction class] conformsToProtocol:@protocol(FUAction)]).to.beTruthy();
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
	
	context(@"initializing with an array containing an object that is not an FUAction", ^{
		it(@"throws an exception", ^{
			id object = [NSString string];
			NSArray* array = [NSArray arrayWithObject:object];
			assertThrows([[FUGroupAction alloc] initWithActions:array], NSInvalidArgumentException, FUActionProtocolMessage, object);
		});
	});
	
	context(@"initializing via the function with no actions", ^{
		it(@"returns a FUGroupAction", ^{
			expect(FUGroup()).to.beKindOf([FUGroupAction class]);
		});
	});
	
	context(@"initializing with three actions", ^{
		__block NSObject<FUAction>* action1;
		__block NSObject<FUAction>* action2;
		__block NSObject<FUAction>* action3;
		__block NSMutableArray* actions;
		__block FUGroupAction* group;
		
		beforeEach(^{
			action1 = mockObjectAndProtocol([NSObject class], @protocol(FUAction));
			action2 = mockObjectAndProtocol([NSObject class], @protocol(FUAction));
			action3 = mockObjectAndProtocol([NSObject class], @protocol(FUAction));
			actions = [NSMutableArray arrayWithObjects:action1, action2, action3, nil];
			group = [[FUGroupAction alloc] initWithActions:actions];
		});
		
		context(@"initializing via the function with three actions", ^{
			it(@"returns a FUGroupAction", ^{
				expect(FUGroup(action1, action2, action3)).to.beKindOf([FUGroupAction class]);
			});
		});
		
		it(@"is not nil", ^{
			expect(group).toNot.beNil();
		});
		
		it(@"contains all three actions", ^{
			NSArray* actionsArray = [group actions];
			expect(actionsArray).to.haveCountOf(3);
			expect(actionsArray).to.contain(action1);
			expect(actionsArray).to.contain(action2);
			expect(actionsArray).to.contain(action3);
		});
		
		context(@"updating the group with 0.0 seconds", ^{
			it(@"updates no action", ^{
				[group updateWithDeltaTime:0.0];
				[[verifyCount(action1, never()) withMatcher:HC_anything()] updateWithDeltaTime:0.0];
				[[verifyCount(action2, never()) withMatcher:HC_anything()] updateWithDeltaTime:0.0];
				[[verifyCount(action3, never()) withMatcher:HC_anything()] updateWithDeltaTime:0.0];
			});
		});
		
		context(@"updated the group", ^{
			__block NSTimeInterval timeLeft1;
			
			beforeEach(^{
				timeLeft1 = [group updateWithDeltaTime:1.0];
			});
			
			it(@"returns no time left", ^{
				expect(timeLeft1).to.equal(0.0);
			});
			
			it(@"updates all actions", ^{
				[verify(action1) updateWithDeltaTime:1.0];
				[verify(action2) updateWithDeltaTime:1.0];
				[verify(action3) updateWithDeltaTime:1.0];
			});
			
			context(@"updated the group and made one action return some time left", ^{
				__block NSTimeInterval timeLeft2;
				
				beforeEach(^{
					[given([action3 updateWithDeltaTime:2.0]) willReturnDouble:0.5];
					timeLeft2 = [group updateWithDeltaTime:2.0];
				});
				
				it(@"returns no time left", ^{
					expect(timeLeft2).to.equal(0.0);
				});
				
				it(@"updates all actions", ^{
					[verify(action1) updateWithDeltaTime:2.0];
					[verify(action2) updateWithDeltaTime:2.0];
					[verify(action3) updateWithDeltaTime:2.0];
				});
				
				context(@"updated the group and made all actions return some time left", ^{
					__block NSTimeInterval timeLeft3;
					
					beforeEach(^{
						[given([action1 updateWithDeltaTime:3.0]) willReturnDouble:0.8];
						[given([action2 updateWithDeltaTime:3.0]) willReturnDouble:0.2];
						[given([action3 updateWithDeltaTime:3.0]) willReturnDouble:0.5];
						timeLeft3 = [group updateWithDeltaTime:3.0];
					});
					
					it(@"returns the smallest time left", ^{
						expect(timeLeft3).to.equal(0.2);
					});
					
					it(@"updates all actions", ^{
						[verify(action1) updateWithDeltaTime:3.0];
						[verify(action2) updateWithDeltaTime:3.0];
						[verify(action3) updateWithDeltaTime:3.0];
					});
				});
				
				context(@"updated the group with -5.0 seconds and made all actions return time left", ^{
					__block NSTimeInterval timeLeft5;
					
					beforeEach(^{
						[given([action1 updateWithDeltaTime:-5.0]) willReturnDouble:-0.8];
						[given([action2 updateWithDeltaTime:-5.0]) willReturnDouble:-1.2];
						[given([action3 updateWithDeltaTime:-5.0]) willReturnDouble:-2.0];
						timeLeft5 = [group updateWithDeltaTime:-5.0];
					});
					
					it(@"returned -0.8 seconds left", ^{
						expect(timeLeft5).to.equal(-0.8);
					});
					
					it(@"updates all actions", ^{
						[verify(action3) updateWithDeltaTime:-5.0];
						[verify(action2) updateWithDeltaTime:-5.0];
						[verify(action1) updateWithDeltaTime:-5.0];
					});
				});
				
				context(@"updated a copy of the group", ^{
					__block FUGroupAction* groupCopy;
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
						
						groupCopy = [group copy];
						[groupCopy updateWithDeltaTime:4.0];
					});
					
					it(@"is not nil", ^{
						expect(groupCopy).toNot.beNil();
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
					
					it(@"does not update the original actions", ^{
						[[verifyCount(action1, times(2)) withMatcher:HC_anything()] updateWithDeltaTime:0.0];
						[[verifyCount(action2, times(2)) withMatcher:HC_anything()] updateWithDeltaTime:0.0];
						[[verifyCount(action3, times(2)) withMatcher:HC_anything()] updateWithDeltaTime:0.0];
					});
					
					it(@"updates the copied actions", ^{
						[verify(action1Copy) updateWithDeltaTime:4.0];
						[verify(action2Copy) updateWithDeltaTime:4.0];
						[verify(action3Copy) updateWithDeltaTime:4.0];
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
				expect([group actions]).toNot.contain(extraAction);
			});
			
			context(@"updating the group", ^{
				it(@"does not update the extra action", ^{
					[group updateWithDeltaTime:10.0];
					[[verifyCount(extraAction, never()) withMatcher:HC_anything()] updateWithDeltaTime:0.0];
				});
			});
		});
	});
});

SPEC_END