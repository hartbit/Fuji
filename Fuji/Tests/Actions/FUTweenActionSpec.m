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


static NSString* const FUObjectNilMessage = @"Expected object to not be nil";
static NSString* const FUPropertyNilMessage = @"Expected property to not be nil or empty";
static NSString* const FUFromValueNilMessage = @"Expected fromValue to not be nil";
static NSString* const FUToValueNilMessage = @"Expected toValue to not be nil";
static NSString* const FUByValueNilMessage = @"Expected byValue to not be nil";
static NSString* const FUPropertyUndefinedMessage = @"The 'property=%@' is not defined for 'object=%@'";
static NSString* const FUPropertyReadonlyMessage = @"Expected 'property=%@' on 'object=%@' to be readwrite but was readonly";


SPEC_BEGIN(FUTweenAction)

describe(@"A tween action", ^{
	it(@"is a timed action", ^{
		expect([FUDelayAction class]).to.beSubclassOf([FUTimedAction class]);
	});
	
	context(@"initializing with a nil object", ^{
		context(@"with the toValue initialization method", ^{
			it(@"throws an exception", ^{
				assertThrows([[FUTweenAction alloc] initWithObject:nil property:@"property" toValue:[NSNumber numberWithDouble:1.0]], NSInvalidArgumentException, FUObjectNilMessage);
			});
		});
		
		context(@"with the fromValue toValue initialization method", ^{
			it(@"throws an exception", ^{
				assertThrows([[FUTweenAction alloc] initWithObject:nil property:@"property" fromValue:[NSNumber numberWithDouble:1.0] toValue:[NSNumber numberWithDouble:1.0]], NSInvalidArgumentException, FUObjectNilMessage);
			});
		});
		
		context(@"with the byValue initialization method", ^{
			it(@"throws an exception", ^{
				assertThrows([[FUTweenAction alloc] initWithObject:nil property:@"property" byValue:[NSNumber numberWithDouble:1.0]], NSInvalidArgumentException, FUObjectNilMessage);
			});
		});
	});
	
	context(@"initializing with a nil property", ^{
		context(@"with the toValue initialization method", ^{
			it(@"throws an exception", ^{
				assertThrows([[FUTweenAction alloc] initWithObject:[NSString string] property:nil toValue:[NSNumber numberWithDouble:1.0]], NSInvalidArgumentException, FUPropertyNilMessage);
			});
		});
		
		context(@"with the fromValue toValue initialization method", ^{
			it(@"throws an exception", ^{
				assertThrows([[FUTweenAction alloc] initWithObject:[NSString string] property:nil fromValue:[NSNumber numberWithDouble:1.0] toValue:[NSNumber numberWithDouble:1.0]], NSInvalidArgumentException, FUPropertyNilMessage);
			});
		});
		
		context(@"with the byValue initialization method", ^{
			it(@"throws an exception", ^{
				assertThrows([[FUTweenAction alloc] initWithObject:[NSString string] property:nil byValue:[NSNumber numberWithDouble:1.0]], NSInvalidArgumentException, FUPropertyNilMessage);
			});
		});
	});
	
	context(@"initializing with a nil value", ^{
		context(@"with the toValue initialization method", ^{
			it(@"throws an exception", ^{
				assertThrows([[FUTweenAction alloc] initWithObject:[NSMutableData data] property:@"length" toValue:nil], NSInvalidArgumentException, FUToValueNilMessage);
			});
		});
		
		context(@"with the fromValue toValue initialization method on fromValue", ^{
			it(@"throws an exception", ^{
				assertThrows([[FUTweenAction alloc] initWithObject:[NSMutableData data] property:@"length" fromValue:nil toValue:[NSNumber numberWithDouble:1.0]], NSInvalidArgumentException, FUFromValueNilMessage);
			});
		});
		
		context(@"with the fromValue toValue initialization method on toValue", ^{
			it(@"throws an exception", ^{
				assertThrows([[FUTweenAction alloc] initWithObject:[NSMutableData data] property:@"length" fromValue:[NSNumber numberWithDouble:1.0] toValue:nil], NSInvalidArgumentException, FUToValueNilMessage);
			});
		});
		
		context(@"with the byValue initialization method", ^{
			it(@"throws an exception", ^{
				assertThrows([[FUTweenAction alloc] initWithObject:[NSMutableData data] property:@"length" byValue:nil], NSInvalidArgumentException, FUByValueNilMessage);
			});
		});
	});
	
	context(@"initializing with an undefined property", ^{
		context(@"with the toValue initialization method", ^{
			it(@"throws an exception", ^{
				id object = [NSString string];
				NSString* property = @"count";
				assertThrows([[FUTweenAction alloc] initWithObject:object property:property toValue:[NSNumber numberWithDouble:1.0]], NSInvalidArgumentException, FUPropertyUndefinedMessage, property, object);
			});
		});
		
		context(@"with the fromValue toValue initialization method", ^{
			it(@"throws an exception", ^{
				id object = [NSString string];
				NSString* property = @"count";
				assertThrows([[FUTweenAction alloc] initWithObject:object property:property fromValue:[NSNumber numberWithDouble:1.0] toValue:[NSNumber numberWithDouble:1.0]], NSInvalidArgumentException, FUPropertyUndefinedMessage, property, object);
			});
		});
		
		context(@"with the byValue initialization method", ^{
			it(@"throws an exception", ^{
				id object = [NSString string];
				NSString* property = @"count";
				assertThrows([[FUTweenAction alloc] initWithObject:object property:property byValue:[NSNumber numberWithDouble:1.0]], NSInvalidArgumentException, FUPropertyUndefinedMessage, property, object);
			});
		});
	});
	
	context(@"initializing with a readonly property", ^{
		context(@"with the toValue initialization method", ^{
			it(@"throws an exception", ^{
				id object = [NSString string];
				NSString* property = @"length";
				assertThrows([[FUTweenAction alloc] initWithObject:object property:property toValue:[NSNumber numberWithDouble:1.0]], NSInvalidArgumentException, FUPropertyReadonlyMessage, property, object);
			});
		});
		
		context(@"with the fromValue toValue initialization method", ^{
			it(@"throws an exception", ^{
				id object = [NSString string];
				NSString* property = @"length";
				assertThrows([[FUTweenAction alloc] initWithObject:object property:property fromValue:[NSNumber numberWithDouble:1.0] toValue:[NSNumber numberWithDouble:1.0]], NSInvalidArgumentException, FUPropertyReadonlyMessage, property, object);
			});
		});
		
		context(@"with the byValue initialization method", ^{
			it(@"throws an exception", ^{
				id object = [NSString string];
				NSString* property = @"length";
				assertThrows([[FUTweenAction alloc] initWithObject:object property:property byValue:[NSNumber numberWithDouble:1.0]], NSInvalidArgumentException, FUPropertyReadonlyMessage, property, object);
			});
		});
	});
});

SPEC_END