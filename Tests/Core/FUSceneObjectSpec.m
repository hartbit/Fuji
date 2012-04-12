//
//  FUSceneObject.m
//  Fuji
//
//  Created by Hart David on 24.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#include "Prefix.pch"
#import "Fuji.h"


SPEC_BEGIN(FUSceneObject)

describe(@"A scene", ^{
	it(@"conforms to FUInterfaceRotating", ^{
		expect([[FUSceneObject class] conformsToProtocol:@protocol(FUInterfaceRotating)]).to.beTruthy();
	});
	
	context(@"created and initialized", ^{
		__block FUSceneObject* sceneObject = nil;
		
		beforeEach(^{
			sceneObject = [FUSceneObject new];
		});
	});
});

SPEC_END
