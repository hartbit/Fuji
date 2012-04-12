//
//  FUDirectorSpec.m
//  Fuji
//
//  Created by Hart David on 22.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#include "Prefix.pch"
#import "Fuji.h"
#import "FUSceneObject-Internal.h"
#import "FUEngine-Internal.h"


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


SPEC_BEGIN(FUDirectorSpec)

describe(@"A director", ^{
	it(@"is a subclass of GLKViewController", ^{
		expect([FUDirector class]).to.beASubclassOf([GLKViewController class]);
	});
	
	context(@"initialized", ^{
		__block FUDirector* director = nil;
		
		beforeEach(^{
			director = [FUDirector new];
		});
		
		it(@"has a valid opengl view", ^{
			expect([director view]).to.beKindOf([GLKView class]);
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
		
		context(@"adding a scene that already has a director", ^{
			it(@"throws an exception", ^{
				FUScene* scene = mock([FUScene class]);
				[given([scene director]) willReturn:mock([FUDirector class])];
				STAssertThrows([director setScene:scene], nil);
			});
		});
		
		context(@"registering a nil scene object", ^{
			it(@"throws an exception", ^{
				STAssertThrows([director registerSceneObject:nil], nil);
			});
		});
		
		context(@"unregistering a nil scene object", ^{
			it(@"throws an exception", ^{
				STAssertThrows([director unregisterSceneObject:nil], nil);
			});
		});
		
		context(@"set a scene", ^{
			__block FUScene* scene = nil;
			
			beforeEach(^{
				scene = mock([FUScene class]);
				[director setScene:scene];
			});
			
			it(@"has the scene property set", ^{
				expect([director scene]).to.beIdenticalTo(scene);
			});
			
			it(@"set it's scene director property point to itself", ^{
				[verify(scene) setDirector:director];
			});
			
			context(@"setting the same scene again", ^{
				it(@"does nothing", ^{
					[director setScene:scene];
					expect([director scene]).to.beIdenticalTo(scene);
				});
			});
			
			context(@"set the scene to nil", ^{
				beforeEach(^{
					[director setScene:nil];
				});
				
				it(@"set the scene property to nil", ^{
					expect([director scene]).to.beNil();
				});
				
				it(@"set the director property of the previous scene to nil", ^{
					[verify(scene) setDirector:nil];
				});
			});
			
			context(@"created and added a mock engine", ^{
				__block FUEngine* engine = nil;
				
				beforeEach(^{
					engine = mock([FUEngine class]);
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
				
				context(@"calling the rotation methods", ^{
					it(@"called the rotation methods on it's engine", ^{
						[director willRotateToInterfaceOrientation:UIInterfaceOrientationPortrait duration:1];
						[verify(scene) willRotateToInterfaceOrientation:UIInterfaceOrientationPortrait duration:1];
							
						[director willAnimateRotationToInterfaceOrientation:UIInterfaceOrientationPortrait duration:1];
						[verify(scene) willAnimateRotationToInterfaceOrientation:UIInterfaceOrientationPortrait duration:1];
							
						[director didRotateFromInterfaceOrientation:UIInterfaceOrientationLandscapeLeft];
						[verify(scene) didRotateFromInterfaceOrientation:UIInterfaceOrientationLandscapeLeft];
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
		
		context(@"initialized a scene object", ^{
			__block FUScene* scene = nil;
			__block FUChildSceneObject* sceneObject = nil;
			
			beforeEach(^{
				scene = mock([FUScene class]);
				sceneObject = [[FUChildSceneObject alloc] initWithScene:scene];
			});
			
			context(@"registering the scene object", ^{
				it(@"throws an exception", ^{
					STAssertThrows([director registerSceneObject:sceneObject], nil);
				});
			});
			
			context(@"unregistering the scene object", ^{
				it(@"throws an exception", ^{
					STAssertThrows([director unregisterSceneObject:sceneObject], nil);
				});
			});

			context(@"set another director on the scene", ^{
				beforeEach(^{
					[given([scene director]) willReturn:mock([FUDirector class])];
				});
				
				context(@"registering the scene object", ^{
					it(@"throws an exception", ^{
						STAssertThrows([director registerSceneObject:sceneObject], nil);
					});
				});
				
				context(@"unregistering the scene object", ^{
					it(@"throws an exception", ^{
						STAssertThrows([director unregisterSceneObject:sceneObject], nil);
					});
				});
			});

			context(@"set the director on the scene", ^{
				beforeEach(^{
					[given([scene director]) willReturn:director];
				});
				
				context(@"added an engine that registers/unregisters the child scene object", ^{
					__block FUChildEngine* engine;
					
					beforeEach(^{
						engine = mock([FUChildEngine class]);
						[director addEngine:engine];
					});
					
					context(@"registering the scene object", ^{
						it(@"calls the engine's register method", ^{
							[director registerSceneObject:sceneObject];
							[verify(engine) registerFUChildSceneObject:sceneObject];
						});
					});
					
					context(@"unregistering the scene object", ^{
						it(@"calls the engine's unregister method", ^{
							[director unregisterSceneObject:sceneObject];
							[verify(engine) unregisterFUChildSceneObject:sceneObject];
						});
					});
				});
				
				context(@"added an engine that registers/unregisters the parent scene object", ^{
					__block FUParentEngine* engine;
					
					beforeEach(^{
						engine = mock([FUParentEngine class]);
						[director addEngine:engine];
					});
					
					context(@"registering the scene object", ^{
						it(@"calls the engine's register method", ^{
							[director registerSceneObject:sceneObject];
							[verify(engine) registerFUParentSceneObject:sceneObject];
						});
					});
					
					context(@"unregistering the scene object", ^{
						it(@"calls the engine's unregister method", ^{
							[director unregisterSceneObject:sceneObject];
							[verify(engine) unregisterFUParentSceneObject:sceneObject];
						});
					});
				});
				
				context(@"created an engine that does not register/unregister anything", ^{
					__block FUEmptyEngine* engine;
					
					beforeEach(^{
						engine = mock([FUEmptyEngine class]);
						[director addEngine:engine];
					});
					
					context(@"registering the scene object", ^{
						it(@"does nothing", ^{
							[director registerSceneObject:sceneObject];
						});
					});
					
					context(@"unregistering the scene object", ^{
						it(@"does nothing", ^{
							[director unregisterSceneObject:sceneObject];
						});
					});
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
