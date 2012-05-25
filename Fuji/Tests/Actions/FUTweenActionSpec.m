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


SPEC_BEGIN(FUTweenAction)

describe(@"A tween action", ^{
	it(@"is a timed action", ^{
		expect([FUDelayAction class]).to.beSubclassOf([FUTimedAction class]);
	});
	
	context(@"initializing with a nil object, a property, and a toValue", ^{
		it(@"throws an exception", ^{
			assertThrows([[FUTweenAction alloc] initWithObject:nil property:@"property" toValue:[NSNumber numberWithDouble:1.0]], NSInvalidArgumentException, FUObjectNilMessage);
		});
	});
	
	context(@"initializing with a nil object, a property, a fromValue and a toValue", ^{
		it(@"throws an exception", ^{
			assertThrows([[FUTweenAction alloc] initWithObject:nil property:@"property" fromValue:[NSNumber numberWithDouble:1.0] toValue:[NSNumber numberWithDouble:1.0]], NSInvalidArgumentException, FUObjectNilMessage);
		});
	});
	
	context(@"initializing with a nil object, a property and a byValue", ^{
		it(@"throws an exception", ^{
			assertThrows([[FUTweenAction alloc] initWithObject:nil property:@"property" byValue:[NSNumber numberWithDouble:1.0]], NSInvalidArgumentException, FUObjectNilMessage);
		});
	});
	
	context(@"initializing with an object, a nil property and a toValue", ^{
		it(@"throws an exception", ^{
			assertThrows([[FUTweenAction alloc] initWithObject:[NSString string] property:nil toValue:[NSNumber numberWithDouble:1.0]], NSInvalidArgumentException, FUPropertyNilMessage);
		});
	});
	
	context(@"initializing with an object, a nil property, a fromValue and a toValue", ^{
		it(@"throws an exception", ^{
			assertThrows([[FUTweenAction alloc] initWithObject:[NSString string] property:nil fromValue:[NSNumber numberWithDouble:1.0] toValue:[NSNumber numberWithDouble:1.0]], NSInvalidArgumentException, FUPropertyNilMessage);
		});
	});
	
	context(@"initializing with an object, a nil property and a byValue", ^{
		it(@"throws an exception", ^{
			assertThrows([[FUTweenAction alloc] initWithObject:[NSString string] property:nil byValue:[NSNumber numberWithDouble:1.0]], NSInvalidArgumentException, FUPropertyNilMessage);
		});
	});
	
	context(@"initializing with an object, a property and a nil toValue", ^{
		it(@"throws an exception", ^{
			assertThrows([[FUTweenAction alloc] initWithObject:[NSString string] property:@"property" toValue:nil], NSInvalidArgumentException, FUToValueNilMessage);
		});
	});
	
	context(@"initializing with an object, a property, a nil fromValue and a toValue", ^{
		it(@"throws an exception", ^{
			assertThrows([[FUTweenAction alloc] initWithObject:[NSString string] property:@"property" fromValue:nil toValue:[NSNumber numberWithDouble:1.0]], NSInvalidArgumentException, FUFromValueNilMessage);
		});
	});
	
	context(@"initializing with an object, a property, a fromValue and a nil toValue", ^{
		it(@"throws an exception", ^{
			assertThrows([[FUTweenAction alloc] initWithObject:[NSString string] property:@"property" fromValue:[NSNumber numberWithDouble:1.0] toValue:nil], NSInvalidArgumentException, FUToValueNilMessage);
		});
	});
	
	context(@"initializing with an object, a property and a nil byValue", ^{
		it(@"throws an exception", ^{
			assertThrows([[FUTweenAction alloc] initWithObject:[NSString string] property:@"property" byValue:nil], NSInvalidArgumentException, FUByValueNilMessage);
		});
	});
});

SPEC_END