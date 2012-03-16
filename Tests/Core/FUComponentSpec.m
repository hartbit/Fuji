//
//  FUComponentSpec.m
//  Fuji
//
//  Created by David Hart on 01.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#include "Prefix.pch"
#import "FujiCore.h"
#import "FUComponent-Internal.h"


SPEC_BEGIN(FUComponentSpec)

describe(@"A component object", ^{
	it(@"is not unique by default", ^{
		expect([FUComponent isUnique]).to.beFalsy();
	});
	
	it(@"does not require any components by default", ^{
		expect([FUComponent requiredComponents]).to.beEmpty();
	});
	
	context(@"initialized with init", ^{
#ifdef DEBUG
		it(@"throws an exception", ^{
			STAssertThrows([FUComponent new], nil);
		});
#else
		it(@"returns nil", ^{
			expect([FUComponent new]).to.beNil();
		});
#endif
	});
	
	context(@"initialized with a nil game object", ^{
#ifdef DEBUG
		it(@"throws an exception", ^{
			STAssertThrows([[FUComponent alloc] initWithGameObject:nil], nil);
		});
#else
		it(@"returns nil", ^{
			expect([[FUComponent alloc] initWithGameObject:nil]).to.beNil();
		});
#endif
	});
		
	context(@"initialized with a valid game object", ^{
		__block FUGameObject* gameObject = nil;
		__block FUComponent* component = nil;
		
		beforeEach(^{
			gameObject = mock([FUGameObject class]);
			component = [[FUComponent alloc] initWithGameObject:gameObject];
		});
		
		it(@"is not nil", ^{
			expect(component).toNot.beNil();
		});
		
		it(@"has the gameObject property set", ^{
			expect([component gameObject]).to.beIdenticalTo(gameObject);
		});
	});
});

SPEC_END
