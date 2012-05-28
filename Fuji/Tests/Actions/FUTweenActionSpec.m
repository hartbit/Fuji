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


static NSString* const FUTargetNilMessage = @"Expected target to not be nil";
static NSString* const FUPropertyNilMessage = @"Expected property to not be nil or empty";
static NSString* const FUFromValueNilMessage = @"Expected fromValue to not be nil";
static NSString* const FUToValueNilMessage = @"Expected toValue to not be nil";
static NSString* const FUByValueNilMessage = @"Expected byValue to not be nil";
static NSString* const FUPropertyUndefinedMessage = @"The 'property=%@' is not defined for 'object=%@'";
static NSString* const FUPropertyReadonlyMessage = @"Expected 'property=%@' on 'object=%@' to be readwrite but was readonly";


@interface FUDoubleObject : NSObject
@property (nonatomic) double doubleValue;
@end


#define FUTweenIsTo(prop, toValue) \
	it(@"is a FUTweenAction", ^{ \
		expect(tween).to.beKindOf([FUTweenAction class]); \
	}); \
	\
	it(@"has the correct duration", ^{ \
		expect([tween duration]).to.equal(2.0); \
	}); \
	\
	it(@"has the correct target", ^{ \
		expect([tween target]).to.beIdenticalTo(target); \
	}); \
	\
	it(@"has the correct property", ^{ \
		expect([tween property]).to.equal(prop); \
	}); \
	\
	it(@"has no fromValue", ^{ \
		expect([tween fromValue]).to.beNil(); \
	}); \
	\
	it(@"has the current toValue", ^{ \
		expect([tween toValue]).to.equal(toValue); \
	});

#define FUTweenIsFromTo(prop, fromValue, toValue) \
	it(@"is a FUTweenAction", ^{ \
		expect(tween).to.beKindOf([FUTweenAction class]); \
	}); \
	\
	it(@"has the correct duration", ^{ \
		expect([tween duration]).to.equal(2.0); \
	}); \
	\
	it(@"has the correct target", ^{ \
		expect([tween target]).to.beIdenticalTo(target); \
	}); \
	\
	it(@"has the correct property", ^{ \
		expect([tween property]).to.equal(prop); \
	}); \
	\
	it(@"has the correct fromValue", ^{ \
		expect([tween fromValue]).to.equal(fromValue); \
	}); \
	\
	it(@"has the current toValue", ^{ \
		expect([tween toValue]).to.equal(toValue); \
	});

#define FUTweenIsBy(prop) \
	it(@"is a FUTweenAction", ^{ \
		expect(tween).to.beKindOf([FUTweenAction class]); \
	}); \
	\
	it(@"has the correct duration", ^{ \
		expect([tween duration]).to.equal(2.0); \
	}); \
	\
	it(@"has the correct target", ^{ \
		expect([tween target]).to.beIdenticalTo(target); \
	}); \
	\
	it(@"has the correct property", ^{ \
		expect([tween property]).to.equal(prop); \
	}); \
	\
	it(@"has no fromValue", ^{ \
		expect([tween fromValue]).to.beNil(); \
	}); \
	\
	it(@"has no toValue", ^{ \
		expect([tween toValue]).to.beNil(); \
	});


SPEC_BEGIN(FUTweenAction)

