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
	it(@"can be visited by an engine", ^{
		expect([[FUComponent class] conformsToProtocol:@protocol(FUEngineVisiting)]).to.beTruthy();
	});
	
	it(@"can react to interface rotations", ^{
		expect([[FUComponent class] conformsToProtocol:@protocol(FUInterfaceRotating)]).to.beTruthy();
	});
	
	it(@"is not unique by default", ^{
		expect([FUComponent isUnique]).to.beFalsy();
	});
	
	it(@"does not require any components by default", ^{
		expect([FUComponent requiredComponents]).to.beEmpty();
	});
	
	context(@"initializing with init", ^{
		it(@"throws an exception", ^{
			STAssertThrows([FUComponent new], nil);
		});
	});
	
	context(@"initializing with a nil game object", ^{
		it(@"throws an exception", ^{
			STAssertThrows([[FUComponent alloc] initWithEntity:nil], nil);
		});
	});
	
	context(@"created and initialized", ^{
		__block FUEntity* entity = nil;
		__block FUComponent* component = nil;
		
		beforeEach(^{
			entity = mock([FUEntity class]);
			component = [[FUComponent alloc] initWithEntity:entity];
		});
		
		it(@"is not nil", ^{
			expect(component).toNot.beNil();
		});
		
		it(@"has the entity property set", ^{
			expect([component entity]).to.beIdenticalTo(entity);
		});

		context(@"removing the component", ^{
			it(@"asks the entity to remove itself", ^{
				[component removeFromEntity];
				[verify(entity) removeComponent:component];
			});
		});
	});
});

SPEC_END
