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
	__block FUChildSceneObject* sceneObject = nil;
	
	beforeEach(^{
		sceneObject = [FUChildSceneObject new];
	});
	
	context(@"visiting with a visitor that handles the child scene object", ^{
		it(@"calls the child's visit method", ^{
			FUVisitChildVisitor* visitor = mock([FUVisitChildVisitor class]);
			[sceneObject acceptVisitor:visitor];
			[verify(visitor) visitFUChildSceneObject:sceneObject];
		});
	});
	
	context(@"visiting with a visitor that handles the parent scene object", ^{
		it(@"calls the parent's visit method", ^{
			FUVisitParentVisitor* visitor = mock([FUVisitParentVisitor class]);
			[sceneObject acceptVisitor:visitor];
			[verify(visitor) visitFUParentSceneObject:sceneObject];
		});
	});
	
	context(@"visiting with a visitor that does not handle any ancestor of the scene object", ^{
		it(@"does nothing", ^{
			FUVisitNothingVisitor* visitor = mock([FUVisitNothingVisitor class]);
			[sceneObject acceptVisitor:visitor];
		});
	});
});

SPEC_END