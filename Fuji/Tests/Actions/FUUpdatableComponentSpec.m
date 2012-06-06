//
//  FUUpdatableComponentSpec.m
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
#import "FUComponent-Internal.h"


SPEC_BEGIN(FUUpdatableComponent)

describe(@"An updatable component", ^{
	it(@"is a behavior", ^{
		expect([FUUpdatableComponent class]).to.beSubclassOf([FUBehavior class]);
	});
	
	it(@"requires an update engine", ^{
		expect([FUUpdatableComponent requiredEngines]).to.contain([FUUpdateEngine class]);
	});
	
	context(@"initialized", ^{
		__block FUUpdatableComponent* updatableComponent;
		
		beforeEach(^{
			FUScene* scene = mock([FUScene class]);
			FUEntity* entity = mock([FUEntity class]);
			[given([entity scene]) willReturn:scene];
			updatableComponent = [[FUUpdatableComponent alloc] initWithEntity:entity];
		});
		
		it(@"can be updated", ^{
			[updatableComponent update];
		});
	});
});

SPEC_END
