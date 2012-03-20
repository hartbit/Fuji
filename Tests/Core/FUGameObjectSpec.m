//
//  FUGameObjectSpec.m
//  Fuji
//
//  Created by Hart David on 24.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#include "Prefix.pch"
#import "FujiCore.h"
#import "FUGameObject-Internal.h"
#import "FUComponent-Internal.h"
#import "FUTestComponents.h"


SPEC_BEGIN(FUGameObjectSpec)

describe(@"A game object", ^{
	context(@"initialized with init", ^{
		it(@"throws an exception", ^{
			STAssertThrows([FUGameObject new], nil);
		});
	});
	
	context(@"initialized with a nil scene", ^{
		it(@"throws an exception", ^{
			STAssertThrows((void)[[FUGameObject alloc] initWithScene:nil], nil);
		});
	});
	
	context(@"initialized with a valid scene", ^{
		__block FUScene* scene = nil;
		__block FUGameObject* gameObject = nil;
		
		beforeEach(^{
			scene = mock([FUScene class]);
			gameObject = [[FUGameObject alloc] initWithScene:scene];
		});
		
		it(@"is not nil", ^{
			expect(gameObject).toNot.beNil();
		});
		
		it(@"has the scene property set", ^{
			expect([gameObject scene]).to.beIdenticalTo(scene);
		});
		
		it(@"has no components", ^{
			expect([gameObject allComponents]).to.beEmpty();
		});
		
		context(@"adding a component with a NULL class", ^{
			it(@"throws an exception", ^{
				STAssertThrows([gameObject addComponentWithClass:NULL], nil);
			});
		});
		
		context(@"adding a component with a class that does not subclass FUComponent", ^{
			it(@"throws an exception", ^{
				STAssertThrows([gameObject addComponentWithClass:[NSString class]], nil);
			});
		});
		
		context(@"adding a component with the FUComponent class", ^{
			it(@"throws an exception", ^{
				STAssertThrows([gameObject addComponentWithClass:[FUComponent class]], nil);
			});
		});
		
		context(@"adding a component that requires an object that is not a class", ^{
			it(@"throws an exception", ^{
				STAssertThrows([gameObject addComponentWithClass:[FURequireObjectComponent class]], nil);
			});
		});
		
		context(@"adding a component that requires a class that does not subclass FUComponent", ^{
			it(@"throws an exception", ^{
				STAssertThrows([gameObject addComponentWithClass:[FURequireNSStringComponent class]], nil);
			});
		});
		
		context(@"adding a component that requires a FUComponent", ^{
			it(@"throws an exception", ^{
				STAssertThrows([gameObject addComponentWithClass:[FURequireBaseComponent class]], nil);
			});
		});
		
		context(@"adding a component that requires itself", ^{
			it(@"throws an exception", ^{
				STAssertThrows([gameObject addComponentWithClass:[FURequireItselfComponent class]], nil);
			});
		});

		context(@"adding a component that requires a subclass of itself", ^{
			it(@"throws an exception", ^{
				STAssertThrows([gameObject addComponentWithClass:[FURequireSubclassComponent class]], nil);
			});
		});
		
		context(@"adding a component that requires relatives", ^{
			it(@"throws an exception", ^{
				STAssertThrows([gameObject addComponentWithClass:[FURequireRelativesComponent class]], nil);
			});
		});
		
		context(@"removing a nil component", ^{
			it(@"throws an exception", ^{
				STAssertThrows([gameObject removeComponent:nil], nil);
			});
		});
		
		context(@"removing a component that does not exist", ^{
			it(@"throws an exception", ^{
				STAssertThrows([gameObject removeComponent:[FUTestComponent testComponent]], nil);
			});
		});
		
		context(@"getting a component with a NULL class", ^{
			it(@"throws an exception", ^{
				STAssertThrows([gameObject componentWithClass:NULL], nil);
			});
		});
		
		context(@"getting a component with the FUComponent class", ^{
			it(@"throws an exception", ^{
				STAssertThrows([gameObject componentWithClass:[FUComponent class]], nil);
			});
		});
		
		context(@"getting a component with a subclass of FUComponent", ^{
			it(@"returns nil", ^{
				expect([gameObject componentWithClass:[FUTestComponent class]]).to.beNil();
			});
		});
		
		context(@"getting all components with a NULL class", ^{
			it(@"throws an exception", ^{
				STAssertThrows([gameObject allComponentsWithClass:NULL], nil);
			});
		});
		
		context(@"getting all components with the FUComponent class", ^{
			it(@"throws an exception", ^{
				STAssertThrows([gameObject allComponentsWithClass:[FUComponent class]], nil);
			});
		});
		
		context(@"getting all components with a subclass of FUComponent", ^{
			it(@"returns an empty set", ^{
				expect([gameObject allComponentsWithClass:[FUTestComponent class]]).to.beEmpty();
			});
		});
		
		context(@"adding a non-unique component that has a unique ancestor", ^{
			it(@"throws an exception", ^{
				STAssertThrows([gameObject addComponentWithClass:[FUCommonChildComponent class]], nil);
			});
		});
		
		context(@"adding a unique component that has a non-unique ancestor that itself has a unique ancestor", ^{
			it(@"throws an exception", ^{
				STAssertThrows([gameObject addComponentWithClass:[FUUniqueGrandChildComponent class]], nil);
			});
		});
		
		/*w
		context(@"added a component that is not unique", ^{
			__block FUCommonComponent* component1 = nil;
			__block FUCommonComponent* returnedComponent1 = nil;
			
			beforeEach(^{
				component1 = [FUCommonComponent testComponent];
				[FUCommonComponent setAllocReturnValue:component1];
				returnedComponent1 = (FUCommonComponent*)[gameObject addComponentWithClass:[FUCommonComponent class]];
			});
			
			it(@"initializes a new component", ^{
				expect([component1 wasInitCalled]).to.beTruthy();
				expect([component1 wasAwakeCalled]).to.beTruthy();
			});
			
			it(@"returns the created component", ^{
				expect(returnedComponent1).to.beIdenticalTo(component1);
			});
			
			it(@"has that component", ^{
				NSSet* components = [gameObject allComponents];
				expect(components).to.haveCountOf(1);
				expect(components).to.contain(component1);
			});
			
			context(@"added the superclass component that is unique", ^{
				__block FUTestComponent* component2 = nil;
				__block FUTestComponent* returnedComponent2 = nil;
				
				beforeEach(^{
					component2 = [FUTestComponent testComponent];
					[FUTestComponent setAllocReturnValue:component2];
					returnedComponent2 = (FUTestComponent*)[gameObject addComponentWithClass:[FUTestComponent class]];
				});
				
				it(@"initializes a new component", ^{
					expect([component2 wasInitCalled]).to.beTruthy();
					expect([component2 wasAwakeCalled]).to.beTruthy();
				});
				
				it(@"returns the created component", ^{
					expect(returnedComponent2).to.beIdenticalTo(component2);
				});
				
				it(@"has that component", ^{
					NSSet* components = [gameObject allComponents];
					expect(components).to.haveCountOf(2);
					expect(components).to.contain(component1);
					expect(components).to.contain(component2);
				});
			});
		});

		context(@"added a component that is unique", ^{
			__block FUTestComponent* component1 = nil;
			__block FUTestComponent* returnedComponent1 = nil;
			
			beforeEach(^{
				component1 = [FUTestComponent testComponent];
				[FUTestComponent setAllocReturnValue:component1];
				returnedComponent1 = (FUTestComponent*)[gameObject addComponentWithClass:[FUTestComponent class]];
			});
			
			it(@"initializes a new component", ^{
				expect([component1 wasInitCalled]).to.beTruthy();
				expect([component1 wasAwakeCalled]).to.beTruthy();
			});
			
			it(@"returns the created component", ^{
				expect(returnedComponent1).to.beIdenticalTo(component1);
			});
			
			it(@"has that component", ^{
				NSSet* components = [gameObject allComponents];
				expect(components).to.haveCountOf(1);
				expect(components).to.contain(component1);
			});
			
			context(@"adding a component with the same class", ^{
				it(@"throws an exception", ^{
					STAssertThrows([gameObject addComponentWithClass:[FUTestComponent class]], nil);
				});
			});
			
			context(@"added a second component that requires the current component and another", ^{
				__block FURequireTwoComponent* component2 = nil;
				__block FUComponent* requiredComponent = nil;
				
				beforeEach(^{
					[FUTestComponent setAllocReturnValue:[FUCommonComponent testComponent]]; 
					component2 = (FURequireTwoComponent*)[gameObject addComponentWithClass:[FURequireTwoComponent class]];
					requiredComponent = [gameObject componentWithClass:[FUChildComponent class]];
				});
				
				it(@"creates a new component", ^{
					expect(component2).to.beKindOf([FURequireTwoComponent class]);
				});
				
				it(@"created the required component", ^{
					expect(requiredComponent).toNot.beNil();
				});
				
				it(@"has all three components", ^{
					NSSet* components = [gameObject allComponents];
					expect(components).to.haveCountOf(3);
					expect(components).to.contain(component1);
					expect(components).to.contain(component2);
					expect(components).to.contain(requiredComponent);
				});
				
				context(@"removing the new component", ^{
					beforeEach(^{
						[gameObject removeComponent:component2];
					});
					
					it(@"removes it from the game object", ^{
						NSSet* components = [gameObject allComponents];
						expect(components).to.haveCountOf(2);
						expect(components).to.contain(component1);
						expect(components).to.contain(requiredComponent);
					});
					
					it(@"sets the gameObject property of the component to nil", ^{
						expect([component2 gameObject]).to.beNil();
					});
				});
				
				context(@"removing the first component", ^{
					it(@"throws an exception", ^{
						STAssertThrows([gameObject removeComponent:component1], nil);
					});
				});
				
				context(@"removing the second required component", ^{
					it(@"throws an exception", ^{
						STAssertThrows([gameObject removeComponent:requiredComponent], nil);
					});
				});
			});
			
			context(@"added a second component with a non-unique subclass", ^{
				__block FUCommonComponent* component2 = nil;
				__block FUCommonComponent* returnedComponent2 = nil;
				
				beforeEach(^{
					component2 = [FUCommonComponent testComponent];
					[FUCommonComponent setAllocReturnValue:component2];
					returnedComponent2 = (FUCommonComponent*)[gameObject addComponentWithClass:[FUCommonComponent class]];
				});
				
				it(@"initializes a new component", ^{
					expect([component2 wasInitCalled]).to.beTruthy();
					expect([component2 wasAwakeCalled]).to.beTruthy();
				});
				
				it(@"returns the created component", ^{
					expect(returnedComponent2).to.beIdenticalTo(component2);
				});
				
				it(@"has the 2 components", ^{
					NSSet* components = [gameObject allComponents];
					expect(components).to.haveCountOf(2);
					expect(components).to.contain(component1);
					expect(components).to.contain(component2);
				});
				
				context(@"added a third component with the second non-unique class", ^{
					__block FUCommonComponent* component3 = nil;
					__block FUCommonComponent* returnedComponent3 = nil;
					
					beforeEach(^{
						component3 = [FUCommonComponent testComponent];
						[FUCommonComponent setAllocReturnValue:component3];
						returnedComponent3 = (FUCommonComponent*)[gameObject addComponentWithClass:[FUCommonComponent class]];
					});
					
					it(@"initializes a new component", ^{
						expect([component3 wasInitCalled]).to.beTruthy();
						expect([component3 wasAwakeCalled]).to.beTruthy();
					});
					
					it(@"returns the created component", ^{
						expect(returnedComponent3).to.beIdenticalTo(component3);
					});
					
					it(@"has the 3 components", ^{
						NSSet* components = [gameObject allComponents];
						expect(components).to.haveCountOf(3);
						expect(components).to.contain(component1);
						expect(components).to.contain(component2);
						expect(components).to.contain(component3);
					});
					
					context(@"getting a component with the first class", ^{
						it(@"returns any of the components", ^{
							FUComponent* searchedComponent = [gameObject componentWithClass:[FUTestComponent class]];
							expect((searchedComponent == component1) || (searchedComponent == component2) || (searchedComponent == component3)).to.beTruthy();
						});
					});
					
					context(@"getting a component with the second class", ^{
						it(@"returns any of the last two components", ^{
							FUComponent* searchedComponent = [gameObject componentWithClass:[FUCommonComponent class]];
							expect((searchedComponent == component2) || (searchedComponent == component3)).to.beTruthy();
						});
					});
					
					context(@"getting a component with a different class", ^{
						it(@"returns nil", ^{
							expect([gameObject componentWithClass:[FURequireBaseComponent class]]).to.beNil();
						});
					});
					
					context(@"getting all the components with the first class", ^{
						it(@"returns a set with all components", ^{
							NSSet* components = [gameObject allComponentsWithClass:[FUTestComponent class]];
							expect(components).to.haveCountOf(3);
							expect(components).to.contain(component1);
							expect(components).to.contain(component2);
							expect(components).to.contain(component3);
						});
					});
					
					context(@"getting all the components with the second class", ^{
						it(@"returns a set with the last two components", ^{
							NSSet* components = [gameObject allComponentsWithClass:[FUCommonComponent class]];
							expect(components).to.haveCountOf(2);
							expect(components).to.contain(component2);
							expect(components).to.contain(component3);
						});
					});
					
					context(@"getting all the components with a different class", ^{
						it(@"returns an empty set", ^{
							expect([gameObject allComponentsWithClass:[FURequireBaseComponent class]]).to.beEmpty();
						});
					});
				});
			});
		});
		 */
	});
});

SPEC_END