describe(@"A tween action", ^{
	it(@"is a timed action", ^{
		expect([FUDelayAction class]).to.beSubclassOf([FUTimedAction class]);
	});
	
	context(@"initializing with a nil target", ^{
		context(@"with the toValue initialization method", ^{
			it(@"throws an exception", ^{
				assertThrows([[FUTweenAction alloc] initWithTarget:nil property:@"property" duration:0.0 toValue:[NSNumber numberWithDouble:1.0]], NSInvalidArgumentException, FUTargetNilMessage);
			});
		});
		
		context(@"with the fromValue toValue initialization method", ^{
			it(@"throws an exception", ^{
				assertThrows([[FUTweenAction alloc] initWithTarget:nil property:@"property" duration:0.0 fromValue:[NSNumber numberWithDouble:1.0] toValue:[NSNumber numberWithDouble:1.0]], NSInvalidArgumentException, FUTargetNilMessage);
			});
		});
		
		context(@"with the byValue initialization method", ^{
			it(@"throws an exception", ^{
				assertThrows([[FUTweenAction alloc] initWithTarget:nil property:@"property" duration:0.0 byValue:[NSNumber numberWithDouble:1.0]], NSInvalidArgumentException, FUTargetNilMessage);
			});
		});
	});
	
	context(@"initializing with a nil property", ^{
		context(@"with the toValue initialization method", ^{
			it(@"throws an exception", ^{
				assertThrows([[FUTweenAction alloc] initWithTarget:[NSString string] property:nil duration:0.0 toValue:[NSNumber numberWithDouble:1.0]], NSInvalidArgumentException, FUPropertyNilMessage);
			});
		});
		
		context(@"with the fromValue toValue initialization method", ^{
			it(@"throws an exception", ^{
				assertThrows([[FUTweenAction alloc] initWithTarget:[NSString string] property:nil duration:0.0 fromValue:[NSNumber numberWithDouble:1.0] toValue:[NSNumber numberWithDouble:1.0]], NSInvalidArgumentException, FUPropertyNilMessage);
			});
		});
		
		context(@"with the byValue initialization method", ^{
			it(@"throws an exception", ^{
				assertThrows([[FUTweenAction alloc] initWithTarget:[NSString string] property:nil duration:0.0 byValue:[NSNumber numberWithDouble:1.0]], NSInvalidArgumentException, FUPropertyNilMessage);
			});
		});
	});
	
	context(@"initializing with a nil value", ^{
		context(@"with the toValue initialization method", ^{
			it(@"throws an exception", ^{
				assertThrows([[FUTweenAction alloc] initWithTarget:[NSMutableData data] property:@"length" duration:0.0 toValue:nil], NSInvalidArgumentException, FUToValueNilMessage);
			});
		});
		
		context(@"with the fromValue toValue initialization method on fromValue", ^{
			it(@"throws an exception", ^{
				assertThrows([[FUTweenAction alloc] initWithTarget:[NSMutableData data] property:@"length" duration:0.0 fromValue:nil toValue:[NSNumber numberWithDouble:1.0]], NSInvalidArgumentException, FUFromValueNilMessage);
			});
		});
		
		context(@"with the fromValue toValue initialization method on toValue", ^{
			it(@"throws an exception", ^{
				assertThrows([[FUTweenAction alloc] initWithTarget:[NSMutableData data] property:@"length" duration:0.0 fromValue:[NSNumber numberWithDouble:1.0] toValue:nil], NSInvalidArgumentException, FUToValueNilMessage);
			});
		});
		
		context(@"with the byValue initialization method", ^{
			it(@"throws an exception", ^{
				assertThrows([[FUTweenAction alloc] initWithTarget:[NSMutableData data] property:@"length" duration:0.0 byValue:nil], NSInvalidArgumentException, FUByValueNilMessage);
			});
		});
	});
	
	context(@"initializing with an undefined property", ^{
		context(@"with the toValue initialization method", ^{
			it(@"throws an exception", ^{
				id target = [NSString string];
				NSString* property = @"count";
				assertThrows([[FUTweenAction alloc] initWithTarget:target property:property duration:0.0 toValue:[NSNumber numberWithDouble:1.0]], NSInvalidArgumentException, FUPropertyUndefinedMessage, property, target);
			});
		});
		
		context(@"with the fromValue toValue initialization method", ^{
			it(@"throws an exception", ^{
				id target = [NSString string];
				NSString* property = @"count";
				assertThrows([[FUTweenAction alloc] initWithTarget:target property:property duration:0.0 fromValue:[NSNumber numberWithDouble:1.0] toValue:[NSNumber numberWithDouble:1.0]], NSInvalidArgumentException, FUPropertyUndefinedMessage, property, target);
			});
		});
		
		context(@"with the byValue initialization method", ^{
			it(@"throws an exception", ^{
				id target = [NSString string];
				NSString* property = @"count";
				assertThrows([[FUTweenAction alloc] initWithTarget:target property:property duration:0.0 byValue:[NSNumber numberWithDouble:1.0]], NSInvalidArgumentException, FUPropertyUndefinedMessage, property, target);
			});
		});
	});
	
	context(@"initializing with a readonly property", ^{
		context(@"with the toValue initialization method", ^{
			it(@"throws an exception", ^{
				id target = [NSString string];
				NSString* property = @"length";
				assertThrows([[FUTweenAction alloc] initWithTarget:target property:property duration:0.0 toValue:[NSNumber numberWithDouble:1.0]], NSInvalidArgumentException, FUPropertyReadonlyMessage, property, target);
			});
		});
		
		context(@"with the fromValue toValue initialization method", ^{
			it(@"throws an exception", ^{
				id target = [NSString string];
				NSString* property = @"length";
				assertThrows([[FUTweenAction alloc] initWithTarget:target property:property duration:0.0 fromValue:[NSNumber numberWithDouble:1.0] toValue:[NSNumber numberWithDouble:1.0]], NSInvalidArgumentException, FUPropertyReadonlyMessage, property, target);
			});
		});
		
		context(@"with the byValue initialization method", ^{
			it(@"throws an exception", ^{
				id target = [NSString string];
				NSString* property = @"length";
				assertThrows([[FUTweenAction alloc] initWithTarget:target property:property duration:0.0 byValue:[NSNumber numberWithDouble:1.0]], NSInvalidArgumentException, FUPropertyReadonlyMessage, property, target);
			});
		});
	});
	
	context(@"initialized with the toValue initialization method", ^{
		__block FUDoubleObject* target;
		__block FUTweenAction* tween;
		
		beforeEach(^{
			target = [FUDoubleObject new];
			tween = [[FUTweenAction alloc] initWithTarget:target property:@"doubleValue" duration:1.0 toValue:[NSNumber numberWithDouble:4.0]];
		});
		
		it(@"is not nil", ^{
			expect(tween).toNot.beNil();
		});
		
		it(@"has the correct duration", ^{
			expect([tween duration]).to.equal(1.0);
		});
		
		it(@"has the correct target", ^{
			expect([tween target]).to.beIdenticalTo(target);
		});
		
		it(@"has the correct property", ^{
			expect([tween property]).to.equal(@"doubleValue");
		});
		
		it(@"has no fromValue", ^{
			expect([tween fromValue]).to.beNil();
		});
		
		it(@"has the correct toValue", ^{
			expect([tween toValue]).to.equal([NSNumber numberWithDouble:4.0]);
		});
		
		context(@"set the value on the target to 2.0", ^{
			beforeEach(^{
				[target setDoubleValue:2.0];
			});
			
			context(@"set a factor of 0.5f", ^{
				beforeEach(^{
					[tween setFactor:0.5f];
				});
				
				it(@"has the fromValue of the property on update time", ^{
					expect([tween fromValue]).to.equal([NSNumber numberWithDouble:2.0]);
				});
				
				it(@"sets the value half-way through", ^{
					expect([target doubleValue]).to.equal(3.0);
				});
				
				context(@"setting a factor of 0.0f", ^{
					it(@"sets the value back to the fromValue", ^{
						[tween setFactor:0.0f];
						expect([target doubleValue]).to.equal(2.0);
					});
				});
				
				context(@"created a copy of the tween", ^{
					__block FUTweenAction* tweenCopy;
					
					beforeEach(^{
						tweenCopy = [tween copy];
					});
					
					it(@"has the same target", ^{
						expect([tweenCopy target]).to.beIdenticalTo(target);
					});
					
					it(@"has the same property", ^{
						expect([tweenCopy property]).to.equal(@"doubleValue");
					});
					
					it(@"has the same fromValue", ^{
						expect([tweenCopy fromValue]).to.equal([NSNumber numberWithDouble:2.0]);
					});
					
					it(@"has the same toValue", ^{
						expect([tweenCopy toValue]).to.equal([NSNumber numberWithDouble:4.0]);
					});
					
					context(@"setting a factor of 0.0f", ^{
						it(@"sets the value back to the fromValue", ^{
							[tweenCopy setFactor:0.0f];
							expect([target doubleValue]).to.equal(2.0);
						});
					});
				});
			});
			
			context(@"setting a factor of 1.0f", ^{
				it(@"sets the value back to the toValue", ^{
					[tween setFactor:1.0f];
					expect([target doubleValue]).to.equal(4.0);
				});
			});
			
			context(@"setting a factor of -0.5f", ^{
				it(@"sets the value half-way before the fromValue", ^{
					[tween setFactor:-0.5f];
					expect([target doubleValue]).to.equal(1.0);
				});
			});
			
			context(@"setting a factor of 1.5f", ^{
				it(@"sets the value half-way after the toValue", ^{
					[tween setFactor:1.5f];
					expect([target doubleValue]).to.equal(5.0);
				});
			});
		});
	});
	
	context(@"initialized with the fromValue and toValue initialization method", ^{
		__block FUDoubleObject* target;
		__block FUTweenAction* tween;
		
		beforeEach(^{
			target = [FUDoubleObject new];
			tween = [[FUTweenAction alloc] initWithTarget:target property:@"doubleValue" duration:1.0 fromValue:[NSNumber numberWithDouble:2.0] toValue:[NSNumber numberWithDouble:4.0]];
		});
		
		it(@"is not nil", ^{
			expect(tween).toNot.beNil();
		});
		
		it(@"has the correct duration", ^{
			expect([tween duration]).to.equal(1.0);
		});
		
		it(@"has the correct target", ^{
			expect([tween target]).to.beIdenticalTo(target);
		});
		
		it(@"has the correct property", ^{
			expect([tween property]).to.equal(@"doubleValue");
		});
		
		it(@"has the correct fromValue", ^{
			expect([tween fromValue]).to.equal([NSNumber numberWithDouble:2.0]);
		});
		
		it(@"has the correct toValue", ^{
			expect([tween toValue]).to.equal([NSNumber numberWithDouble:4.0]);
		});
		
		context(@"set the value on the target to 1.0", ^{
			beforeEach(^{
				[target setDoubleValue:1.0];
			});
			
			context(@"set a factor of 0.5f", ^{
				beforeEach(^{
					[tween setFactor:0.5f];
				});
				
				it(@"has the fromValue of the property on update time", ^{
					expect([tween fromValue]).to.equal([NSNumber numberWithDouble:2.0]);
				});
				
				it(@"sets the value half-way through", ^{
					expect([target doubleValue]).to.equal(3.0);
				});
				
				context(@"setting a factor of 0.0f", ^{
					it(@"sets the value back to the fromValue", ^{
						[tween setFactor:0.0f];
						expect([target doubleValue]).to.equal(2.0);
					});
				});
			});
			
			context(@"setting a factor of 1.0f", ^{
				it(@"sets the value back to the toValue", ^{
					[tween setFactor:1.0f];
					expect([target doubleValue]).to.equal(4.0);
				});
			});
			
			context(@"setting a factor of -0.5f", ^{
				it(@"sets the value half-way before the fromValue", ^{
					[tween setFactor:-0.5f];
					expect([target doubleValue]).to.equal(1.0);
				});
			});
			
			context(@"setting a factor of 1.5f", ^{
				it(@"sets the value half-way after the toValue", ^{
					[tween setFactor:1.5f];
					expect([target doubleValue]).to.equal(5.0);
				});
			});
		});
	});
	
	context(@"initialized with the byValue initialization method", ^{
		__block FUDoubleObject* target;
		__block FUTweenAction* tween;
		
		beforeEach(^{
			target = [FUDoubleObject new];
			tween = [[FUTweenAction alloc] initWithTarget:target property:@"doubleValue" duration:1.0 byValue:[NSNumber numberWithDouble:2.0]];
		});
		
		it(@"is not nil", ^{
			expect(tween).toNot.beNil();
		});
		
		it(@"has the correct duration", ^{
			expect([tween duration]).to.equal(1.0);
		});
		
		it(@"has the correct target", ^{
			expect([tween target]).to.beIdenticalTo(target);
		});
		
		it(@"has the correct property", ^{
			expect([tween property]).to.equal(@"doubleValue");
		});
		
		it(@"has no fromValue", ^{
			expect([tween fromValue]).to.beNil();
		});
		
		it(@"has no toValue", ^{
			expect([tween toValue]).to.beNil();
		});
		
		context(@"set the value on the target to 2.0", ^{
			beforeEach(^{
				[target setDoubleValue:2.0];
			});
			
			context(@"set a factor of 0.5f", ^{
				beforeEach(^{
					[tween setFactor:0.5f];
				});
				
				it(@"has the fromValue of the property on update time", ^{
					expect([tween fromValue]).to.equal([NSNumber numberWithDouble:2.0]);
				});
				
				it(@"has the toValue of the difference", ^{
					expect([tween toValue]).to.equal([NSNumber numberWithDouble:4.0]);
				});
				
				it(@"set the value half-way through", ^{
					expect([target doubleValue]).to.equal(3.0);
				});
				
				context(@"setting a factor of 0.0f", ^{
					it(@"set the value back to the fromValue", ^{
						[tween setFactor:0.0f];
						expect([target doubleValue]).to.equal(2.0);
					});
				});
			});
			
			context(@"created a copy of the tween", ^{
				__block FUTweenAction* tweenCopy;
				
				beforeEach(^{
					tweenCopy = [tween copy];
				});
				
				it(@"has the same target", ^{
					expect([tweenCopy target]).to.beIdenticalTo(target);
				});
				
				it(@"has the same property", ^{
					expect([tweenCopy property]).to.equal(@"doubleValue");
				});
				
				it(@"has no fromValue", ^{
					expect([tweenCopy fromValue]).to.beNil();
				});
				
				it(@"has no toValue", ^{
					expect([tweenCopy toValue]).to.beNil();
				});
				
				context(@"set a factor of 0.5f", ^{
					beforeEach(^{
						[tweenCopy setFactor:0.5f];
					});
					
					it(@"has the fromValue of the property on update time", ^{
						expect([tweenCopy fromValue]).to.equal([NSNumber numberWithDouble:2.0]);
					});
					
					it(@"has the toValue of the difference", ^{
						expect([tweenCopy toValue]).to.equal([NSNumber numberWithDouble:4.0]);
					});
					
					it(@"set the value half-way through", ^{
						expect([target doubleValue]).to.equal(3.0);
					});
				});
			});
			
			context(@"setting a factor of 1.0f", ^{
				it(@"sets the value back to the toValue", ^{
					[tween setFactor:1.0f];
					expect([target doubleValue]).to.equal(4.0);
				});
			});
			
			context(@"setting a factor of -0.5f", ^{
				it(@"sets the value half-way before the fromValue", ^{
					[tween setFactor:-0.5f];
					expect([target doubleValue]).to.equal(1.0);
				});
			});
			
			context(@"setting a factor of 1.5f", ^{
				it(@"sets the value half-way after the toValue", ^{
					[tween setFactor:1.5f];
					expect([target doubleValue]).to.equal(5.0);
				});
			});
		});
	});
	
	context(@"initialized with the FUTweenTo function", ^{
		__block FUDoubleObject* target;
		__block NSNumber* toValue;
		__block FUTweenAction* tween;
		
		beforeEach(^{
			target = [FUDoubleObject new];
			toValue = [NSNumber numberWithDouble:4.0];
			tween = FUTweenTo(target, @"doubleValue", 2.0, toValue);
		});
		
		FUTweenIsTo(@"doubleValue", toValue);
	});
	
	context(@"initialized with the FUTweenFromTo function", ^{
		__block FUDoubleObject* target;
		__block NSNumber* fromValue;
		__block NSNumber* toValue;
		__block FUTweenAction* tween;
		
		beforeEach(^{
			target = [FUDoubleObject new];
			fromValue = [NSNumber numberWithDouble:2.0];
			toValue = [NSNumber numberWithDouble:4.0];
			tween = FUTweenFromTo(target, @"doubleValue", 2.0, fromValue, toValue);
		});
		
		FUTweenIsFromTo(@"doubleValue", fromValue, toValue);
	});
	
	context(@"initialized with the FUTweenBy function", ^{
		__block FUDoubleObject* target;
		__block FUTweenAction* tween;
		
		beforeEach(^{
			target = [FUDoubleObject new];
			tween = FUTweenBy(target, @"doubleValue", 2.0, [NSNumber numberWithDouble:2.0]);
		});
		
		FUTweenIsBy(@"doubleValue");
	});
	
	context(@"initialized with the FUMoveTo function", ^{
		__block FUTransform* target;
		__block FUGroupAction* group;
		
		beforeEach(^{
			target = mock([FUTransform class]);
			group = FUMoveTo(target, 2.0, GLKVector2Make(1.5f, 2.5f));
		});
		
		it(@"is a FUGroupAction", ^{
			expect(group).to.beKindOf([FUGroupAction class]);
		});
		
		it(@"has the correct duration", ^{
			expect([group duration]).to.equal(2.0);
		});
		
		it(@"it has two actions", ^{
			expect([group actions]).to.haveCountOf(2);
		});
		
		context(@"the first action", ^{
			__block FUTweenAction* tween;
			
			beforeEach(^{
				tween = [[group actions] objectAtIndex:0];
			});
			
			NSNumber* toValue = [NSNumber numberWithFloat:1.5f];
			FUTweenIsTo(@"positionX", toValue);
		});
		
		context(@"the second action", ^{
			__block FUTweenAction* tween;
			
			beforeEach(^{
				tween = [[group actions] objectAtIndex:1];
			});
			
			NSNumber* toValue = [NSNumber numberWithFloat:2.5f];
			FUTweenIsTo(@"positionY", toValue);
		});
	});
	
	context(@"initialized with the FUMoveFromTo function", ^{
		__block FUTransform* target;
		__block FUGroupAction* group;
		
		beforeEach(^{
			target = mock([FUTransform class]);
			group = FUMoveFromTo(target, 2.0, GLKVector2Make(1.5f, 2.5f), GLKVector2Make(3.5f, -1.0f));
		});
		
		it(@"is a FUGroupAction", ^{
			expect(group).to.beKindOf([FUGroupAction class]);
		});
		
		it(@"has the correct duration", ^{
			expect([group duration]).to.equal(2.0);
		});
		
		it(@"it has two actions", ^{
			expect([group actions]).to.haveCountOf(2);
		});
		
		context(@"the first action", ^{
			__block FUTweenAction* tween;
			
			beforeEach(^{
				tween = [[group actions] objectAtIndex:0];
			});
			
			NSNumber* fromValue = [NSNumber numberWithFloat:1.5f];
			NSNumber* toValue = [NSNumber numberWithFloat:3.5f];
			FUTweenIsFromTo(@"positionX", fromValue, toValue);
		});
		
		context(@"the second action", ^{
			__block FUTweenAction* tween;
			
			beforeEach(^{
				tween = [[group actions] objectAtIndex:1];
			});
			
			NSNumber* fromValue = [NSNumber numberWithFloat:2.5f];
			NSNumber* toValue = [NSNumber numberWithFloat:-1.0f];
			FUTweenIsFromTo(@"positionY", fromValue, toValue);
		});
	});
	
	context(@"initialized with the FUMoveBy function", ^{
		__block FUTransform* target;
		__block FUGroupAction* group;
		
		beforeEach(^{
			target = mock([FUTransform class]);
			group = FUMoveBy(target, 2.0, GLKVector2Make(1.5f, -2.5f));
		});
		
		it(@"is a FUGroupAction", ^{
			expect(group).to.beKindOf([FUGroupAction class]);
		});
		
		it(@"has the correct duration", ^{
			expect([group duration]).to.equal(2.0);
		});
		
		it(@"it has two actions", ^{
			expect([group actions]).to.haveCountOf(2);
		});
		
		context(@"the first action", ^{
			__block FUTweenAction* tween;
			
			beforeEach(^{
				tween = [[group actions] objectAtIndex:0];
			});
			
			FUTweenIsBy(@"positionX");
		});
		
		context(@"the second action", ^{
			__block FUTweenAction* tween;
			
			beforeEach(^{
				tween = [[group actions] objectAtIndex:1];
			});
			
			FUTweenIsBy(@"positionY");
		});
	});
	
	context(@"initialized with the FURotateTo function", ^{
		__block FUTransform* target;
		__block FUTweenAction* tween;
		
		beforeEach(^{
			target = mock([FUTransform class]);
			tween = FURotateTo(target, 2.0, M_PI);
		});
		
		NSNumber* toValue = [NSNumber numberWithFloat:M_PI];
		FUTweenIsTo(@"rotation", toValue);
	});
	
	context(@"initialized with the FURotateFromTo function", ^{
		__block FUTransform* target;
		__block FUTweenAction* tween;
		
		beforeEach(^{
			target = mock([FUTransform class]);
			tween = FURotateFromTo(target, 2.0, M_PI, 2*M_PI);
		});
		
		NSNumber* fromValue = [NSNumber numberWithFloat:M_PI];
		NSNumber* toValue = [NSNumber numberWithFloat:2*M_PI];
		FUTweenIsFromTo(@"rotation", fromValue, toValue);
	});
	
	context(@"initialized with the FURotateBy function", ^{
		__block FUTransform* target;
		__block FUTweenAction* tween;
		
		beforeEach(^{
			target = mock([FUTransform class]);
			tween = FURotateBy(target, 2.0, M_PI);
		});
		
		FUTweenIsBy(@"rotation");
	});
	
	context(@"initialized with the FUScaleTo function", ^{
		__block FUTransform* target;
		__block FUGroupAction* group;
		
		beforeEach(^{
			target = mock([FUTransform class]);
			group = FUScaleTo(target, 2.0, GLKVector2Make(1.5f, 2.5f));
		});
		
		it(@"is a FUGroupAction", ^{
			expect(group).to.beKindOf([FUGroupAction class]);
		});
		
		it(@"has the correct duration", ^{
			expect([group duration]).to.equal(2.0);
		});
		
		it(@"it has two actions", ^{
			expect([group actions]).to.haveCountOf(2);
		});
		
		context(@"the first action", ^{
			__block FUTweenAction* tween;
			
			beforeEach(^{
				tween = [[group actions] objectAtIndex:0];
			});
			
			NSNumber* toValue = [NSNumber numberWithFloat:1.5f];
			FUTweenIsTo(@"scaleX", toValue);
		});
		
		context(@"the second action", ^{
			__block FUTweenAction* tween;
			
			beforeEach(^{
				tween = [[group actions] objectAtIndex:1];
			});
			
			NSNumber* toValue = [NSNumber numberWithFloat:2.5f];
			FUTweenIsTo(@"scaleY", toValue);
		});
	});
	
	context(@"initialized with the FUScaleFromTo function", ^{
		__block FUTransform* target;
		__block FUGroupAction* group;
		
		beforeEach(^{
			target = mock([FUTransform class]);
			group = FUScaleFromTo(target, 2.0, GLKVector2Make(1.5f, 2.5f), GLKVector2Make(3.5f, -1.0f));
		});
		
		it(@"is a FUGroupAction", ^{
			expect(group).to.beKindOf([FUGroupAction class]);
		});
		
		it(@"has the correct duration", ^{
			expect([group duration]).to.equal(2.0);
		});
		
		it(@"it has two actions", ^{
			expect([group actions]).to.haveCountOf(2);
		});
		
		context(@"the first action", ^{
			__block FUTweenAction* tween;
			
			beforeEach(^{
				tween = [[group actions] objectAtIndex:0];
			});
			
			NSNumber* fromValue = [NSNumber numberWithFloat:1.5f];
			NSNumber* toValue = [NSNumber numberWithFloat:3.5f];
			FUTweenIsFromTo(@"scaleX", fromValue, toValue);
		});
		
		context(@"the second action", ^{
			__block FUTweenAction* tween;
			
			beforeEach(^{
				tween = [[group actions] objectAtIndex:1];
			});
			
			NSNumber* fromValue = [NSNumber numberWithFloat:2.5f];
			NSNumber* toValue = [NSNumber numberWithFloat:-1.0f];
			FUTweenIsFromTo(@"scaleY", fromValue, toValue);
		});
	});
	
	context(@"initialized with the FUScaleBy function", ^{
		__block FUTransform* target;
		__block FUGroupAction* group;
		
		beforeEach(^{
			target = mock([FUTransform class]);
			group = FUScaleBy(target, 2.0, GLKVector2Make(1.5f, -2.5f));
		});
		
		it(@"is a FUGroupAction", ^{
			expect(group).to.beKindOf([FUGroupAction class]);
		});
		
		it(@"has the correct duration", ^{
			expect([group duration]).to.equal(2.0);
		});
		
		it(@"it has two actions", ^{
			expect([group actions]).to.haveCountOf(2);
		});
		
		context(@"the first action", ^{
			__block FUTweenAction* tween;
			
			beforeEach(^{
				tween = [[group actions] objectAtIndex:0];
			});
			
			FUTweenIsBy(@"scaleX");
		});
		
		context(@"the second action", ^{
			__block FUTweenAction* tween;
			
			beforeEach(^{
				tween = [[group actions] objectAtIndex:1];
			});
			
			FUTweenIsBy(@"scaleY");
		});
	});
	
	context(@"initializing with a mutable property and changing it", ^{
		it(@"does not change the property", ^{
			NSMutableString* property = [NSMutableString stringWithString:@"doubleValue"];
			FUTweenAction* tween = FUTweenTo([FUDoubleObject new], @"doubleValue", 1.0, [NSNumber numberWithDouble:4.0]);
			[property setString:@"invalidProperty"];
			expect([tween property]).to.equal(@"doubleValue");
		});
	});
});

SPEC_END


@implementation FUDoubleObject
@synthesize doubleValue = _doubleValue;
@end