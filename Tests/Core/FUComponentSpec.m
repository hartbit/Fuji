//
//  FUComponentSpec.m
//  Fuji
//
//  Created by David Hart on 01.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#include "Prefix.pch"
#import "Fuji.h"
#import "FUComponent-Internal.h"


SPEC_BEGIN(FUComponentSpec)

describe(@"A component object", ^{
	it(@"conforms to the FUUpdateable protocol", ^{
		expect([[FUComponent class] conformsToProtocol:@protocol(FUUpdateable)]).to.beTruthy();
	});
	
	it(@"is not unique by default", ^{
		expect([FUComponent isUnique]).to.beFalsy();
	});
	
	it(@"does not require any components by default", ^{
		expect([FUComponent requiredComponents]).to.beEmpty();
	});
	
	context(@"creating with init", ^{
		it(@"throws an exception", ^{
			STAssertThrows([FUComponent new], nil);
		});
	});
	
	context(@"created and initialized", ^{
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

		context(@"removing the component", ^{
			it(@"asks the gameObject to remove itself", ^{
				[component removeFromGameObject];
				[verify(gameObject) removeComponent:component];
			});
		});
	});
});

SPEC_END
