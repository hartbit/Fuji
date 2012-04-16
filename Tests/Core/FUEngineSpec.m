//
//  FUEngineSpec.m
//  Fuji
//
//  Created by Hart David on 22.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#include "Prefix.pch"
#import "Fuji.h"
#import "FUEngine-Internal.h"
#import "FUSceneObject-Internal.h"


@interface FUParentSceneObject : FUSceneObject @end
@interface FUChildSceneObject : FUParentSceneObject @end

@interface FUParentEngine : FUEngine
@property (nonatomic, readonly) NSUInteger parentRegisterCallCount;
@property (nonatomic, readonly) NSUInteger parentUnregisterCallCount;
- (void)registerFUParentSceneObject:(FUParentSceneObject*)sceneObject;
- (void)unregisterFUParentSceneObject:(FUParentSceneObject*)sceneObject;
@end

@interface FUChildEngine : FUParentEngine
@property (nonatomic, readonly) NSUInteger childRegisterCallCount;
@property (nonatomic, readonly) NSUInteger childUnregisterCallCount;
- (void)registerFUChildSceneObject:(FUChildSceneObject*)sceneObject;
- (void)unregisterFUChildSceneObject:(FUChildSceneObject*)sceneObject;
@end

@interface FUEmptyEngine : FUEngine @end


SPEC_BEGIN(FUEngineSpec)

describe(@"An engine", ^{
	it(@"can react to interface rotations", ^{
		expect([[FUEngine class] conformsToProtocol:@protocol(FUInterfaceRotating)]).to.beTruthy();
	});
	
	context(@"initialized", ^{
		__block FUEngine* engine = nil;
		
		beforeEach(^{
			engine = [FUEngine new];
		});
		
		it(@"has no director", ^{
			expect([engine director]).to.beNil();
		});
	});
	
	context(@"created a child scene object", ^{
		__block FUChildSceneObject* sceneObject = nil;
		
		beforeEach(^{
			sceneObject = [[FUChildSceneObject alloc] initWithScene:mock([FUScene class])];
		});
		
		context(@"created an engine that handles the parent scene object", ^{
			__block FUParentEngine* engine = nil;
			
			beforeEach(^{
				engine = [FUParentEngine new];
			});
			
			context(@"registering the scene object with the engine", ^{
				it(@"calls the parent register method", ^{
					[engine registerSceneObject:sceneObject];
					expect([engine parentRegisterCallCount]).to.equal(1);
					expect([engine parentUnregisterCallCount]).to.equal(0);
				});
			});
			
			context(@"unregistering the scene object with the engine", ^{
				it(@"calls the parent unregister method", ^{
					[engine unregisterSceneObject:sceneObject];
					expect([engine parentRegisterCallCount]).to.equal(0);
					expect([engine parentUnregisterCallCount]).to.equal(1);
				});
			});
		});
		
		context(@"created an engine that handles the parent and child scene object", ^{
			__block FUChildEngine* engine = nil;
			
			beforeEach(^{
				engine = [FUChildEngine new];
			});
			
			context(@"registering the scene object with the engine", ^{
				it(@"calls the child register method", ^{
					[engine registerSceneObject:sceneObject];
					expect([engine parentRegisterCallCount]).to.equal(0);
					expect([engine parentUnregisterCallCount]).to.equal(0);
					expect([engine childRegisterCallCount]).to.equal(1);
					expect([engine childUnregisterCallCount]).to.equal(0);
				});
			});
			
			context(@"unregistering the scene object with the engine", ^{
				it(@"calls the child unregister method", ^{
					[engine unregisterSceneObject:sceneObject];
					expect([engine parentRegisterCallCount]).to.equal(0);
					expect([engine parentUnregisterCallCount]).to.equal(0);
					expect([engine childRegisterCallCount]).to.equal(0);
					expect([engine childUnregisterCallCount]).to.equal(1);
				});
			});
		});
		
		context(@"created an engine that does not handle any scene obejct", ^{
			__block FUEmptyEngine* engine = nil;
			
			beforeEach(^{
				engine = [FUEmptyEngine new];
			});
			
			context(@"registering the scene object with the engine", ^{
				it(@"does nothing", ^{
					[engine registerSceneObject:sceneObject];
				});
			});
			
			context(@"unregistering the scene object with the engine", ^{
				it(@"does nothing", ^{
					[engine unregisterSceneObject:sceneObject];
				});
			});
		});
	});
});

SPEC_END


@implementation FUParentSceneObject @end
@implementation FUChildSceneObject @end

@implementation FUParentEngine
@synthesize parentRegisterCallCount = _parentRegisterCallCount;
@synthesize parentUnregisterCallCount = _parentUnregisterCallCount;
- (void)registerFUParentSceneObject:(FUParentSceneObject*)sceneObject { _parentRegisterCallCount++; }
- (void)unregisterFUParentSceneObject:(FUParentSceneObject*)sceneObject { _parentUnregisterCallCount++; }
@end

@implementation FUChildEngine
@synthesize childRegisterCallCount = _childRegisterCallCount;
@synthesize childUnregisterCallCount = _childUnregisterCallCount;
- (void)registerFUChildSceneObject:(FUChildSceneObject*)sceneObject { _childRegisterCallCount++; }
- (void)unregisterFUChildSceneObject:(FUChildSceneObject*)sceneObject { _childUnregisterCallCount++; }
@end

@implementation FUEmptyEngine @end
