//
//  FUDirectorSpec.m
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
#import "FUVisitor-Internal.h"
#import "FUViewController-Internal.h"
#import "FUScene-Internal.h"
#import "FUSceneObject-Internal.h"
#import "FUEngine-Internal.h"
#import "FUTestSupport.h"


static NSString* const FUAssetStoreNilMessage = @"Expected 'assetStore' to not be nil";
static NSString* const FUOrientationInvalidMessage = @"Expected 'validOrientations=%i' to be greater than 0 and less than 16";
static NSString* const FUSceneAlreadyUsedMessage = @"The 'scene=%@' is already showing in another 'director=%@'";
static NSString* const FUSceneAlreadyInDirector = @"The 'scene=%@' is already showing in this director";
static NSString* const FUEngineClassNullMessage = @"Expected 'engineClass' to not be NULL";
static NSString* const FUEngineClassInvalidMessage = @"Expected 'engineClass=%@' to be a subclass of FUEngine (excluded)";
static NSString* const FUEngineAlreadyUsedMessage = @"The 'engine=%@' is already used in another 'director=%@'";
static NSString* const FUEngineAlreadyInDirector = @"The 'engine=%@' is already used in this director.'";
static NSString* const FUSceneObjectNilMessage = @"Expected 'sceneObject' to not be nil";
static NSString* const FUSceneObjectInvalidMessage = @"Expected 'sceneObject=%@' to have the same 'director=%@'";


SPEC_BEGIN(FUViewController)

