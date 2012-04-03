//
//  FUDirectorSpec.m
//  Fuji
//
//  Created by Hart David on 22.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#include "Prefix.pch"
#import "Fuji.h"
#import "FUEngine-Internal.h"
#import "FUTestVisitors.h"


SPEC_BEGIN(FUDirectorSpec)

describe(@"A director", ^{
	it(@"is a subclass of GLKViewController", ^{
		expect([FUDirector class]).to.beASubclassOf([GLKViewController class]);
	});
	
	context(@"created and initialized", ^{
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
		
		context(@"a scene is set", ^{
			__block FUScene* scene = nil;
			
			beforeEach(^{
				scene = [FUScene new];
				[director setScene:scene];
			});
			
			it(@"has the scene property set", ^{
				expect([director scene]).to.beIdenticalTo(scene);
			});
			
			it(@"set it's scene director property point to itself", ^{
				expect([scene director]).to.beIdenticalTo(director);
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
					expect([scene director]).to.beNil();
				});
			});
			
			context(@"added a generic engine", ^{
				__block FUGenericEngine* engine = nil;
				
				beforeEach(^{
					engine = mock([FUGenericEngine class]);
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
				
				context(@"calling the update method on the director", ^{
					it(@"makes the visitor update the scene and it's components", ^{
						[director performSelector:@selector(update)];
						[verify(engine) updateFUSceneObject:scene];
						[verify(engine) updateFUSceneObject:[scene graphics]];
					});
				});
				
				context(@"calling the draw method on the director", ^{
					it(@"makes the visitor draw the scene and it's components", ^{
						[director glkView:nil drawInRect:CGRectZero];
						[verify(engine) drawFUSceneObject:scene];
						[verify(engine) drawFUSceneObject:[scene graphics]];
					});
				});
				
				context(@"added an entity to the scene", ^{
					__block FUEntity* entity = nil;
					
					beforeEach(^{
						entity = [scene createEntity];
					});
					
					context(@"calling the update method on the director", ^{
						it(@"makes the visitor update the entity and it's component", ^{
							[director performSelector:@selector(update)];
							[verify(engine) updateFUSceneObject:entity];
							[verify(engine) updateFUSceneObject:[entity transform]];
						});
					});
					
					context(@"calling the draw method on the director", ^{
						it(@"makes the visitor draw the entity and it's component", ^{
							[director glkView:nil drawInRect:CGRectZero];
							[verify(engine) drawFUSceneObject:entity];
							[verify(engine) drawFUSceneObject:[entity transform]];
						});
					});
				});
			});
			
			context(@"created and added a mock engine", ^{
				__block FUEngine* engine = nil;
				
				beforeEach(^{
					engine = mock([FUEngine class]);
					[director addEngine:engine];
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
			});
			
			context(@"created and set a mock scene", ^{
				__block FUScene* scene = nil;
				
				beforeEach(^{
					scene = mock([FUScene class]);
					[director setScene:scene];
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
			});
		});
	});
});

SPEC_END
