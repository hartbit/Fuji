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
	
	context(@"created a visitor that updates and draws the child scene object", ^{
		__block FUVisitChildVisitor* visitor;
		
		beforeEach(^{
			visitor = mock([FUVisitChildVisitor class]);
		});
		
		it(@"calls the visitor update method", ^{
			[sceneObject updateVisitor:visitor];
			[verify(visitor) updateFUChildSceneObject:sceneObject];
		});
		
		it(@"calls the visitor draw method", ^{
			[sceneObject drawVisitor:visitor];
			[verify(visitor) drawFUChildSceneObject:sceneObject];
		});
	});
	
	context(@"created a visitor that updates and draws the parent scene object", ^{
		__block FUVisitParentVisitor* visitor;
		
		beforeEach(^{
			visitor = mock([FUVisitParentVisitor class]);
		});
		
		it(@"calls the visitor update method", ^{
			[sceneObject updateVisitor:visitor];
			[verify(visitor) updateFUParentSceneObject:sceneObject];
		});
		
		it(@"calls the visitor draw method", ^{
			[sceneObject drawVisitor:visitor];
			[verify(visitor) drawFUParentSceneObject:sceneObject];
		});
	});
	
	context(@"created a visitor that does not updates nor draws anything", ^{
		__block FUVisitNothingVisitor* visitor;
		
		beforeEach(^{
			visitor = mock([FUVisitNothingVisitor class]);
		});
		
		it(@"does not try to call any update method", ^{
			[sceneObject updateVisitor:visitor];
		});
		
		it(@"does not try to call any draw method", ^{
			[sceneObject drawVisitor:visitor];
		});
	});
});

SPEC_END