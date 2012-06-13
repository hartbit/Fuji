//
//  FUComponentSpec.m
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
#import "FUDirector-Internal.h"
#import "FUSceneObject-Internal.h"
#import "FUComponent-Internal.h"
#import "FUTestSupport.h"


static NSString* const FUEntityNilMessage = @"Expected 'entity' to not be nil";


@interface FURequirementComponent : FUComponent
@end


SPEC_BEGIN(FUComponent)

describe(@"A component object", ^{
	it(@"is a scene object", ^{
		expect([FUComponent class]).to.beSubclassOf([FUSceneObject class]);
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
	
	it(@"does not require any engines by default", ^{
		expect([FUComponent requiredEngines]).to.beEmpty();
	});
	
	context(@"initializing with init", ^{
		it(@"throws an exception", ^{
			assertThrows([FUComponent new], NSInternalInconsistencyException, @"Can not create a scene object outside of a scene");
		});
	});
	
	context(@"initializing with a nil entity", ^{
		it(@"throws an exception", ^{
			assertThrows([[FUComponent alloc] initWithEntity:nil], NSInvalidArgumentException, FUEntityNilMessage);
		});
	});
	
	context(@"initialized with a test component", ^{
		__block FUDirector* director;
		__block FUScene* scene;
		__block FUEntity* entity;
		__block FUComponent* component;
		
		beforeEach(^{
			director = mock([FUDirector class]);
			scene = mock([FUScene class]);
			[given([scene director]) willReturn:director];
			entity = mock([FUEntity class]);
			[given([entity scene]) willReturn:scene];
			component = [[FURequirementComponent alloc] initWithEntity:entity];
		});
		
		it(@"has the entity property set", ^{
			expect([component entity]).to.beIdenticalTo(entity);
		});
		
		it(@"has the scene property set", ^{
			expect([component scene]).to.beIdenticalTo(scene);
		});

		context(@"removing the component", ^{
			it(@"asks the entity to remove itself", ^{
				[component removeFromEntity];
				[verify(entity) removeComponent:component];
			});
		});
		
		context(@"visiting the component", ^{
			it(@"requires the required engines from the director", ^{
				[component acceptVisitor:nil];
				
				for (Class engineClass in [FURequirementComponent requiredEngines]) {
					[verify(director) requireEngineWithClass:engineClass];
				}
			});
		});
	});
});

SPEC_END


@implementation FURequirementComponent
+ (NSSet*)requiredEngines
{
	static NSSet* requiredEngines = nil;
	
	if (requiredEngines == nil) {
		Class engineClass1 = mockClass([FUEngine class]);
		Class engineClass2 = mockClass([FUEngine class]);
		requiredEngines = [NSSet setWithObjects:engineClass1, engineClass2, nil];
	}
	
	return requiredEngines;
}
@end
