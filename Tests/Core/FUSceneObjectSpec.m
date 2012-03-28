//
//  FUSceneObject.m
//  Fuji
//
//  Created by Hart David on 24.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#include "Prefix.pch"
#import "Fuji.h"
#import "FUTestVisitors.h"


SPEC_BEGIN(FUSceneObject)

describe(@"A scene object", ^{
	__block FUSceneObject* sceneObject = nil;
	
	beforeEach(^{
		sceneObject = [FUSceneObject new];
	});
	
	context(@"visiting with a visitor that does not handle that scene object", ^{
		it(@"does nothing", ^{
			NSString* visitor = mock([NSString class]);
			[sceneObject acceptVisitor:visitor];
		});
	});
	
	context(@"visiting with a visitor that handles that scene object", ^{
		it(@"calls the visit method", ^{
			FUTestVisitor* visitor = mock([FUTestVisitor class]);
			[sceneObject acceptVisitor:visitor];
			[verify(visitor) visitFUSceneObject:sceneObject];
		});
	});
});

SPEC_END