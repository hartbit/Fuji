//
//  FUEntitySpec.m
//  Fuji
//
//  Created by Hart David on 24.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#include "Prefix.pch"
#import "Fuji.h"
#import "FUEntity-Internal.h"
#import "FUComponent-Internal.h"
#import "FUTestComponents.h"


SPEC_BEGIN(FUEntitySpec)

describe(@"A game object", ^{
	context(@"initialized with init", ^{
		it(@"throws an exception", ^{
			STAssertThrows([FUEntity new], nil);
		});
	});
	
	context(@"initialized with a nil scene", ^{
		it(@"throws an exception", ^{
			STAssertThrows((void)[[FUEntity alloc] initWithScene:nil], nil);
		});
	});
	
	context(@"initialized with a valid scene", ^{
		__block FUScene* scene = nil;
		__block FUEntity* entity = nil;
		
		beforeEach(^{
			scene = mock([FUScene class]);
			entity = [[FUEntity alloc] initWithScene:scene];
		});
		
		it(@"is not nil", ^{
			expect(entity).toNot.beNil();
		});
		
		it(@"has the scene property set", ^{
			expect([entity scene]).to.beIdenticalTo(scene);
		});
		
		it(@"has a transform component", ^{
			FUTransform* transform = [entity componentWithClass:[FUTransform class]];
			expect(transform).toNot.beNil();
			
			NSSet* components = [entity allComponents];
			expect(components).to.haveCountOf(1);
			expect(components).to.contain(transform);
		});
		
		it(@"the transform property returns the transform component", ^{
			FUTransform* transform = [entity componentWithClass:[FUTransform class]];
			expect([entity transform]).to.beIdenticalTo(transform);
		});
		
		context(@"removing the transform component", ^{
			it(@"has the transform property to nil", ^{
				FUTransform* transform = [entity componentWithClass:[FUTransform class]];
				[entity removeComponent:transform];
				expect([entity transform]).to.beNil();
			});
		});
		
		context(@"adding a component with a NULL class", ^{
			it(@"throws an exception", ^{
				STAssertThrows([entity addComponentWithClass:NULL], nil);
			});
		});
		
		context(@"adding a component with a class that does not subclass FUComponent", ^{
			it(@"throws an exception", ^{
				STAssertThrows([entity addComponentWithClass:[NSString class]], nil);
			});
		});
		
		context(@"adding a component with the FUComponent class", ^{
			it(@"throws an exception", ^{
				STAssertThrows([entity addComponentWithClass:[FUComponent class]], nil);
			});
		});
		
		context(@"adding a component that requires an object that is not a class", ^{
			it(@"throws an exception", ^{
				STAssertThrows([entity addComponentWithClass:[FURequireObjectComponent class]], nil);
			});
		});
		
		context(@"adding a component who's subclass requires an invalid component class", ^{
			it(@"throws an exception", ^{
				STAssertThrows([entity addComponentWithClass:[FURequireInvalidSuperclassComponent class]], nil);
			});
		});
		
		context(@"adding a component that requires a class that does not subclass FUComponent", ^{
			it(@"throws an exception", ^{
				STAssertThrows([entity addComponentWithClass:[FURequireNSStringComponent class]], nil);
			});
		});
		
		context(@"adding a component that requires a FUComponent", ^{
			it(@"throws an exception", ^{
				STAssertThrows([entity addComponentWithClass:[FURequireBaseComponent class]], nil);
			});
		});
		
		context(@"adding a component that requires itself", ^{
			it(@"throws an exception", ^{
				STAssertThrows([entity addComponentWithClass:[FURequireItselfComponent class]], nil);
			});
		});

		context(@"adding a component that requires a subclass of itself", ^{
			it(@"throws an exception", ^{
				STAssertThrows([entity addComponentWithClass:[FURequireSubclassComponent class]], nil);
			});
		});
		
		context(@"adding a component that requires relatives", ^{
			it(@"throws an exception", ^{
				STAssertThrows([entity addComponentWithClass:[FURequireRelativesComponent class]], nil);
			});
		});
		
		context(@"removing a nil component", ^{
			it(@"throws an exception", ^{
				STAssertThrows([entity removeComponent:nil], nil);
			});
		});
		
		context(@"removing a component that does not exist", ^{
			it(@"throws an exception", ^{
				STAssertThrows([entity removeComponent:mock([FUComponent class])], nil);
			});
		});
		
		context(@"getting a component with a NULL class", ^{
			it(@"throws an exception", ^{
				STAssertThrows([entity componentWithClass:NULL], nil);
			});
		});
		
		context(@"getting a component with the FUComponent class", ^{
			it(@"throws an exception", ^{
				STAssertThrows([entity componentWithClass:[FUComponent class]], nil);
			});
		});
		
		context(@"getting a component with a subclass of FUComponent", ^{
			it(@"returns nil", ^{
				expect([entity componentWithClass:[FUTestComponent class]]).to.beNil();
			});
		});
		
		context(@"getting all components with a NULL class", ^{
			it(@"throws an exception", ^{
				STAssertThrows([entity allComponentsWithClass:NULL], nil);
			});
		});
		
		context(@"getting all components with the FUComponent class", ^{
			it(@"throws an exception", ^{
				STAssertThrows([entity allComponentsWithClass:[FUComponent class]], nil);
			});
		});
		
		context(@"getting all components with a subclass of FUComponent", ^{
			it(@"returns an empty set", ^{
				expect([entity allComponentsWithClass:[FUTestComponent class]]).to.beEmpty();
			});
		});
		
		context(@"adding a non-unique component that has a unique ancestor", ^{
			it(@"throws an exception", ^{
				STAssertThrows([entity addComponentWithClass:[FUCommonChildComponent class]], nil);
			});
		});
		
		context(@"adding a unique component that has a non-unique ancestor that itself has a unique ancestor", ^{
			it(@"throws an exception", ^{
				STAssertThrows([entity addComponentWithClass:[FUUniqueGrandChildComponent class]], nil);
			});
		});
		
		context(@"added a unique component", ^{
			__block FUUniqueChild1Component* component1 = nil;
			
			beforeEach(^{
				component1 = [entity addComponentWithClass:[FUUniqueChild1Component class]];
			});
			
			it(@"initializes a new component", ^{
				expect(component1).toNot.beNil();
				expect([component1 wasInitCalled]).to.beTruthy();
			});
			
			it(@"has that component", ^{
				NSSet* components = [entity allComponents];
				expect(components).to.haveCountOf(2);
				expect(components).to.contain(component1);
			});
			
			context(@"adding the same component", ^{
				it(@"throws an exception", ^{
					STAssertThrows([entity addComponentWithClass:[FUUniqueChild1Component class]], nil);
				});
			});
			
			context(@"adding a unique ancestor component", ^{
				it(@"throws an exception", ^{
					STAssertThrows([entity addComponentWithClass:[FUUniqueParentComponent class]], nil);
				});
			});
			
			context(@"adding a sibling that has the same unique ancestor component", ^{
				it(@"throws an exception", ^{
					STAssertThrows([entity addComponentWithClass:[FUUniqueChild2Component class]], nil);
				});
			});
			
			context(@"added a non-unique component", ^{
				__block FUTestComponent* component2 = nil;
				
				beforeEach(^{
					component2 = [entity addComponentWithClass:[FUTestComponent class]];
				});
				
				it(@"initializes a new component", ^{
					expect([component2 wasInitCalled]).to.beTruthy();
				});
				
				it(@"has both components", ^{
					NSSet* components = [entity allComponents];
					expect(components).to.haveCountOf(3);
					expect(components).to.contain(component1);
					expect(components).to.contain(component2);
				});
			});
			
			context(@"added a component that requires the unique parent component and another one", ^{
				__block FURequireRequiredComponent* component2 = nil;
				__block FURequiredComponent* component3 = nil;
				
				beforeEach(^{
					component2 = [entity addComponentWithClass:[FURequireRequiredComponent class]];
					component3 = [entity componentWithClass:[FURequiredComponent class]];
				});
				
				it(@"initializes a new component", ^{
					expect([component2 wasInitCalled]).to.beTruthy();
				});
				
				it(@"has three components, including both explicitely created", ^{
					NSSet* components = [entity allComponents];
					expect(components).to.haveCountOf(4);
					expect(components).to.contain(component1);
					expect(components).to.contain(component2);
				});
				
				it(@"had implicitely created the second required component", ^{
					expect([component3 class]).to.beIdenticalTo([FURequiredComponent class]);
					expect([component3 wasInitCalled]).to.beTruthy();
					expect([entity allComponents]).to.contain(component3);
				});
				
				context(@"getting a component with a common ancestor of all components", ^{
					it(@"returns any of the components", ^{
						FUComponent* searchedComponent = [entity componentWithClass:[FUTestComponent class]];
						expect((searchedComponent == component1) || (searchedComponent == component2) || (searchedComponent == component3)).to.beTruthy();
					});
				});
				
				context(@"getting a component with a common ancestor of the last two components", ^{
					it(@"returns any of the last two components", ^{
						FUComponent* searchedComponent = [entity componentWithClass:[FUCommonParentComponent class]];
						expect((searchedComponent == component2) || (searchedComponent == component3)).to.beTruthy();
					});
				});
				
				context(@"getting a component with the first class", ^{
					it(@"returns the first component", ^{
						FUComponent* component = [entity componentWithClass:[FUUniqueChild1Component class]];
						expect(component).to.beIdenticalTo(component1);
					});
				});
				
				context(@"getting all the components with a common ancestor of all components", ^{
					it(@"returns a set with all components", ^{
						NSSet* components = [entity allComponentsWithClass:[FUTestComponent class]];
						expect(components).to.haveCountOf(3);
						expect(components).to.contain(component1);
						expect(components).to.contain(component2);
						expect(components).to.contain(component3);
					});
				});
				
				context(@"getting all the components with a common ancestor of the last two components", ^{
					it(@"returns a set with the last two components", ^{
						NSSet* components = [entity allComponentsWithClass:[FUCommonParentComponent class]];
						expect(components).to.haveCountOf(2);
						expect(components).to.contain(component2);
						expect(components).to.contain(component3);
					});
				});
				
				context(@"getting all the components with the second class", ^{
					it(@"returns the second class", ^{
						FUComponent* component = [entity componentWithClass:[FURequireRequiredComponent class]];
						expect(component).to.beIdenticalTo(component2);
					});
				});
				
				context(@"removing the new component", ^{
					beforeEach(^{
						[entity removeComponent:component2];
					});
					
					it(@"removes it from the game object", ^{
						NSSet* components = [entity allComponents];
						expect(components).to.haveCountOf(3);
						expect(components).to.contain(component1);
						expect(components).to.contain(component3);
					});
					
					it(@"sets the entity property of the component to nil", ^{
						expect([component2 entity]).to.beNil();
					});
				});
				
				context(@"removing the first component", ^{
					it(@"throws an exception", ^{
						STAssertThrows([entity removeComponent:component1], nil);
					});
				});
				
				context(@"removing the second required component", ^{
					it(@"throws an exception", ^{
						STAssertThrows([entity removeComponent:component3], nil);
					});
				});
			});
		});
	});
});

SPEC_END
