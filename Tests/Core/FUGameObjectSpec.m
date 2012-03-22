//
//  FUGameObjectSpec.m
//  Fuji
//
//  Created by Hart David on 24.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#include "Prefix.pch"
#import "Fuji.h"
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
		
		it(@"has a transform component", ^{
			FUTransform* transform = [gameObject componentWithClass:[FUTransform class]];
			expect(transform).toNot.beNil();
			
			NSSet* components = [gameObject allComponents];
			expect(components).to.haveCountOf(1);
			expect(components).to.contain(transform);
		});
		
		it(@"the transform property returns the transform component", ^{
			FUTransform* transform = [gameObject componentWithClass:[FUTransform class]];
			expect([gameObject transform]).to.beIdenticalTo(transform);
		});
		
		context(@"removing the transform component", ^{
			it(@"has the transform property to nil", ^{
				FUTransform* transform = [gameObject componentWithClass:[FUTransform class]];
				[gameObject removeComponent:transform];
				expect([gameObject transform]).to.beNil();
			});
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
		
		context(@"adding a component who's subclass requires an invalid component class", ^{
			it(@"throws an exception", ^{
				STAssertThrows([gameObject addComponentWithClass:[FURequireInvalidSuperclassComponent class]], nil);
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
				STAssertThrows([gameObject removeComponent:mock([FUComponent class])], nil);
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
		
		context(@"added a unique component", ^{
			__block FUUniqueChild1Component* component1 = nil;
			
			beforeEach(^{
				component1 = [gameObject addComponentWithClass:[FUUniqueChild1Component class]];
			});
			
			it(@"initializes a new component", ^{
				expect(component1).toNot.beNil();
				expect([component1 wasInitCalled]).to.beTruthy();
				expect([component1 wasAwakeCalled]).to.beTruthy();
			});
			
			it(@"has that component", ^{
				NSSet* components = [gameObject allComponents];
				expect(components).to.haveCountOf(2);
				expect(components).to.contain(component1);
			});
			
			context(@"adding the same component", ^{
				it(@"throws an exception", ^{
					STAssertThrows([gameObject addComponentWithClass:[FUUniqueChild1Component class]], nil);
				});
			});
			
			context(@"adding a unique ancestor component", ^{
				it(@"throws an exception", ^{
					STAssertThrows([gameObject addComponentWithClass:[FUUniqueParentComponent class]], nil);
				});
			});
			
			context(@"adding a sibling that has the same unique ancestor component", ^{
				it(@"throws an exception", ^{
					STAssertThrows([gameObject addComponentWithClass:[FUUniqueChild2Component class]], nil);
				});
			});
			
			context(@"added a non-unique component", ^{
				__block FUTestComponent* component2 = nil;
				
				beforeEach(^{
					component2 = [gameObject addComponentWithClass:[FUTestComponent class]];
				});
				
				it(@"initializes a new component", ^{
					expect([component2 wasInitCalled]).to.beTruthy();
					expect([component2 wasAwakeCalled]).to.beTruthy();
				});
				
				it(@"has both components", ^{
					NSSet* components = [gameObject allComponents];
					expect(components).to.haveCountOf(3);
					expect(components).to.contain(component1);
					expect(components).to.contain(component2);
				});
			});
			
			context(@"added a component that requires the unique parent component and another one", ^{
				__block FURequireRequiredComponent* component2 = nil;
				__block FURequiredComponent* component3 = nil;
				
				beforeEach(^{
					component2 = [gameObject addComponentWithClass:[FURequireRequiredComponent class]];
					component3 = [gameObject componentWithClass:[FURequiredComponent class]];
				});
				
				it(@"initializes a new component", ^{
					expect([component2 wasInitCalled]).to.beTruthy();
					expect([component2 wasAwakeCalled]).to.beTruthy();
				});
				
				it(@"has three components, including both explicitely created", ^{
					NSSet* components = [gameObject allComponents];
					expect(components).to.haveCountOf(4);
					expect(components).to.contain(component1);
					expect(components).to.contain(component2);
				});
				
				it(@"had implicitely created the second required component", ^{
					expect([component3 class]).to.beIdenticalTo([FURequiredComponent class]);
					expect([component3 wasInitCalled]).to.beTruthy();
					expect([component3 wasAwakeCalled]).to.beTruthy();
					expect([gameObject allComponents]).to.contain(component3);
				});
				
				context(@"getting a component with a common ancestor of all components", ^{
					it(@"returns any of the components", ^{
						FUComponent* searchedComponent = [gameObject componentWithClass:[FUTestComponent class]];
						expect((searchedComponent == component1) || (searchedComponent == component2) || (searchedComponent == component3)).to.beTruthy();
					});
				});
				
				context(@"getting a component with a common ancestor of the last two components", ^{
					it(@"returns any of the last two components", ^{
						FUComponent* searchedComponent = [gameObject componentWithClass:[FUCommonParentComponent class]];
						expect((searchedComponent == component2) || (searchedComponent == component3)).to.beTruthy();
					});
				});
				
				context(@"getting a component with the first class", ^{
					it(@"returns the first component", ^{
						FUComponent* component = [gameObject componentWithClass:[FUUniqueChild1Component class]];
						expect(component).to.beIdenticalTo(component1);
					});
				});
				
				context(@"getting all the components with a common ancestor of all components", ^{
					it(@"returns a set with all components", ^{
						NSSet* components = [gameObject allComponentsWithClass:[FUTestComponent class]];
						expect(components).to.haveCountOf(3);
						expect(components).to.contain(component1);
						expect(components).to.contain(component2);
						expect(components).to.contain(component3);
					});
				});
				
				context(@"getting all the components with a common ancestor of the last two components", ^{
					it(@"returns a set with the last two components", ^{
						NSSet* components = [gameObject allComponentsWithClass:[FUCommonParentComponent class]];
						expect(components).to.haveCountOf(2);
						expect(components).to.contain(component2);
						expect(components).to.contain(component3);
					});
				});
				
				context(@"getting all the components with the second class", ^{
					it(@"returns the second class", ^{
						FUComponent* component = [gameObject componentWithClass:[FURequireRequiredComponent class]];
						expect(component).to.beIdenticalTo(component2);
					});
				});
				
				context(@"removing the new component", ^{
					beforeEach(^{
						[gameObject removeComponent:component2];
					});
					
					it(@"removes it from the game object", ^{
						NSSet* components = [gameObject allComponents];
						expect(components).to.haveCountOf(3);
						expect(components).to.contain(component1);
						expect(components).to.contain(component3);
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
						STAssertThrows([gameObject removeComponent:component3], nil);
					});
				});
			});
		});
	});
});

SPEC_END
