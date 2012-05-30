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
static NSString* const FUPropertyNilMessage = @"Expected property to not be nil or empty";
static NSString* const FUToValueNilMessage = @"Expected toValue to not be nil";
static NSString* const FUByValueNilMessage = @"Expected byValue to not be nil";
static NSString* const FUPropertyUndefinedMessage = @"The 'property=%@' is not defined for 'object=%@'";
static NSString* const FUPropertyReadonlyMessage = @"Expected 'property=%@' on 'object=%@' to be readwrite but was readonly";


@interface FUDoubleObject : NSObject
@property (nonatomic) double doubleValue;
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
	
	context(@"initializing via the function with a block", ^{
		it(@"returns a FUTweenAction", ^{
			expect(FUTween(2.0, ^(float t) {})).to.beKindOf([FUTweenAction class]);
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
		
		it(@"is not nil", ^{
			expect(action).toNot.beNil();
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
				
				it(@"is not nil", ^{
					expect(actionCopy).toNot.beNil();
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
	
	context(@"the FUTweenTo method", ^{
		context(@"initializing with a nil target", ^{
			it(@"throws an exception", ^{
				assertThrows(FUTweenTo(0.0, nil, @"property", [NSNumber numberWithDouble:1.0]), NSInvalidArgumentException, FUTargetNilMessage);
			});
		});
		
		context(@"initializing with a nil property", ^{
			it(@"throws an exception", ^{
				assertThrows(FUTweenTo(0.0, [NSString string], nil, [NSNumber numberWithDouble:1.0]), NSInvalidArgumentException, FUPropertyNilMessage);
			});
		});
		
		context(@"initializing with a nil toValue", ^{
			it(@"throws an exception", ^{
				assertThrows(FUTweenTo(0.0, [NSMutableData data], @"length", nil), NSInvalidArgumentException, FUToValueNilMessage);
			});
		});
		
		context(@"initializing with an undefined property", ^{
			it(@"throws an exception", ^{
				id target = [NSString string];
				NSString* property = @"count";
				assertThrows(FUTweenTo(0.0, target, property, [NSNumber numberWithDouble:1.0]), NSInvalidArgumentException, FUPropertyUndefinedMessage, property, target);
			});
		});
		
		context(@"initializing with a readonly property", ^{
			it(@"throws an exception", ^{
				id target = [NSString string];
				NSString* property = @"length";
				assertThrows(FUTweenTo(0.0, target, property, [NSNumber numberWithDouble:1.0]), NSInvalidArgumentException, FUPropertyReadonlyMessage, property, target);
			});
		});
		
		context(@"initialized with valid arguments", ^{
			__block FUDoubleObject* target;
			__block FUTweenAction* tween;
			
			beforeEach(^{
				target = [FUDoubleObject new];
				tween = FUTweenTo(1.0, target, @"doubleValue", [NSNumber numberWithDouble:4.0]);
			});
			
			it(@"is not nil", ^{
				expect(tween).toNot.beNil();
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
	
	context(@"the FUTweenBy method", ^{
		context(@"initializing with a nil target", ^{
			it(@"throws an exception", ^{
				assertThrows(FUTweenBy(0.0, nil, @"property", [NSNumber numberWithDouble:1.0]), NSInvalidArgumentException, FUTargetNilMessage);
			});
		});
		
		context(@"initializing with a nil property", ^{
			it(@"throws an exception", ^{
				assertThrows(FUTweenBy(0.0, [NSString string], nil, [NSNumber numberWithDouble:1.0]), NSInvalidArgumentException, FUPropertyNilMessage);
			});
		});
		
		context(@"initializing with a nil byValue", ^{
			it(@"throws an exception", ^{
				assertThrows(FUTweenBy(0.0, [NSMutableData data], @"length", nil), NSInvalidArgumentException, FUByValueNilMessage);
			});
		});
		
		context(@"initializing with an undefined property", ^{
			it(@"throws an exception", ^{
				id target = [NSString string];
				NSString* property = @"count";
				assertThrows(FUTweenBy(0.0, target, property, [NSNumber numberWithDouble:1.0]), NSInvalidArgumentException, FUPropertyUndefinedMessage, property, target);
			});
		});
		
		context(@"initializing with a readonly property", ^{
			it(@"throws an exception", ^{
				id target = [NSString string];
				NSString* property = @"length";
				assertThrows(FUTweenBy(0.0, target, property, [NSNumber numberWithDouble:1.0]), NSInvalidArgumentException, FUPropertyReadonlyMessage, property, target);
			});
		});

		context(@"initialized with valid arguments", ^{
			__block FUDoubleObject* target;
			__block FUTweenAction* tween;
			
			beforeEach(^{
				target = [FUDoubleObject new];
				tween = FUTweenBy(1.0, target, @"doubleValue", [NSNumber numberWithDouble:2.0]);
			});
			
			it(@"is not nil", ^{
				expect(tween).toNot.beNil();
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
				
				context(@"setting a factor of -0.5f", ^{
					it(@"sets the value half-way before the start value", ^{
						[tween setNormalizedTime:-0.5f];
						expect([target doubleValue]).to.equal(1.0);
					});
				});
				
				context(@"setting a factor of 1.5f", ^{
					it(@"sets the value half-way after the toValue", ^{
						[tween setNormalizedTime:1.5f];
						expect([target doubleValue]).to.equal(5.0);
					});
				});
			});
		});
	});
	
	context(@"initialized with the FURotateTo function", ^{
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
	
	context(@"initialized with the FURotateBy function", ^{
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

SPEC_END


@implementation FUDoubleObject
@synthesize doubleValue = _doubleValue;
@end