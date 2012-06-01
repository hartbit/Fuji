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
static NSString* const FUObjectNilMessage = @"Expected object to not be nil";
static NSString* const FUKeyNilMessage = @"Expected key to not be nil or empty";
static NSString* const FUKeyImmutableMessage = @"Expected 'key=%@' on 'object=%@' to be mutable";
static NSString* const FUKeyNumericalMessage = @"Expected 'key=%@' on 'object=%@' to be of a numerical type";
static NSString* const FUKeyVector2Message = @"Expected 'key=%@' on 'object=%@' to be of type GLKVector2";
static NSString* const FUValueNilMessage = @"Expected value to not be nil";
static NSString* const FUAddendNilMessage = @"Expected addend to not be nil";
static NSString* const FUFactorNilMessage = @"Expected factor to not be nil";


@interface FUDoubleObject : NSObject
@property (nonatomic) double doubleValue;
@end

@interface FUReadonlyVector2 : NSObject
@property (nonatomic, readonly) GLKVector2 vectorValue;
@end

@interface FUVector2 : NSObject
@property (nonatomic) GLKVector2 vectorValue;
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
		context(@"initializing with a nil object", ^{
			it(@"throws an exception", ^{
				assertThrows(FUTweenTo(0.0, nil, @"key", [NSNumber numberWithDouble:1.0]), NSInvalidArgumentException, FUObjectNilMessage);
			});
		});
		
		context(@"initializing with a nil key", ^{
			it(@"throws an exception", ^{
				assertThrows(FUTweenTo(0.0, [NSString string], nil, [NSNumber numberWithDouble:1.0]), NSInvalidArgumentException, FUKeyNilMessage);
			});
		});
		
		context(@"initializing with an undefined key", ^{
			it(@"throws an exception", ^{
				id object = [NSString string];
				NSString* key = @"count";
				STAssertThrows(FUTweenTo(0.0, object, key, [NSNumber numberWithDouble:1.0]), nil);
			});
		});
		
		context(@"initializing with a immutable key", ^{
			it(@"throws an exception", ^{
				id object = [NSString string];
				NSString* key = @"length";
				assertThrows(FUTweenTo(0.0, object, key, [NSNumber numberWithDouble:1.0]), NSInvalidArgumentException, FUKeyImmutableMessage, key, object);
			});
		});
		
		context(@"initializing with a non-numerical key", ^{
			it(@"throws an exception", ^{
				id object = [NSMutableURLRequest requestWithURL:nil];
				NSString* key = @"URL";
				assertThrows(FUTweenTo(0.0, object, key, [NSNumber numberWithDouble:1.0]), NSInvalidArgumentException, FUKeyNumericalMessage, key, object);
			});
		});
		
		context(@"initializing with a nil value", ^{
			it(@"throws an exception", ^{
				assertThrows(FUTweenTo(0.0, [NSMutableData data], @"length", nil), NSInvalidArgumentException, FUValueNilMessage);
			});
		});
		
		context(@"initialized with valid arguments", ^{
			__block FUDoubleObject* object;
			__block FUTweenAction* tween;
			
			beforeEach(^{
				object = [FUDoubleObject new];
				tween = FUTweenTo(1.0, object, @"doubleValue", [NSNumber numberWithDouble:4.0]);
			});
			
			it(@"is not nil", ^{
				expect(tween).toNot.beNil();
			});
			
			it(@"has the correct duration", ^{
				expect([tween duration]).to.equal(1.0);
			});
			
			context(@"set the value on the object to 2.0", ^{
				beforeEach(^{
					[object setDoubleValue:2.0];
				});
				
				context(@"set a normalized time of 0.5f", ^{
					beforeEach(^{
						[tween setNormalizedTime:0.5f];
					});
					
					it(@"sets the value half-way through", ^{
						expect([object doubleValue]).to.equal(3.0);
					});
					
					context(@"setting a normalized time of 0.0f", ^{
						it(@"sets the value back to the start value", ^{
							[tween setNormalizedTime:0.0f];
							expect([object doubleValue]).to.equal(2.0);
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
								expect([object doubleValue]).to.equal(2.0);
							});
						});
					});
				});
				
				context(@"setting a normalized time of 1.0f", ^{
					it(@"sets the value to the toValue", ^{
						[tween setNormalizedTime:1.0f];
						expect([object doubleValue]).to.equal(4.0);
					});
				});
				
				context(@"setting a normalized time of -0.5f", ^{
					it(@"sets the value half-way before the start value", ^{
						[tween setNormalizedTime:-0.5f];
						expect([object doubleValue]).to.equal(1.0);
					});
				});
				
				context(@"setting a setNormalizedTime of 1.5f", ^{
					it(@"sets the value half-way after the toValue", ^{
						[tween setNormalizedTime:1.5f];
						expect([object doubleValue]).to.equal(5.0);
					});
				});
			});
		});
	});
	
	context(@"the FUTweenSum method", ^{
		context(@"initializing with a nil object", ^{
			it(@"throws an exception", ^{
				assertThrows(FUTweenSum(0.0, nil, @"key", [NSNumber numberWithDouble:1.0]), NSInvalidArgumentException, FUObjectNilMessage);
			});
		});
		
		context(@"initializing with a nil key", ^{
			it(@"throws an exception", ^{
				assertThrows(FUTweenSum(0.0, [NSString string], nil, [NSNumber numberWithDouble:1.0]), NSInvalidArgumentException, FUKeyNilMessage);
			});
		});
		
		context(@"initializing with an undefined key", ^{
			it(@"throws an exception", ^{
				id object = [NSString string];
				NSString* key = @"count";
				STAssertThrows(FUTweenSum(0.0, object, key, [NSNumber numberWithDouble:1.0]), nil);
			});
		});
		
		context(@"initializing with a immutable key", ^{
			it(@"throws an exception", ^{
				id object = [NSString string];
				NSString* key = @"length";
				assertThrows(FUTweenSum(0.0, object, key, [NSNumber numberWithDouble:1.0]), NSInvalidArgumentException, FUKeyImmutableMessage, key, object);
			});
		});
		
		context(@"initializing with a non-numerical key", ^{
			it(@"throws an exception", ^{
				id object = [NSMutableURLRequest requestWithURL:nil];
				NSString* key = @"URL";
				assertThrows(FUTweenSum(0.0, object, key, [NSNumber numberWithDouble:1.0]), NSInvalidArgumentException, FUKeyNumericalMessage, key, object);
			});
		});
		
		context(@"initializing with a nil addend", ^{
			it(@"throws an exception", ^{
				assertThrows(FUTweenSum(0.0, [NSMutableData data], @"length", nil), NSInvalidArgumentException, FUAddendNilMessage);
			});
		});

		context(@"initialized with valid arguments", ^{
			__block FUDoubleObject* object;
			__block FUTweenAction* tween;
			
			beforeEach(^{
				object = [FUDoubleObject new];
				tween = FUTweenSum(1.0, object, @"doubleValue", [NSNumber numberWithDouble:2.0]);
			});
			
			it(@"is not nil", ^{
				expect(tween).toNot.beNil();
			});
			
			it(@"has the correct duration", ^{
				expect([tween duration]).to.equal(1.0);
			});
			
			context(@"set the value on the object to 2.0", ^{
				beforeEach(^{
					[object setDoubleValue:2.0];
				});
				
				context(@"set a normalized time of 0.5f", ^{
					beforeEach(^{
						[tween setNormalizedTime:0.5f];
					});
					
					it(@"sets the value half-way through", ^{
						expect([object doubleValue]).to.equal(3.0);
					});
					
					context(@"setting a normalized time of 0.0f", ^{
						it(@"sets the value back to the start value", ^{
							[tween setNormalizedTime:0.0f];
							expect([object doubleValue]).to.equal(2.0);
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
							expect([object doubleValue]).to.equal(3.0);
						});
					});
				});
				
				context(@"setting a normalized time of 1.0f", ^{
					it(@"sets the value to the end value", ^{
						[tween setNormalizedTime:1.0f];
						expect([object doubleValue]).to.equal(4.0);
					});
				});
				
				context(@"setting a factor of -0.5f", ^{
					it(@"sets the value half-way before the start value", ^{
						[tween setNormalizedTime:-0.5f];
						expect([object doubleValue]).to.equal(1.0);
					});
				});
				
				context(@"setting a factor of 1.5f", ^{
					it(@"sets the value half-way after the toValue", ^{
						[tween setNormalizedTime:1.5f];
						expect([object doubleValue]).to.equal(5.0);
					});
				});
			});
		});
	});
	
	context(@"the FUTweenProduct method", ^{
		context(@"initializing with a nil object", ^{
			it(@"throws an exception", ^{
				assertThrows(FUTweenProduct(0.0, nil, @"key", [NSNumber numberWithDouble:1.0]), NSInvalidArgumentException, FUObjectNilMessage);
			});
		});
		
		context(@"initializing with a nil key", ^{
			it(@"throws an exception", ^{
				assertThrows(FUTweenProduct(0.0, [NSString string], nil, [NSNumber numberWithDouble:1.0]), NSInvalidArgumentException, FUKeyNilMessage);
			});
		});
		
		context(@"initializing with an undefined key", ^{
			it(@"throws an exception", ^{
				id object = [NSString string];
				NSString* key = @"count";
				STAssertThrows(FUTweenProduct(0.0, object, key, [NSNumber numberWithDouble:1.0]), nil);
			});
		});
		
		context(@"initializing with a immutable key", ^{
			it(@"throws an exception", ^{
				id object = [NSString string];
				NSString* key = @"length";
				assertThrows(FUTweenProduct(0.0, object, key, [NSNumber numberWithDouble:1.0]), NSInvalidArgumentException, FUKeyImmutableMessage, key, object);
			});
		});
		
		context(@"initializing with a non-numerical key", ^{
			it(@"throws an exception", ^{
				id object = [NSMutableURLRequest requestWithURL:nil];
				NSString* key = @"URL";
				assertThrows(FUTweenProduct(0.0, object, key, [NSNumber numberWithDouble:1.0]), NSInvalidArgumentException, FUKeyNumericalMessage, key, object);
			});
		});
		
		context(@"initializing with a nil factor", ^{
			it(@"throws an exception", ^{
				assertThrows(FUTweenProduct(0.0, [NSMutableData data], @"length", nil), NSInvalidArgumentException, FUFactorNilMessage);
			});
		});
		
		context(@"initialized with valid arguments", ^{
			__block FUDoubleObject* object;
			__block FUTweenAction* tween;
			
			beforeEach(^{
				object = [FUDoubleObject new];
				tween = FUTweenProduct(1.0, object, @"doubleValue", [NSNumber numberWithDouble:2.0]);
			});
			
			it(@"is not nil", ^{
				expect(tween).toNot.beNil();
			});
			
			it(@"has the correct duration", ^{
				expect([tween duration]).to.equal(1.0);
			});
			
			context(@"set the value on the object to 3.0", ^{
				beforeEach(^{
					[object setDoubleValue:3.0];
				});
				
				context(@"set a normalized time of 0.5f", ^{
					beforeEach(^{
						[tween setNormalizedTime:0.5f];
					});
					
					it(@"sets the value half-way through", ^{
						expect([object doubleValue]).to.equal(4.5);
					});
					
					context(@"setting a normalized time of 0.0f", ^{
						it(@"sets the value back to the start value", ^{
							[tween setNormalizedTime:0.0f];
							expect([object doubleValue]).to.equal(3.0);
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
							expect([object doubleValue]).to.equal(4.5);
						});
					});
				});
				
				context(@"setting a normalized time of 1.0f", ^{
					it(@"sets the value to the end value", ^{
						[tween setNormalizedTime:1.0f];
						expect([object doubleValue]).to.equal(6.0);
					});
				});
				
				context(@"setting a factor of -0.5f", ^{
					it(@"sets the value half-way before the start value", ^{
						[tween setNormalizedTime:-0.5f];
						expect([object doubleValue]).to.equal(1.5);
					});
				});
				
				context(@"setting a factor of 1.5f", ^{
					it(@"sets the value half-way after the toValue", ^{
						[tween setNormalizedTime:1.5f];
						expect([object doubleValue]).to.equal(7.5);
					});
				});
			});
		});
	});
	
	context(@"FURotateTo function", ^{
		context(@"initialized with an FUEntity object", ^{
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
		
		context(@"initialized with an object with a rotation key", ^{
			__block FUTransform* object;
			__block FUTweenAction* tween;
			
			beforeEach(^{
				object = mock([FUTransform class]);
				[given([object valueForKey:@"rotation"]) willReturn:[NSNumber numberWithFloat:M_PI]];
				tween = FURotateTo(2.0, object, 2*M_PI);
			});
			
			it(@"has a duration of 2.0", ^{
				expect([tween duration]).to.equal(2.0);
			});
			
			context(@"setting a normalized time of 1.0f", ^{
				it(@"sets the rotation to 2*M_PI", ^{
					[tween setNormalizedTime:1.0f];
					[verify(object) setValue:HC_closeTo(2*M_PI, 2*M_PI*FLT_EPSILON) forKey:@"rotation"];
				});
			});
		});
	});
	
	context(@"FURotateBy function", ^{
		context(@"initialized with an FUEntity object", ^{
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
		
		context(@"initialized with on object with a rotation key", ^{
			__block FUTransform* object;
			__block FUTweenAction* tween;
			
			beforeEach(^{
				object = mock([FUTransform class]);
				[given([object valueForKey:@"rotation"]) willReturn:[NSNumber numberWithFloat:M_PI]];
				tween = FURotateBy(2.0, object, M_PI);
			});
			
			it(@"has a duration of 2.0", ^{
				expect([tween duration]).to.equal(2.0);
			});
			
			context(@"setting a normalized time of 1.0f", ^{
				it(@"sets the rotation to 2*M_PI", ^{
					[tween setNormalizedTime:1.0f];
					[verify(object) setValue:HC_closeTo(2*M_PI, 2*M_PI*FLT_EPSILON) forKey:@"rotation"];
				});
			});
		});
	});
});

SPEC_END


@implementation FUDoubleObject
@synthesize doubleValue = _doubleValue;
@end

@implementation FUReadonlyVector2
@synthesize vectorValue = _vectorValue;
@end

@implementation FUVector2
@synthesize vectorValue = _vectorValue;
@end