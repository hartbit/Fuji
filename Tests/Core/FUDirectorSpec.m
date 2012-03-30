//
//  FUDirectorSpec.m
//  Fuji
//
//  Created by Hart David on 22.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#include "Prefix.pch"
#import "Fuji.h"
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
		
		it(@"has a nil scene", ^{
			expect([director scene]).to.beNil();
		});
		
		it(@"has no engines", ^{
			expect([director allEngines]).to.beEmpty();
		});
		
		it(@"automatically rotates in all orientations", ^{
			expect([director shouldAutorotateToInterfaceOrientation:UIInterfaceOrientationPortrait]).to.beTruthy();
			expect([director shouldAutorotateToInterfaceOrientation:UIInterfaceOrientationPortraitUpsideDown]).to.beTruthy();
			expect([director shouldAutorotateToInterfaceOrientation:UIInterfaceOrientationLandscapeLeft]).to.beTruthy();
			expect([director shouldAutorotateToInterfaceOrientation:UIInterfaceOrientationLandscapeRight]).to.beTruthy();
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
			
			context(@"added a generic visitor", ^{
				__block FUGenericVisitor* visitor = nil;
				
				beforeEach(^{
					visitor = mock([FUGenericVisitor class]);
					[director addEngine:visitor];
				});
				
				it(@"contains the engine", ^{
					NSSet* engines = [director allEngines];
					expect(engines).to.haveCountOf(1);
					expect(engines).to.contain(visitor);
				});
				
				context(@"calling the update method on the director", ^{
					it(@"makes the visitor update the scene", ^{
						[director performSelector:@selector(update)];
						[verify(visitor) updateFUSceneObject:scene];
					});
				});
				
				context(@"calling the draw method on the director", ^{
					it(@"makes the visitor draw the scene", ^{
						[director glkView:nil drawInRect:CGRectZero];
						[verify(visitor) drawFUSceneObject:scene];
					});
				});
				
				context(@"added an entity to the scene", ^{
					__block FUEntity* entity = nil;
					
					beforeEach(^{
						entity = [scene createEntity];
					});
					
					context(@"calling the update method on the director", ^{
						it(@"makes the visitor update the entity", ^{
							[director performSelector:@selector(update)];
							[verify(visitor) updateFUSceneObject:scene];
							[verify(visitor) updateFUSceneObject:entity];
						});
					});
					
					context(@"calling the draw method on the director", ^{
						it(@"makes the visitor draw the entity", ^{
							[director glkView:nil drawInRect:CGRectZero];
							[verify(visitor) drawFUSceneObject:scene];
							[verify(visitor) drawFUSceneObject:entity];
						});
					});
				});
			});
		});
	});
});

SPEC_END
