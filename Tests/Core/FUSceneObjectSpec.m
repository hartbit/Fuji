//
//  FUSceneObject.m
//  Fuji
//
//  Created by Hart David on 24.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#include "Prefix.pch"
#import "Fuji.h"
#import "FUTestEngines.h"


@interface FUParentSceneObject : FUSceneObject
@end

@interface FUChildSceneObject : FUParentSceneObject
@end

@interface FUChildEngine : FUEngine
- (void)registerFUChildSceneObject:(FUChildSceneObject*)sceneObject;
- (void)unregisterFUChildSceneObject:(FUChildSceneObject*)sceneObject;
@end

@interface FUParentEngine : FUEngine
- (void)registerFUParentSceneObject:(FUParentSceneObject*)sceneObject;
- (void)unregisterFUParentSceneObject:(FUParentSceneObject*)sceneObject;
@end

@interface FUEmptyEngine : FUEngine
@end


SPEC_BEGIN(FUSceneObject)

describe(@"A scene", ^{
	it(@"conforms to FUInterfaceRotating", ^{
		expect([[FUSceneObject class] conformsToProtocol:@protocol(FUInterfaceRotating)]).to.beTruthy();
	});
	
	context(@"created and initialized", ^{
		__block FUChildSceneObject* sceneObject = nil;
		
		beforeEach(^{
			sceneObject = [FUChildSceneObject new];
		});
		
		context(@"created an engine that registers/unregisters the child scene object", ^{
			__block FUChildEngine* engine;
			
			beforeEach(^{
				engine = mock([FUChildEngine class]);
			});
			
			context(@"calling the register method on the scene object", ^{
				it(@"calls the engine's register method", ^{
					[sceneObject registerWithEngine:engine];
					[verify(engine) registerFUChildSceneObject:sceneObject];
				});
			});
			
			context(@"calling the unregister method on the scene object", ^{
				it(@"calls the engine's unregister method", ^{
					[sceneObject unregisterFromEngine:engine];
					[verify(engine) unregisterFUChildSceneObject:sceneObject];
				});
			});
		});
		
		context(@"created an engine that registers/unregisters the parent scene object", ^{
			__block FUParentEngine* engine;
			
			beforeEach(^{
				engine = mock([FUParentEngine class]);
			});
			
			context(@"calling the register method on the scene object", ^{
				it(@"calls the engine's register method", ^{
					[sceneObject registerWithEngine:engine];
					[verify(engine) registerFUParentSceneObject:sceneObject];
				});
			});
			
			context(@"calling the unregister method on the scene object", ^{
				it(@"calls the engine's unregister method", ^{
					[sceneObject unregisterFromEngine:engine];
					[verify(engine) unregisterFUParentSceneObject:sceneObject];
				});
			});
		});
		
		context(@"created an engine that does not register/unregister anything", ^{
			__block FUEmptyEngine* engine;
			
			beforeEach(^{
				engine = mock([FUEmptyEngine class]);
			});
			
			context(@"calling the register method on the scene object", ^{
				it(@"does nothing", ^{
					[sceneObject registerWithEngine:engine];
				});
			});
			
			context(@"calling the unregister method on the scene object", ^{
				it(@"does nothing", ^{
					[sceneObject unregisterFromEngine:engine];
				});
			});
		});
	});
});

SPEC_END


@implementation FUParentSceneObject
@end

@implementation FUChildSceneObject
@end

@implementation FUChildEngine
- (void)registerFUChildSceneObject:(FUChildSceneObject*)sceneObject { }
- (void)unregisterFUChildSceneObject:(FUChildSceneObject*)sceneObject { }
@end

@implementation FUParentEngine
- (void)registerFUParentSceneObject:(FUParentSceneObject*)sceneObject { }
- (void)unregisterFUParentSceneObject:(FUParentSceneObject*)sceneObject { }
@end

@implementation FUEmptyEngine
@end