describe(@"A fuji view controller", ^{
	it(@"is a subclass of GLKViewController", ^{
		expect([FUViewController class]).to.beASubclassOf([GLKViewController class]);
	});
	
	context(@"initializing a new director with a nil asset store", ^{
		it(@"throws an exception", ^{
			assertThrows([[FUViewController alloc] initWithAssetStore:nil], NSInvalidArgumentException, FUAssetStoreNilMessage);
		});
	});
	
	context(@"initialized", ^{
		__block FUViewController* viewController;
		
		beforeEach(^{
			viewController = [FUViewController new];
		});
		
		it(@"has a valid opengl view", ^{
			expect([viewController view]).to.beKindOf([GLKView class]);
		});
		
		it(@"has a valid asset store", ^{
			expect([viewController assetStore]).toNot.beNil();
		});
		
		it(@"automatically rotates in all orientations", ^{
			expect([viewController shouldAutorotateToInterfaceOrientation:UIInterfaceOrientationPortrait]).to.beTruthy();
			expect([viewController shouldAutorotateToInterfaceOrientation:UIInterfaceOrientationPortraitUpsideDown]).to.beTruthy();
			expect([viewController shouldAutorotateToInterfaceOrientation:UIInterfaceOrientationLandscapeLeft]).to.beTruthy();
			expect([viewController shouldAutorotateToInterfaceOrientation:UIInterfaceOrientationLandscapeRight]).to.beTruthy();
		});

		context(@"initializing a new view controller with the current asset store", ^{
			it(@"shares the same asset store", ^{
				FUViewController* newViewController = [[FUViewController alloc] initWithAssetStore:[viewController assetStore]];
				expect([newViewController assetStore]).to.beIdenticalTo([viewController assetStore]);
			});
		});

		it(@"is the delegate of the opengl view", ^{
			expect([(GLKView*)[viewController view] delegate]).to.beIdenticalTo(viewController);
		});
		
		it(@"has it's view at the same size as the screen", ^{
			CGSize viewSize = [[viewController view] bounds].size;
			CGSize screenSize = [[UIScreen mainScreen] bounds].size;
			expect(CGSizeEqualToSize(viewSize, screenSize)).to.beTruthy();
		});
		
		it(@"has an nil scene", ^{
			expect([viewController scene]).to.beNil();
		});
		
		it(@"has no engines", ^{
			expect([viewController allEngines]).to.beEmpty();
		});
		
		context(@"require an engine class of NULL", ^{
			it(@"throws an exception", ^{
				assertThrows([viewController requireEngineWithClass:NULL], NSInvalidArgumentException, FUEngineClassNullMessage);
			});
		});
		
		context(@"require a class that does not subclass FUEngine", ^{
			it(@"throws an exception", ^{
				assertThrows([viewController requireEngineWithClass:[NSString class]], NSInvalidArgumentException, FUEngineClassInvalidMessage, [NSString class]);
			});
		});
		
		context(@"require the FUEngine class", ^{
			it(@"throws an exception", ^{
				assertThrows([viewController requireEngineWithClass:[FUEngine class]], NSInvalidArgumentException, FUEngineClassInvalidMessage, [FUEngine class]);
			});
		});
		
		context(@"loading a scene that already has a director", ^{
			it(@"throws an exception", ^{
				FUScene* scene = mock([FUScene class]);
				FUViewController * otherDirector = mock([FUViewController class]);
				[given([scene director]) willReturn:otherDirector];
				assertThrows([viewController loadScene:scene], NSInvalidArgumentException, FUSceneAlreadyUsedMessage, scene, otherDirector);
			});
		});
			
		context(@"created and added a mock engine", ^{
			__block Class engineClass;
			__block FUEngine* engine;
			__block FUVisitor* registrationVisitor;
			__block FUVisitor* unregistrationVisitor;
			__block FUEngine* returnedEngine;
			
			beforeEach(^{
				engine = mock([FUEngine class]);
				registrationVisitor = mock([FUVisitor class]);
				[given([engine registrationVisitor]) willReturn:registrationVisitor];
				unregistrationVisitor = mock([FUVisitor class]);
				[given([engine unregistrationVisitor]) willReturn:unregistrationVisitor];
				
				engineClass = mockClass([FUEngine class]);
				[given([engineClass isSubclassOfClass:[FUEngine class]]) willReturnBool:YES];
				[given([engineClass alloc]) willReturn:engine];
				[given([engine initWithDirector:viewController]) willReturn:engine];
				returnedEngine = [viewController requireEngineWithClass:engineClass];
			});
			
			it(@"set the engine's view controller property", ^{
				[verify(engine) initWithDirector:viewController];
			});
			
			it(@"returned the engine", ^{
				expect(returnedEngine).to.beIdenticalTo(engine);
			});
			
			it(@"contains the engine", ^{
				expect([viewController allEngines]).to.contain(engine);
			});
			
			context(@"requiring the same engine class again", ^{
				it(@"returns the same engine", ^{
					[given([engineClass alloc]) willReturn:nil];
					[given([engine isKindOfClass:engineClass]) willReturnBool:YES];
					expect([viewController requireEngineWithClass:engineClass] == engine).to.beTruthy();
				});
			});
			
			context(@"requiring a superclass of the engine", ^{
				it(@"returns the same engine", ^{
					Class engineSuperclass = mockClass([FUEngine class]);
					[given([engineSuperclass isSubclassOfClass:[FUEngine class]]) willReturnBool:YES];
					FUEngine* superclassEngine = mock([FUEngine class]);
					[given([engineSuperclass alloc]) willReturn:superclassEngine];
					[given([superclassEngine initWithDirector:viewController]) willReturn:superclassEngine];
					[given([engine isKindOfClass:engineSuperclass]) willReturnBool:YES];
					expect([viewController requireEngineWithClass:engineSuperclass] == engine).to.beTruthy();
				});
			});
			
			context(@"requiring a subclass of the engine", ^{
				it(@"returns a new engine", ^{
					Class engineSubclass = mockClass([FUEngine class]);
					[given([engineSubclass isSubclassOfClass:[FUEngine class]]) willReturnBool:YES];
					FUEngine* subclassEngine = mock([FUEngine class]);
					[given([engineSubclass alloc]) willReturn:subclassEngine];
					[given([subclassEngine initWithDirector:viewController]) willReturn:subclassEngine];
					[given([engine isKindOfClass:engineSubclass]) willReturnBool:NO];
					expect([viewController requireEngineWithClass:engineSubclass] == subclassEngine).to.beTruthy();
				});
			});
			
			context(@"calling the rotation methods", ^{
				it(@"called the rotation methods on it's engine", ^{
					[viewController willRotateToInterfaceOrientation:UIInterfaceOrientationPortrait duration:1];
					[verify(engine) willRotateToInterfaceOrientation:UIInterfaceOrientationPortrait duration:1];
					
					[viewController willAnimateRotationToInterfaceOrientation:UIInterfaceOrientationPortrait duration:1];
					[verify(engine) willAnimateRotationToInterfaceOrientation:UIInterfaceOrientationPortrait duration:1];
					
					[viewController didRotateFromInterfaceOrientation:UIInterfaceOrientationLandscapeLeft];
					[verify(engine) didRotateFromInterfaceOrientation:UIInterfaceOrientationLandscapeLeft];
				});
			});
			
			context(@"load a mock scene", ^{
				__block FUScene* scene;
				
				beforeEach(^{
					scene = mock([FUScene class]);
					[viewController loadScene:scene];
				});
				
				it(@"has the scene property set", ^{
					expect([viewController scene]).to.beIdenticalTo(scene);
				});
				
				it(@"set it's scene director property point to itself", ^{
					[verify(scene) setDirector:viewController];
				});
				
				it(@"called the unregisterAll method on the engine", ^{
					[verify(engine) unregisterAll];
				});
				
				it(@"called the scene's acceptVisitor method", ^{
					[verify(scene) acceptVisitor:HC_anything()];
				});
				
				context(@"loading the same scene again", ^{
					it(@"throws an exception", ^{
						[given([scene director]) willReturn:viewController];
						assertThrows([viewController loadScene:scene], NSInvalidArgumentException, FUSceneAlreadyInDirector, scene);
					});
				});
				
				context(@"calling the rotation methods", ^{
					it(@"called the rotation methods on it's scene", ^{
						[viewController willRotateToInterfaceOrientation:UIInterfaceOrientationPortrait duration:1];
						[verify(scene) willRotateToInterfaceOrientation:UIInterfaceOrientationPortrait duration:1];
						
						[viewController willAnimateRotationToInterfaceOrientation:UIInterfaceOrientationPortrait duration:1];
						[verify(scene) willAnimateRotationToInterfaceOrientation:UIInterfaceOrientationPortrait duration:1];
						
						[viewController didRotateFromInterfaceOrientation:UIInterfaceOrientationLandscapeLeft];
						[verify(scene) didRotateFromInterfaceOrientation:UIInterfaceOrientationLandscapeLeft];
					});
				});
				
				context(@"initialized a scene object", ^{
					__block FUSceneObject* sceneObject;
					
					beforeEach(^{
						sceneObject = [[FUSceneObject alloc] initWithScene:scene];
					});
					
					context(@"calling didAddSceneObject: with the scene", ^{
						it(@"calls the engine's registration visitor visit method with the scene object", ^{
							[viewController didAddSceneObject:sceneObject];
							[verify(registrationVisitor) visitSceneObject:sceneObject];
						});
					});
					
					context(@"calling didRemoveSceneObject: with the scene", ^{
						it(@"calls the engine's unregistration visitor visit method with the scene object", ^{
							[viewController willRemoveSceneObject:sceneObject];
							[verify(unregistrationVisitor) visitSceneObject:sceneObject];
						});
					});
				});
				
				context(@"load a nil scene", ^{
					beforeEach(^{
						[viewController loadScene:nil];
					});
					
					it(@"set the scene property to nil", ^{
						expect([viewController scene]).to.beNil();
					});
					
					it(@"set the director property of the previous scene to nil", ^{
						[verify(scene) setDirector:nil];
					});
					
					it(@"did not call the engine's unregistration visitor visit method with the scene", ^{
						[verifyCount(unregistrationVisitor, never()) visitSceneObject:scene];
					});
					
					it(@"called the unregisterAll method on the engine a second time", ^{
						[verifyCount(engine, times(2)) unregisterAll];
					});
				});
			});
			
			context(@"calling the GLKViewController update method", ^{
				it(@"calls the engine update method", ^{
					[(id)viewController update];
					[verify(engine) update];
				});
			});
			
			context(@"calling the GLKViewDelegate draw method", ^{
				it(@"draws the engine's draw method", ^{
					[viewController glkView:nil drawInRect:CGRectZero];
					[verify(engine) draw];
				});
			});
		});
	});
});

SPEC_END
