//
//  FUDirectorSpec.m
//  Fuji
//
//  Created by Hart David on 22.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#include "Prefix.pch"
#import "Fuji.h"
#import "FUVisitor-Internal.h"
#import "FUDirector-Internal.h"
#import "FUSceneObject-Internal.h"
#import "FUEngine-Internal.h"


SPEC_BEGIN(FUDirector)

describe(@"A director", ^{
	it(@"is a subclass of GLKViewController", ^{
		expect([FUDirector class]).to.beASubclassOf([GLKViewController class]);
	});
	
	context(@"initializing a new director with a nil asset store", ^{
		it(@"throws an exception", ^{
			STAssertThrows([[FUDirector alloc] initWithAssetStore:nil], nil);
		});
	});
	
	context(@"initialized", ^{
		__block FUDirector* director = nil;
		
		beforeEach(^{
			director = [FUDirector new];
		});
		
		it(@"has a valid opengl view", ^{
			expect([director view]).to.beKindOf([GLKView class]);
		});
		
		it(@"has a valid asset store", ^{
			expect([director assetStore]).toNot.beNil();
		});

		context(@"initializing a new director with the current asset store", ^{
			it(@"shares the same asset store", ^{
				FUDirector* newDirector = [[FUDirector alloc] initWithAssetStore:[director assetStore]];
				expect([newDirector assetStore]).to.beIdenticalTo([director assetStore]);
			});
		});

		it(@"is the delegate of the opengl view", ^{
			expect([(GLKView*)[director view] delegate]).to.beIdenticalTo(director);
		});
		
		it(@"has it's view at the same size as the screen", ^{
			CGSize viewSize = [[director view] bounds].size;
			CGSize screenSize = [[UIScreen mainScreen] bounds].size;
			expect(CGSizeEqualToSize(viewSize, screenSize)).to.beTruthy();
		});
		
		it(@"has an nil scene", ^{
			expect([director scene]).to.beNil();
		});
		
		it(@"has a graphics engine", ^{
			NSSet* engines = [director allEngines];
			expect(engines).to.haveCountOf(1);
			expect([engines anyObject]).to.beKindOf([FUGraphicsEngine class]);
		});
		
		it(@"automatically rotates in all orientations", ^{
			expect([director shouldAutorotateToInterfaceOrientation:UIInterfaceOrientationPortrait]).to.beTruthy();
			expect([director shouldAutorotateToInterfaceOrientation:UIInterfaceOrientationPortraitUpsideDown]).to.beTruthy();
			expect([director shouldAutorotateToInterfaceOrientation:UIInterfaceOrientationLandscapeLeft]).to.beTruthy();
			expect([director shouldAutorotateToInterfaceOrientation:UIInterfaceOrientationLandscapeRight]).to.beTruthy();
		});
		
		context(@"adding a nil engine", ^{
			it(@"throws an exception", ^{
				STAssertThrows([director addEngine:nil], nil);
			});
		});
		
		context(@"adding an engine that already has a director", ^{
			it(@"throws an exception", ^{
				FUEngine* engine = mock([FUEngine class]);
				[given([engine director]) willReturn:mock([FUDirector class])];
				STAssertThrows([director addEngine:engine], nil);
			});
		});
		
		context(@"loading a scene that already has a director", ^{
			it(@"throws an exception", ^{
				FUScene* scene = mock([FUScene class]);
				[given([scene director]) willReturn:mock([FUDirector class])];
				STAssertThrows([director loadScene:scene], nil);
			});
		});
			
		context(@"created and added a mock engine", ^{
			__block FUEngine* engine = nil;
			__block FUVisitor* registrationVisitor = nil;
			__block FUVisitor* unregistrationVisitor = nil;
			
			beforeEach(^{
				engine = mock([FUEngine class]);
				registrationVisitor = mock([FUVisitor class]);
				[given([engine registrationVisitor]) willReturn:registrationVisitor];
				unregistrationVisitor = mock([FUVisitor class]);
				[given([engine unregistrationVisitor]) willReturn:unregistrationVisitor];
				[director addEngine:engine];
			});
			
			it(@"set the engine's director property", ^{
				[verify(engine) setDirector:director];
			});
			
			it(@"contains the engine", ^{
				NSSet* engines = [director allEngines];
				expect(engines).to.haveCountOf(2);
				expect(engines).to.contain(engine);
			});
			
			context(@"adding the same engine again", ^{
				it(@"throws an exception", ^{
					[given([engine director]) willReturn:director];
					STAssertThrows([director addEngine:engine], nil);
				});
			});
			
			context(@"calling the rotation methods", ^{
				it(@"called the rotation methods on it's engine", ^{
					[director willRotateToInterfaceOrientation:UIInterfaceOrientationPortrait duration:1];
					[verify(engine) willRotateToInterfaceOrientation:UIInterfaceOrientationPortrait duration:1];
					
					[director willAnimateRotationToInterfaceOrientation:UIInterfaceOrientationPortrait duration:1];
					[verify(engine) willAnimateRotationToInterfaceOrientation:UIInterfaceOrientationPortrait duration:1];
					
					[director didRotateFromInterfaceOrientation:UIInterfaceOrientationLandscapeLeft];
					[verify(engine) didRotateFromInterfaceOrientation:UIInterfaceOrientationLandscapeLeft];
				});
			});
			
			context(@"load a mock scene", ^{
				__block FUScene* scene = nil;
				
				beforeEach(^{
					scene = mock([FUScene class]);
					[director loadScene:scene];
				});
				
				it(@"has the scene property set", ^{
					expect([director scene]).to.beIdenticalTo(scene);
				});
				
				it(@"set it's scene director property point to itself", ^{
					[verify(scene) setDirector:director];
				});
				
				it(@"called the unregisterAll method on the engine", ^{
					[verify(engine) unregisterAll];
				});
				
				it(@"called the scene's acceptVisitor method", ^{
					[verify(scene) acceptVisitor:HC_anything()];
				});
				
				context(@"loading the same scene again", ^{
					it(@"throws an exception", ^{
						[given([scene director]) willReturn:director];
						STAssertThrows([director loadScene:scene], nil);
					});
				});
				
				context(@"calling the rotation methods", ^{
					it(@"called the rotation methods on it's scene", ^{
						[director willRotateToInterfaceOrientation:UIInterfaceOrientationPortrait duration:1];
						[verify(scene) willRotateToInterfaceOrientation:UIInterfaceOrientationPortrait duration:1];
						
						[director willAnimateRotationToInterfaceOrientation:UIInterfaceOrientationPortrait duration:1];
						[verify(scene) willAnimateRotationToInterfaceOrientation:UIInterfaceOrientationPortrait duration:1];
						
						[director didRotateFromInterfaceOrientation:UIInterfaceOrientationLandscapeLeft];
						[verify(scene) didRotateFromInterfaceOrientation:UIInterfaceOrientationLandscapeLeft];
					});
				});
				
				context(@"initialized a scene object", ^{
					__block FUSceneObject* sceneObject = nil;
					
					beforeEach(^{
						sceneObject = [[FUSceneObject alloc] initWithScene:scene];
					});
					
					context(@"calling didAddSceneObject: with the scene", ^{
						it(@"calls the engine's registration visitor visit method with the scene object", ^{
							[director didAddSceneObject:sceneObject];
							[verify(registrationVisitor) visitSceneObject:sceneObject];
						});
					});
					
					context(@"calling didRemoveSceneObject: with the scene", ^{
						it(@"calls the engine's unregistration visitor visit method with the scene object", ^{
							[director willRemoveSceneObject:sceneObject];
							[verify(unregistrationVisitor) visitSceneObject:sceneObject];
						});
					});
				});
				
				context(@"load a nil scene", ^{
					beforeEach(^{
						[director loadScene:nil];
					});
					
					it(@"set the scene property to nil", ^{
						expect([director scene]).to.beNil();
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
					[(id)director update];
					[verify(engine) update];
				});
			});
			
			context(@"calling the GLKViewDelegate draw method", ^{
				it(@"draws the engine's draw method", ^{
					[director glkView:nil drawInRect:CGRectZero];
					[verify(engine) draw];
				});
			});
		});
	});
});

SPEC_END
