//
//  FUTweenActionSpec.m
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


static NSString* const FUBlockNullMessage = @"Expected block to not be NULL";
static NSString* const FUTargetNilMessage = @"Expected target to not be nil";
static NSString* const FUKeyNilMessage = @"Expected key to not be nil or empty";
static NSString* const FUKeyImmutableMessage = @"Expected 'key=%@' on 'target=%@' to be mutable";
static NSString* const FUKeyNumericalMessage = @"Expected 'key=%@' on 'target=%@' to be of a numerical type";
static NSString* const FUKeyVector2Message = @"Expected 'key=%@' on 'target=%@' to be of type GLKVector2";
static NSString* const FUValueNilMessage = @"Expected value to not be nil";
static NSString* const FUAddendNilMessage = @"Expected addend to not be nil";
static NSString* const FUFactorNilMessage = @"Expected factor to not be nil";


@interface FUTestObject : NSObject
@property (nonatomic) double doubleValue;
@property (nonatomic) GLKVector2 position;
@property (nonatomic) GLKVector2 scale;
@property (nonatomic) GLKVector4 tint;
@end


SPEC_BEGIN(FUTweenAction)

describe(@"A tween action", ^{
	it(@"is a timed action", ^{
		expect([FUTweenAction class]).to.beSubclassOf([FUTimedAction class]);
	});
	
	context(@"initizing with a NULL block", ^{
		it(@"throws an exception", ^{
			assertThrows([[FUTweenAction alloc] initWithDuration:2.0 block:NULL], NSInvalidArgumentException, FUBlockNullMessage);
		});
	});
	
	context(@"initialized with a block", ^{
		__block FUTweenAction* action;
		__block NSUInteger callCount;
		__block float normalizedTime;
		
		beforeEach(^{
			callCount = 0;
			action = [[FUTweenAction alloc] initWithDuration:2.0 block:^(float t) {
				callCount++;
				normalizedTime = t;
			}];
		});
		
		it(@"was not called", ^{
			expect(callCount).to.equal(0);
		});
		
		context(@"setting the normalized time to 0.0f", ^{
			it(@"does not call the block", ^{
				[action setNormalizedTime:0.0f];
				expect(callCount).to.equal(0);
			});
		});
		
		context(@"set a negative normalized time", ^{
			beforeEach(^{
				[action setNormalizedTime:-0.5f];
			});
			
			it(@"calls the block with the normalized time", ^{
				expect(callCount).to.equal(1);
				expect(normalizedTime).to.equal(-0.5f);
			});
			
			context(@"setting the normalized time to 0.0f", ^{
				it(@"calls the block with the normalized time", ^{
					[action setNormalizedTime:0.0f];
					expect(callCount).to.equal(2);
					expect(normalizedTime).to.equal(0.0f);
				});
			});
			
			context(@"created a copy of the action", ^{
				__block FUTweenAction* actionCopy;
				
				beforeEach(^{
					actionCopy = [action copy];
				});
				
				it(@"is not the same instance", ^{
					expect(actionCopy).toNot.beIdenticalTo(action);
				});
				
				context(@"setting the same normalized time", ^{
					it(@"does not call the block again", ^{
						[actionCopy setNormalizedTime:-0.5f];
						expect(callCount).to.equal(1);
					});
				});
				
				context(@"setting a different normalized time", ^{
					it(@"calls the block again with the normalized time", ^{
						[actionCopy setNormalizedTime:0.5f];
						expect(callCount).to.equal(2);
						expect(normalizedTime).to.equal(0.5f);
					});
				});
			});
		});
		
		context(@"setting a normalized time between 0.0f and 1.0f", ^{
			it(@"calls the block with the normalized time", ^{
				[action setNormalizedTime:0.5f];
				expect(callCount).to.equal(1);
				expect(normalizedTime).to.equal(0.5f);
			});
		});
		
		context(@"setting the normalized time to 1.0f", ^{			
			it(@"calls the block with the normalized time", ^{
				[action setNormalizedTime:1.0f];
				expect(callCount).to.equal(1);
				expect(normalizedTime).to.equal(1.0f);
			});
		});
		
		context(@"setting a normalized time greater than 1.0f", ^{
			it(@"calls the block with the normalized time", ^{
				[action setNormalizedTime:1.5f];
				expect(callCount).to.equal(1);
				expect(normalizedTime).to.equal(1.5f);
			});
		});
	});
	
	context(@"initialized with the FUTween function", ^{
		__block FUTweenAction* tween;
		__block BOOL wasCalled = NO;
		
		beforeEach(^{
			tween = FUTween(2.0, ^(float t) {
				wasCalled = YES;
			});
		});		
		
		it(@"has a duration of 2.0", ^{
			expect([tween duration]).to.equal(2.0);
		});
		
		context(@"setting the normalized time", ^{
			it(@"calls the block", ^{
				[tween setNormalizedTime:1.0f];
				expect(wasCalled).to.beTruthy();
			});
		});
	});
	
	context(@"the FUTweenTo function", ^{
		context(@"initializing with a nil target", ^{
			it(@"throws an exception", ^{
				assertThrows(FUTweenTo(0.0, nil, @"key", [NSNumber numberWithDouble:1.0]), NSInvalidArgumentException, FUTargetNilMessage);
			});
		});
		
		context(@"initializing with a nil key", ^{
			it(@"throws an exception", ^{
				assertThrows(FUTweenTo(0.0, [NSString string], nil, [NSNumber numberWithDouble:1.0]), NSInvalidArgumentException, FUKeyNilMessage);
			});
		});
		
		context(@"initializing with an undefined key", ^{
			it(@"throws an exception", ^{
				id target = [NSString string];
				NSString* key = @"count";
				STAssertThrows(FUTweenTo(0.0, target, key, [NSNumber numberWithDouble:1.0]), nil);
			});
		});
		
		context(@"initializing with a immutable key", ^{
			it(@"throws an exception", ^{
				id target = [NSString string];
				NSString* key = @"length";
				assertThrows(FUTweenTo(0.0, target, key, [NSNumber numberWithDouble:1.0]), NSInvalidArgumentException, FUKeyImmutableMessage, key, target);
			});
		});
		
		context(@"initializing with a non-numerical key", ^{
			it(@"throws an exception", ^{
				id target = [NSMutableURLRequest requestWithURL:nil];
				NSString* key = @"URL";
				assertThrows(FUTweenTo(0.0, target, key, [NSNumber numberWithDouble:1.0]), NSInvalidArgumentException, FUKeyNumericalMessage, key, target);
			});
		});
		
		context(@"initializing with a nil value", ^{
			it(@"throws an exception", ^{
				assertThrows(FUTweenTo(0.0, [NSMutableData data], @"length", nil), NSInvalidArgumentException, FUValueNilMessage);
			});
		});
		
		context(@"initialized with valid arguments", ^{
			__block FUTestObject* target;
			__block FUTweenAction* tween;
			
			beforeEach(^{
				target = [FUTestObject new];
				tween = FUTweenTo(1.0, target, @"doubleValue", [NSNumber numberWithDouble:4.0]);
			});
			
			it(@"has the correct duration", ^{
				expect([tween duration]).to.equal(1.0);
			});
			
			context(@"set the value on the target to 2.0", ^{
				beforeEach(^{
					[target setDoubleValue:2.0];
				});
				
				context(@"set a normalized time of 0.5f", ^{
					beforeEach(^{
						[tween setNormalizedTime:0.5f];
					});
					
					it(@"sets the value half-way through", ^{
						expect([target doubleValue]).to.equal(3.0);
					});
					
					context(@"setting a normalized time of 0.0f", ^{
						it(@"sets the value back to the start value", ^{
							[tween setNormalizedTime:0.0f];
							expect([target doubleValue]).to.equal(2.0);
						});
					});
					
					context(@"created a copy of the tween", ^{
						__block FUTweenAction* tweenCopy;
						
						beforeEach(^{
							tweenCopy = [tween copy];
						});
						
						context(@"setting a normalized time of 0.0f", ^{
							it(@"sets the value back to the start value", ^{
								[tween setNormalizedTime:0.0f];
								expect([target doubleValue]).to.equal(2.0);
							});
						});
					});
				});
				
				context(@"setting a normalized time of 1.0f", ^{
					it(@"sets the value to the toValue", ^{
						[tween setNormalizedTime:1.0f];
						expect([target doubleValue]).to.equal(4.0);
					});
				});
				
				context(@"setting a normalized time of -0.5f", ^{
					it(@"sets the value half-way before the start value", ^{
						[tween setNormalizedTime:-0.5f];
						expect([target doubleValue]).to.equal(1.0);
					});
				});
				
				context(@"setting a setNormalizedTime of 1.5f", ^{
					it(@"sets the value half-way after the toValue", ^{
						[tween setNormalizedTime:1.5f];
						expect([target doubleValue]).to.equal(5.0);
					});
				});
			});
		});
	});
	
	context(@"the FUTweenSum function", ^{
		context(@"initializing with a nil target", ^{
			it(@"throws an exception", ^{
				assertThrows(FUTweenSum(0.0, nil, @"key", [NSNumber numberWithDouble:1.0]), NSInvalidArgumentException, FUTargetNilMessage);
			});
		});
		
		context(@"initializing with a nil key", ^{
			it(@"throws an exception", ^{
				assertThrows(FUTweenSum(0.0, [NSString string], nil, [NSNumber numberWithDouble:1.0]), NSInvalidArgumentException, FUKeyNilMessage);
			});
		});
		
		context(@"initializing with an undefined key", ^{
			it(@"throws an exception", ^{
				id target = [NSString string];
				NSString* key = @"count";
				STAssertThrows(FUTweenSum(0.0, target, key, [NSNumber numberWithDouble:1.0]), nil);
			});
		});
		
		context(@"initializing with a immutable key", ^{
			it(@"throws an exception", ^{
				id target = [NSString string];
				NSString* key = @"length";
				assertThrows(FUTweenSum(0.0, target, key, [NSNumber numberWithDouble:1.0]), NSInvalidArgumentException, FUKeyImmutableMessage, key, target);
			});
		});
		
		context(@"initializing with a non-numerical key", ^{
			it(@"throws an exception", ^{
				id target = [NSMutableURLRequest requestWithURL:nil];
				NSString* key = @"URL";
				assertThrows(FUTweenSum(0.0, target, key, [NSNumber numberWithDouble:1.0]), NSInvalidArgumentException, FUKeyNumericalMessage, key, target);
			});
		});
		
		context(@"initializing with a nil addend", ^{
			it(@"throws an exception", ^{
				assertThrows(FUTweenSum(0.0, [NSMutableData data], @"length", nil), NSInvalidArgumentException, FUAddendNilMessage);
			});
		});

		context(@"initialized with valid arguments", ^{
			__block FUTestObject* target;
			__block FUTweenAction* tween;
			
			beforeEach(^{
				target = [FUTestObject new];
				tween = FUTweenSum(1.0, target, @"doubleValue", [NSNumber numberWithDouble:2.0]);
			});
			
			it(@"has the correct duration", ^{
				expect([tween duration]).to.equal(1.0);
			});
			
			context(@"set the value on the target to 2.0", ^{
				beforeEach(^{
					[target setDoubleValue:2.0];
				});
				
				context(@"set a normalized time of 0.5f", ^{
					beforeEach(^{
						[tween setNormalizedTime:0.5f];
					});
					
					it(@"sets the value half-way through", ^{
						expect([target doubleValue]).to.equal(3.0);
					});
					
					context(@"setting a normalized time of 0.0f", ^{
						it(@"sets the value back to the start value", ^{
							[tween setNormalizedTime:0.0f];
							expect([target doubleValue]).to.equal(2.0);
						});
					});
				});
				
				context(@"created a copy of the tween", ^{
					__block FUTweenAction* tweenCopy;
					
					beforeEach(^{
						tweenCopy = [tween copy];
					});
					
					context(@"setting a normalized time of 0.5f", ^{
						it(@"sets the value half-way through", ^{
							[tweenCopy setNormalizedTime:0.5f];
							expect([target doubleValue]).to.equal(3.0);
						});
					});
				});
				
				context(@"setting a normalized time of 1.0f", ^{
					it(@"sets the value to the end value", ^{
						[tween setNormalizedTime:1.0f];
						expect([target doubleValue]).to.equal(4.0);
					});
				});
				
				context(@"setting a normalized time of -0.5f", ^{
					it(@"sets the value half-way before the start value", ^{
						[tween setNormalizedTime:-0.5f];
						expect([target doubleValue]).to.equal(1.0);
					});
				});
				
				context(@"setting a normalized time of 1.5f", ^{
					it(@"sets the value half-way after the toValue", ^{
						[tween setNormalizedTime:1.5f];
						expect([target doubleValue]).to.equal(5.0);
					});
				});
			});
		});
	});
	
	context(@"the FUTweenProduct function", ^{
		context(@"initializing with a nil target", ^{
			it(@"throws an exception", ^{
				assertThrows(FUTweenProduct(0.0, nil, @"key", [NSNumber numberWithDouble:1.0]), NSInvalidArgumentException, FUTargetNilMessage);
			});
		});
		
		context(@"initializing with a nil key", ^{
			it(@"throws an exception", ^{
				assertThrows(FUTweenProduct(0.0, [NSString string], nil, [NSNumber numberWithDouble:1.0]), NSInvalidArgumentException, FUKeyNilMessage);
			});
		});
		
		context(@"initializing with an undefined key", ^{
			it(@"throws an exception", ^{
				id target = [NSString string];
				NSString* key = @"count";
				STAssertThrows(FUTweenProduct(0.0, target, key, [NSNumber numberWithDouble:1.0]), nil);
			});
		});
		
		context(@"initializing with a immutable key", ^{
			it(@"throws an exception", ^{
				id target = [NSString string];
				NSString* key = @"length";
				assertThrows(FUTweenProduct(0.0, target, key, [NSNumber numberWithDouble:1.0]), NSInvalidArgumentException, FUKeyImmutableMessage, key, target);
			});
		});
		
		context(@"initializing with a non-numerical key", ^{
			it(@"throws an exception", ^{
				id target = [NSMutableURLRequest requestWithURL:nil];
				NSString* key = @"URL";
				assertThrows(FUTweenProduct(0.0, target, key, [NSNumber numberWithDouble:1.0]), NSInvalidArgumentException, FUKeyNumericalMessage, key, target);
			});
		});
		
		context(@"initializing with a nil factor", ^{
			it(@"throws an exception", ^{
				assertThrows(FUTweenProduct(0.0, [NSMutableData data], @"length", nil), NSInvalidArgumentException, FUFactorNilMessage);
			});
		});
		
		context(@"initialized with valid arguments", ^{
			__block FUTestObject* target;
			__block FUTweenAction* tween;
			
			beforeEach(^{
				target = [FUTestObject new];
				tween = FUTweenProduct(1.0, target, @"doubleValue", [NSNumber numberWithDouble:2.0]);
			});
			
			it(@"has the correct duration", ^{
				expect([tween duration]).to.equal(1.0);
			});
			
			context(@"set the value on the target to 3.0", ^{
				beforeEach(^{
					[target setDoubleValue:3.0];
				});
				
				context(@"set a normalized time of 0.5f", ^{
					beforeEach(^{
						[tween setNormalizedTime:0.5f];
					});
					
					it(@"sets the value half-way through", ^{
						expect([target doubleValue]).to.equal(4.5);
					});
					
					context(@"setting a normalized time of 0.0f", ^{
						it(@"sets the value back to the start value", ^{
							[tween setNormalizedTime:0.0f];
							expect([target doubleValue]).to.equal(3.0);
						});
					});
				});
				
				context(@"created a copy of the tween", ^{
					__block FUTweenAction* tweenCopy;
					
					beforeEach(^{
						tweenCopy = [tween copy];
					});
					
					context(@"setting a normalized time of 0.5f", ^{
						it(@"sets the value half-way through", ^{
							[tweenCopy setNormalizedTime:0.5f];
							expect([target doubleValue]).to.equal(4.5);
						});
					});
				});
				
				context(@"setting a normalized time of 1.0f", ^{
					it(@"sets the value to the end value", ^{
						[tween setNormalizedTime:1.0f];
						expect([target doubleValue]).to.equal(6.0);
					});
				});
				
				context(@"setting a normalized time of -0.5f", ^{
					it(@"sets the value half-way before the start value", ^{
						[tween setNormalizedTime:-0.5f];
						expect([target doubleValue]).to.equal(1.5);
					});
				});
				
				context(@"setting a normalized time of 1.5f", ^{
					it(@"sets the value half-way after the toValue", ^{
						[tween setNormalizedTime:1.5f];
						expect([target doubleValue]).to.equal(7.5);
					});
				});
			});
		});
	});
	
	context(@"the FUMoveTo function", ^{
		context(@"initializing with a nil target", ^{
			it(@"throws an exception", ^{
				assertThrows(FUMoveTo(0.0, nil, GLKVector2One), NSInvalidArgumentException, FUTargetNilMessage);
			});
		});
		
		context(@"initialized with a target with a position property", ^{
			__block FUTestObject* target;
			__block FUTweenAction* tween;
			
			beforeEach(^{
				target = [FUTestObject new];
				tween = FUMoveTo(2.0, target, GLKVector2Make(2.0f, 3.0f));
			});
			
			it(@"has the correct duration", ^{
				expect([tween duration]).to.equal(2.0);
			});
			
			context(@"set the position of the target to (1.0f, 0.0f)", ^{
				beforeEach(^{
					[target setPosition:GLKVector2Make(1.0f, 0.0f)];
				});
				
				context(@"set a normalized time of 0.5f", ^{
					beforeEach(^{
						[tween setNormalizedTime:0.5f];
					});
					
					it(@"sets the position half-way through", ^{
						expect(FUVector2AreClose([target position], GLKVector2Make(1.5f, 1.5f))).to.beTruthy();
					});
					
					context(@"setting a normalized time of 0.0f", ^{
						it(@"sets the value back to the start position", ^{
							[tween setNormalizedTime:0.0f];
							expect(FUVector2AreClose([target position], GLKVector2Make(1.0f, 0.0f))).to.beTruthy();
						});
					});
				});
				
				context(@"created a copy of the tween", ^{
					__block FUTweenAction* tweenCopy;
					
					beforeEach(^{
						tweenCopy = [tween copy];
					});
					
					context(@"setting a normalized time of 0.0f", ^{
						it(@"sets the position back to the start position", ^{
							[tweenCopy setNormalizedTime:0.0f];
							expect(FUVector2AreClose([target position], GLKVector2Make(1.0f, 0.0f))).to.beTruthy();
						});
					});
				});
				
				context(@"setting a normalized time of 1.0f", ^{
					it(@"sets the position to the end position", ^{
						[tween setNormalizedTime:1.0f];
						expect(FUVector2AreClose([target position], GLKVector2Make(2.0f, 3.0f))).to.beTruthy();
					});
				});
				
				context(@"setting a normalized time of -0.5f", ^{
					it(@"sets the position half-way before the start position", ^{
						[tween setNormalizedTime:-0.5f];
						expect(FUVector2AreClose([target position], GLKVector2Make(0.5f, -1.5f))).to.beTruthy();
					});
				});
				
				context(@"setting a normalized time of 1.5f", ^{
					it(@"sets the position half-way after the end position", ^{
						[tween setNormalizedTime:1.5f];
						expect(FUVector2AreClose([target position], GLKVector2Make(2.5f, 4.5f))).to.beTruthy();
					});
				});
			});
		});
		
		context(@"initializing with an entity", ^{
			__block FUEntity* entity;
			__block FUTestObject* target;
			__block FUTweenAction* tween;
			
			beforeEach(^{
				entity = mock([FUEntity class]);
				[given([entity isKindOfClass:[FUEntity class]]) willReturnBool:YES];
				
				target = [FUTestObject new];
				[given([entity transform]) willReturn:target];
				
				tween = FUMoveTo(3.0, entity, GLKVector2Make(2.0f, 3.0f));
			});
			
			it(@"has the correct duration", ^{
				expect([tween duration]).to.equal(3.0);
			});
			
			context(@"setting the normalized time to 1.0f", ^{
				it(@"sets the position of the target to the final position", ^{
					[tween setNormalizedTime:1.0f];
					expect(FUVector2AreClose([target position], GLKVector2Make(2.0f, 3.0f))).to.beTruthy();
				});
			});
		});
	});
	
	context(@"the FUMoveBy function", ^{
		context(@"initializing with a nil target", ^{
			it(@"throws an exception", ^{
				assertThrows(FUMoveBy(0.0, nil, GLKVector2One), NSInvalidArgumentException, FUTargetNilMessage);
			});
		});
		
		context(@"initialized with a target with a position property", ^{
			__block FUTestObject* target;
			__block FUTweenAction* tween;
			
			beforeEach(^{
				target = [FUTestObject new];
				tween = FUMoveBy(2.0, target, GLKVector2Make(2.0f, 3.0f));
			});
			
			it(@"has the correct duration", ^{
				expect([tween duration]).to.equal(2.0);
			});
			
			context(@"set the position of the target to (1.0f, 0.0f)", ^{
				beforeEach(^{
					[target setPosition:GLKVector2Make(1.0f, 0.0f)];
				});
				
				context(@"set a normalized time of 0.5f", ^{
					beforeEach(^{
						[tween setNormalizedTime:0.5f];
					});
					
					it(@"sets the position half-way through", ^{
						expect(FUVector2AreClose([target position], GLKVector2Make(2.0f, 1.5f))).to.beTruthy();
					});
					
					context(@"setting a normalized time of 0.0f", ^{
						it(@"sets the value back to the start position", ^{
							[tween setNormalizedTime:0.0f];
							expect(FUVector2AreClose([target position], GLKVector2Make(1.0f, 0.0f))).to.beTruthy();
						});
					});
				});
				
				context(@"created a copy of the tween", ^{
					__block FUTweenAction* tweenCopy;
					
					beforeEach(^{
						tweenCopy = [tween copy];
					});
					
					context(@"setting a normalized time of 0.0f", ^{
						it(@"sets the position back to the start position", ^{
							[tweenCopy setNormalizedTime:0.0f];
							expect(FUVector2AreClose([target position], GLKVector2Make(1.0f, 0.0f))).to.beTruthy();
						});
					});
				});
				
				context(@"setting a normalized time of 1.0f", ^{
					it(@"sets the position to the end position", ^{
						[tween setNormalizedTime:1.0f];
						expect(FUVector2AreClose([target position], GLKVector2Make(3.0f, 3.0f))).to.beTruthy();
					});
				});
				
				context(@"setting a normalized time of -0.5f", ^{
					it(@"sets the position half-way before the start position", ^{
						[tween setNormalizedTime:-0.5f];
						expect(FUVector2AreClose([target position], GLKVector2Make(0.0f, -1.5f))).to.beTruthy();
					});
				});
				
				context(@"setting a normalized time of 1.5f", ^{
					it(@"sets the position half-way after the end position", ^{
						[tween setNormalizedTime:1.5f];
						expect(FUVector2AreClose([target position], GLKVector2Make(4.0f, 4.5f))).to.beTruthy();
					});
				});
			});
		});
		
		context(@"initializing with an entity", ^{
			__block FUEntity* entity;
			__block FUTestObject* target;
			__block FUTweenAction* tween;
			
			beforeEach(^{
				entity = mock([FUEntity class]);
				[given([entity isKindOfClass:[FUEntity class]]) willReturnBool:YES];
				
				target = [FUTestObject new];
				[given([entity transform]) willReturn:target];
				
				tween = FUMoveBy(3.0, entity, GLKVector2Make(2.0f, 3.0f));
			});
			
			it(@"has the correct duration", ^{
				expect([tween duration]).to.equal(3.0);
			});
			
			context(@"setting the normalized time to 1.0f", ^{
				it(@"sets the position of the target to the final position", ^{
					[tween setNormalizedTime:1.0f];
					expect(FUVector2AreClose([target position], GLKVector2Make(2.0f, 3.0f))).to.beTruthy();
				});
			});
		});
	});
	
	context(@"FURotateTo function", ^{
		context(@"initialized with an FUEntity target", ^{
			__block FUEntity* entity;
			__block FUTransform* transform;
			__block FUTweenAction* tween;
			
			beforeEach(^{
				entity = mock([FUEntity class]);
				transform = mock([FUTransform class]);
				[given([entity isKindOfClass:[FUEntity class]]) willReturnBool:YES];
				[given([entity transform]) willReturn:transform];
				[given([transform valueForKey:@"rotation"]) willReturn:[NSNumber numberWithFloat:M_PI]];
				tween = FURotateTo(2.0, entity, 2*M_PI);
			});
			
			it(@"has a duration of 2.0", ^{
				expect([tween duration]).to.equal(2.0);
			});
			
			context(@"setting a normalized time of 1.0f", ^{
				it(@"sets the rotation to 2*M_PI on the transform", ^{
					[tween setNormalizedTime:1.0f];
					[verify(transform) setValue:HC_closeTo(2*M_PI, 2*M_PI*FLT_EPSILON) forKey:@"rotation"];
				});
			});
		});
		
		context(@"initialized with an target with a rotation key", ^{
			__block FUTransform* target;
			__block FUTweenAction* tween;
			
			beforeEach(^{
				target = mock([FUTransform class]);
				[given([target valueForKey:@"rotation"]) willReturn:[NSNumber numberWithFloat:M_PI]];
				tween = FURotateTo(2.0, target, 2*M_PI);
			});
			
			it(@"has a duration of 2.0", ^{
				expect([tween duration]).to.equal(2.0);
			});
			
			context(@"setting a normalized time of 1.0f", ^{
				it(@"sets the rotation to 2*M_PI", ^{
					[tween setNormalizedTime:1.0f];
					[verify(target) setValue:HC_closeTo(2*M_PI, 2*M_PI*FLT_EPSILON) forKey:@"rotation"];
				});
			});
		});
	});
	
	context(@"FURotateBy function", ^{
		context(@"initialized with an FUEntity target", ^{
			__block FUEntity* entity;
			__block FUTransform* transform;
			__block FUTweenAction* tween;
			
			beforeEach(^{
				entity = mock([FUEntity class]);
				transform = mock([FUTransform class]);
				[given([entity isKindOfClass:[FUEntity class]]) willReturnBool:YES];
				[given([entity transform]) willReturn:transform];
				[given([transform valueForKey:@"rotation"]) willReturn:[NSNumber numberWithFloat:M_PI]];
				tween = FURotateBy(2.0, entity, M_PI);
			});
			
			it(@"has a duration of 2.0", ^{
				expect([tween duration]).to.equal(2.0);
			});
			
			context(@"setting a normalized time of 1.0f", ^{
				it(@"sets the rotation to 2*M_PI on the transform", ^{
					[tween setNormalizedTime:1.0f];
					[verify(transform) setValue:HC_closeTo(2*M_PI, 2*M_PI*FLT_EPSILON) forKey:@"rotation"];
				});
			});
		});
		
		context(@"initialized with on target with a rotation key", ^{
			__block FUTransform* target;
			__block FUTweenAction* tween;
			
			beforeEach(^{
				target = mock([FUTransform class]);
				[given([target valueForKey:@"rotation"]) willReturn:[NSNumber numberWithFloat:M_PI]];
				tween = FURotateBy(2.0, target, M_PI);
			});
			
			it(@"has a duration of 2.0", ^{
				expect([tween duration]).to.equal(2.0);
			});
			
			context(@"setting a normalized time of 1.0f", ^{
				it(@"sets the rotation to 2*M_PI", ^{
					[tween setNormalizedTime:1.0f];
					[verify(target) setValue:HC_closeTo(2*M_PI, 2*M_PI*FLT_EPSILON) forKey:@"rotation"];
				});
			});
		});
	});
	
	context(@"the FUScaleTo function", ^{
		context(@"initializing with a nil target", ^{
			it(@"throws an exception", ^{
				assertThrows(FUScaleTo(0.0, nil, GLKVector2One), NSInvalidArgumentException, FUTargetNilMessage);
			});
		});
		
		context(@"initialized with a target with a scale property", ^{
			__block FUTestObject* target;
			__block FUTweenAction* tween;
			
			beforeEach(^{
				target = [FUTestObject new];
				tween = FUScaleTo(2.0, target, GLKVector2Make(2.0f, 3.0f));
			});
			
			it(@"has the correct duration", ^{
				expect([tween duration]).to.equal(2.0);
			});
			
			context(@"set the scale of the target to (1.0f, 0.0f)", ^{
				beforeEach(^{
					[target setScale:GLKVector2Make(1.0f, 0.0f)];
				});
				
				context(@"set a normalized time of 0.5f", ^{
					beforeEach(^{
						[tween setNormalizedTime:0.5f];
					});
					
					it(@"sets the scale half-way through", ^{
						expect(FUVector2AreClose([target scale], GLKVector2Make(1.5f, 1.5f))).to.beTruthy();
					});
					
					context(@"setting a normalized time of 0.0f", ^{
						it(@"sets the scale back to the start scale", ^{
							[tween setNormalizedTime:0.0f];
							expect(FUVector2AreClose([target scale], GLKVector2Make(1.0f, 0.0f))).to.beTruthy();
						});
					});
				});
				
				context(@"created a copy of the tween", ^{
					__block FUTweenAction* tweenCopy;
					
					beforeEach(^{
						tweenCopy = [tween copy];
					});
					
					context(@"setting a normalized time of 0.0f", ^{
						it(@"sets the scale back to the start scale", ^{
							[tweenCopy setNormalizedTime:0.0f];
							expect(FUVector2AreClose([target scale], GLKVector2Make(1.0f, 0.0f))).to.beTruthy();
						});
					});
				});
				
				context(@"setting a normalized time of 1.0f", ^{
					it(@"sets the scale to the end scale", ^{
						[tween setNormalizedTime:1.0f];
						expect(FUVector2AreClose([target scale], GLKVector2Make(2.0f, 3.0f))).to.beTruthy();
					});
				});
				
				context(@"setting a normalized time of -0.5f", ^{
					it(@"sets the scale half-way before the start scale", ^{
						[tween setNormalizedTime:-0.5f];
						expect(FUVector2AreClose([target scale], GLKVector2Make(0.5f, -1.5f))).to.beTruthy();
					});
				});
				
				context(@"setting a normalized time of 1.5f", ^{
					it(@"sets the scale half-way after the end scale", ^{
						[tween setNormalizedTime:1.5f];
						expect(FUVector2AreClose([target scale], GLKVector2Make(2.5f, 4.5f))).to.beTruthy();
					});
				});
			});
		});
		
		context(@"initializing with an entity", ^{
			__block FUEntity* entity;
			__block FUTestObject* target;
			__block FUTweenAction* tween;
			
			beforeEach(^{
				entity = mock([FUEntity class]);
				[given([entity isKindOfClass:[FUEntity class]]) willReturnBool:YES];
				
				target = [FUTestObject new];
				[given([entity transform]) willReturn:target];
				
				tween = FUScaleTo(3.0, entity, GLKVector2Make(2.0f, 3.0f));
			});
			
			it(@"has the correct duration", ^{
				expect([tween duration]).to.equal(3.0);
			});
			
			context(@"setting the normalized time to 1.0f", ^{
				it(@"sets the scale of the target to the final scale", ^{
					[tween setNormalizedTime:1.0f];
					expect(FUVector2AreClose([target scale], GLKVector2Make(2.0f, 3.0f))).to.beTruthy();
				});
			});
		});
	});
	
	context(@"the FUScaleBy function", ^{
		context(@"initializing with a nil target", ^{
			it(@"throws an exception", ^{
				assertThrows(FUScaleBy(0.0, nil, GLKVector2One), NSInvalidArgumentException, FUTargetNilMessage);
			});
		});
	
		context(@"initialized with a target with a scale property", ^{
			__block FUTestObject* target;
			__block FUTweenAction* tween;
		
			beforeEach(^{
				target = [FUTestObject new];
				tween = FUScaleBy(2.0, target, GLKVector2Make(2.0f, 3.0f));
			});
		
			it(@"has the correct duration", ^{
				expect([tween duration]).to.equal(2.0);
			});
		
			context(@"set the scale of the target to (1.0f, 0.0f)", ^{
				beforeEach(^{
					[target setScale:GLKVector2Make(1.0f, 0.0f)];
				});
			
				context(@"set a normalized time of 0.5f", ^{
					beforeEach(^{
						[tween setNormalizedTime:0.5f];
					});
				
					it(@"sets the scale half-way through", ^{
						expect(FUVector2AreClose([target scale], GLKVector2Make(1.5f, 0.0f))).to.beTruthy();
					});
				
					context(@"setting a normalized time of 0.0f", ^{
						it(@"sets the value back to the start scale", ^{
							[tween setNormalizedTime:0.0f];
							expect(FUVector2AreClose([target scale], GLKVector2Make(1.0f, 0.0f))).to.beTruthy();
						});
					});
				});
			
				context(@"created a copy of the tween", ^{
					__block FUTweenAction* tweenCopy;
				
					beforeEach(^{
						tweenCopy = [tween copy];
					});
				
					context(@"setting a normalized time of 0.0f", ^{
						it(@"sets the scale back to the start scale", ^{
							[tweenCopy setNormalizedTime:0.0f];
							expect(FUVector2AreClose([target scale], GLKVector2Make(1.0f, 0.0f))).to.beTruthy();
						});
					});
				});
			
				context(@"setting a normalized time of 1.0f", ^{
					it(@"sets the scale to the end scale", ^{
						[tween setNormalizedTime:1.0f];
						expect(FUVector2AreClose([target scale], GLKVector2Make(2.0f, 0.0f))).to.beTruthy();
					});
				});
			
				context(@"setting a normalized time of -0.5f", ^{
					it(@"sets the scale half-way before the start scale", ^{
						[tween setNormalizedTime:-0.5f];
						expect(FUVector2AreClose([target scale], GLKVector2Make(0.5f, 0.0f))).to.beTruthy();
					});
				});
			
				context(@"setting a normalized time of 1.5f", ^{
					it(@"sets the scale half-way after the end scale", ^{
						[tween setNormalizedTime:1.5f];
						expect(FUVector2AreClose([target scale], GLKVector2Make(2.5f, 0.0f))).to.beTruthy();
					});
				});
			});
		});
	
		context(@"initializing with an entity", ^{
			__block FUEntity* entity;
			__block FUTestObject* target;
			__block FUTweenAction* tween;
		
			beforeEach(^{
				entity = mock([FUEntity class]);
				[given([entity isKindOfClass:[FUEntity class]]) willReturnBool:YES];
			
				target = [FUTestObject new];
				[given([entity transform]) willReturn:target];
			
				tween = FUScaleBy(3.0, entity, GLKVector2Make(2.0f, 3.0f));
			});
		
			it(@"has the correct duration", ^{
				expect([tween duration]).to.equal(3.0);
			});
		
			context(@"setting the normalized time to 1.0f", ^{
				it(@"sets the scale of the target to the final scale", ^{
					[tween setNormalizedTime:1.0f];
					expect(FUVector2AreClose([target scale], GLKVector2Make(0.0f, 0.0f))).to.beTruthy();
				});
			});
		});
	});

	context(@"the FUTintTo function", ^{
		context(@"initializing with a nil target", ^{
			it(@"throws an exception", ^{
				assertThrows(FUTintTo(0.0, nil, FUColorBlue), NSInvalidArgumentException, FUTargetNilMessage);
			});
		});
	
		context(@"initialized with a target with a color property", ^{
			__block FUTestObject* target;
			__block FUTweenAction* tween;
		
			beforeEach(^{
				target = [FUTestObject new];
				tween = FUTintTo(2.0, target, GLKVector4Make(0.5f, -0.2f, 1.0f, 0.2f));
			});
		
			it(@"has the correct duration", ^{
				expect([tween duration]).to.equal(2.0);
			});
		
			context(@"set the color of the target to (1.0f, 0.0f)", ^{
				beforeEach(^{
					[target setTint:GLKVector4Make(0.2f, 0.1f, 0.0f, 0.8f)];
				});
			
				context(@"set a normalized time of 0.5f", ^{
					beforeEach(^{
						[tween setNormalizedTime:0.5f];
					});
				
					it(@"sets the tint half-way through", ^{
						expect(FUVector4AreClose([target tint], GLKVector4Make(0.35f, -0.05f, 0.5f, 0.5f))).to.beTruthy();
					});
				
					context(@"setting a normalized time of 0.0f", ^{
						it(@"sets the tint back to the start color", ^{
							[tween setNormalizedTime:0.0f];
							expect(FUVector4AreClose([target tint], GLKVector4Make(0.2f, 0.1f, 0.0f, 0.8f))).to.beTruthy();
						});
					});
				});
			
				context(@"created a copy of the tween", ^{
					__block FUTweenAction* tweenCopy;
				
					beforeEach(^{
						tweenCopy = [tween copy];
					});
				
					context(@"setting a normalized time of 0.0f", ^{
						it(@"sets the tint back to the start color", ^{
							[tweenCopy setNormalizedTime:0.0f];
							expect(FUVector4AreClose([target tint], GLKVector4Make(0.2f, 0.1f, 0.0f, 0.8f))).to.beTruthy();
						});
					});
				});
			
				context(@"setting a normalized time of 1.0f", ^{
					it(@"sets the tint to the end color", ^{
						[tween setNormalizedTime:1.0f];
						expect(FUVector4AreClose([target tint], GLKVector4Make(0.5f, -0.2f, 1.0f, 0.2f))).to.beTruthy();
					});
				});
			
				context(@"setting a normalized time of -0.5f", ^{
					it(@"sets the tint half-way before the start color", ^{
						[tween setNormalizedTime:-0.5f];
						expect(FUVector4AreClose([target tint], GLKVector4Make(0.05f, 0.25f, -0.5f, 1.1f))).to.beTruthy();
					});
				});
			
				context(@"setting a normalized time of 1.5f", ^{
					it(@"sets the tint half-way after the end color", ^{
						[tween setNormalizedTime:1.5f];
						expect(FUVector4AreClose([target tint], GLKVector4Make(0.65f, -0.35f, 1.5f, -0.1f))).to.beTruthy();
					});
				});
			});
		});
	
		context(@"initializing with an entity", ^{
			__block FUEntity* entity;
			__block FUTestObject* target;
			__block FUTweenAction* tween;
		
			beforeEach(^{
				entity = mock([FUEntity class]);
				[given([entity isKindOfClass:[FUEntity class]]) willReturnBool:YES];
			
				target = [FUTestObject new];
				[given([entity renderer]) willReturn:target];
			
				tween = FUTintTo(3.0, entity, GLKVector4Make(0.5f, -0.2f, 1.0f, 0.2f));
			});
		
			it(@"has the correct duration", ^{
				expect([tween duration]).to.equal(3.0);
			});
		
			context(@"setting the normalized time to 1.0f", ^{
				it(@"sets the tint of the target to the final color", ^{
					[tween setNormalizedTime:1.0f];
					expect(FUVector4AreClose([target tint], GLKVector4Make(0.5f, -0.2f, 1.0f, 0.2f))).to.beTruthy();
				});
			});
		});
	});
	
	context(@"the FUTintBy function", ^{
		context(@"initializing with a nil target", ^{
			it(@"throws an exception", ^{
				assertThrows(FUTintBy(0.0, nil, FUColorBlue), NSInvalidArgumentException, FUTargetNilMessage);
			});
		});
		
		context(@"initialized with a target with a color property", ^{
			__block FUTestObject* target;
			__block FUTweenAction* tween;
			
			beforeEach(^{
				target = [FUTestObject new];
				tween = FUTintBy(2.0, target, GLKVector4Make(0.5f, -0.2f, 1.0f, 0.2f));
			});
			
			it(@"has the correct duration", ^{
				expect([tween duration]).to.equal(2.0);
			});
			
			context(@"set the color of the target to (1.0f, 0.0f)", ^{
				beforeEach(^{
					[target setTint:GLKVector4Make(0.2f, 0.1f, 0.0f, 0.8f)];
				});
				
				context(@"set a normalized time of 0.5f", ^{
					beforeEach(^{
						[tween setNormalizedTime:0.5f];
					});
					
					it(@"sets the tint half-way through", ^{
						expect(FUVector4AreClose([target tint], GLKVector4Make(0.15f, 0.04f, 0.0f, 0.48f))).to.beTruthy();
					});
					
					context(@"setting a normalized time of 0.0f", ^{
						it(@"sets the tint back to the start color", ^{
							[tween setNormalizedTime:0.0f];
							expect(FUVector4AreClose([target tint], GLKVector4Make(0.2f, 0.1f, 0.0f, 0.8f))).to.beTruthy();
						});
					});
				});
				
				context(@"created a copy of the tween", ^{
					__block FUTweenAction* tweenCopy;
					
					beforeEach(^{
						tweenCopy = [tween copy];
					});
					
					context(@"setting a normalized time of 0.0f", ^{
						it(@"sets the tint back to the start color", ^{
							[tweenCopy setNormalizedTime:0.0f];
							expect(FUVector4AreClose([target tint], GLKVector4Make(0.2f, 0.1f, 0.0f, 0.8f))).to.beTruthy();
						});
					});
				});
				
				context(@"setting a normalized time of 1.0f", ^{
					it(@"sets the tint to the end color", ^{
						[tween setNormalizedTime:1.0f];
						expect(FUVector4AreClose([target tint], GLKVector4Make(0.1f, -0.02f, 0.0f, 0.16f))).to.beTruthy();
					});
				});
				
				context(@"setting a normalized time of -0.5f", ^{
					it(@"sets the tint half-way before the start color", ^{
						[tween setNormalizedTime:-0.5f];
						expect(FUVector4AreClose([target tint], GLKVector4Make(0.25f, 0.16f, 0.0f, 1.12f))).to.beTruthy();
					});
				});
				
				context(@"setting a normalized time of 1.5f", ^{
					it(@"sets the tint half-way after the end color", ^{
						[tween setNormalizedTime:1.5f];
						expect(FUVector4AreClose([target tint], GLKVector4Make(0.05f, -0.08f, 0.0f, -0.16f))).to.beTruthy();
					});
				});
			});
		});
		
		context(@"initializing with an entity", ^{
			__block FUEntity* entity;
			__block FUTestObject* target;
			__block FUTweenAction* tween;
			
			beforeEach(^{
				entity = mock([FUEntity class]);
				[given([entity isKindOfClass:[FUEntity class]]) willReturnBool:YES];
				
				target = [FUTestObject new];
				[given([entity renderer]) willReturn:target];
				
				tween = FUTintBy(3.0, entity, GLKVector4Make(0.5f, -0.2f, 1.0f, 0.2f));
			});
			
			it(@"has the correct duration", ^{
				expect([tween duration]).to.equal(3.0);
			});
			
			context(@"setting the normalized time to 1.0f", ^{
				it(@"sets the tint of the target to the final color", ^{
					[tween setNormalizedTime:1.0f];
					expect(FUVector4AreClose([target tint], GLKVector4Make(0.0f, 0.0f, 0.0f, 0.0f))).to.beTruthy();
				});
			});
		});
	});
});

SPEC_END


@implementation FUTestObject
@synthesize doubleValue = _doubleValue;
@synthesize position = _position;
@synthesize scale = _scale;
@synthesize tint = _tint;
@end
