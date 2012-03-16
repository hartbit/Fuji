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
#import "FUTestComponent.h"


SPEC_BEGIN(FUGameObjectSpec)

describe(@"A game object", ^{
	context(@"initialized with init", ^{
#ifdef DEBUG
		it(@"throws an exception", ^{
			STAssertThrows([FUGameObject new], nil);
		});
#else
		it(@"returns nil", ^{
			expect([FUGameObject new]).to.beNil();
		});
#endif
	});
	
	context(@"initialized with a nil scene", ^{
#ifdef DEBUG
		it(@"throws an exception", ^{
			STAssertThrows(((void)[[FUGameObject alloc] initWithScene:nil]), nil);
		});
#else
		it(@"returns nil", ^{
			expect([[FUGameObject alloc] initWithScene:nil]).to.beNil();
		});
#endif
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
		
		context(@"adding a component with a NULL class", ^{
#ifdef DEBUG
			it(@"throws an exception", ^{
				STAssertThrows([gameObject addComponentWithClass:NULL], nil);
			});
#else
			it(@"returns nil", ^{
				expect([gameObject addComponentWithClass:NULL]).to.beNil();
			});
#endif
		});
		
		context(@"adding a component with a class that does not subclass FUComponent", ^{
#ifdef DEBUG
			it(@"throws an exception", ^{
				STAssertThrows([gameObject addComponentWithClass:[NSString class]], nil);
			});
#else
			it(@"returns nil", ^{
				expect([gameObject addComponentWithClass:[NSString class]]).to.beNil();
			});
#endif
		});
		
		context(@"adding a component with the FUComponent class", ^{
#ifdef DEBUG
			it(@"throws an exception", ^{
				STAssertThrows([gameObject addComponentWithClass:[FUComponent class]], nil);
			});
#else
			it(@"returns nil", ^{
				expect([gameObject addComponentWithClass:[FUComponent class]]).to.beNil();
			});
#endif
		});
		
		context(@"getting a component with a NULL class", ^{
#ifdef DEBUG
			it(@"throws an exception", ^{
				STAssertThrows([gameObject componentWithClass:NULL], nil);
			});
#else
			it(@"returns nil", ^{
				expect([gameObject componentWithClass:NULL]).to.beNil();
			});
#endif
		});
		
		context(@"getting a component with the FUComponent class", ^{
			it(@"returns nil", ^{
				expect([gameObject componentWithClass:[FUComponent class]]).to.beNil();
			});
		});
		
		context(@"getting all components with a NULL class", ^{
#ifdef DEBUG
			it(@"throws an exception", ^{
				STAssertThrows([gameObject allComponentsWithClass:NULL], nil);
			});
#else
			it(@"returns nil", ^{
				expect([gameObject allComponentsWithClass:NULL]).to.beNil();
			});
#endif
		});
		
		context(@"getting all components with the FUComponent class", ^{
			it(@"returns an empty set", ^{
				expect([gameObject allComponentsWithClass:[FUComponent class]]).to.beEmpty();
			});
		});

		context(@"added a component that is unique", ^{
			__block FUUniqueTestComponent* component1 = nil;
			__block FUUniqueTestComponent* returnedComponent1 = nil;
			
			beforeEach(^{
				component1 = [FUUniqueTestComponent testComponent];
				[FUUniqueTestComponent setAllocReturnValue:component1];
				returnedComponent1 = (FUUniqueTestComponent*)[gameObject addComponentWithClass:[FUUniqueTestComponent class]];
			});
			
			it(@"initializes a new component", ^{
				expect([component1 wasInitCalled]).to.beTruthy();
				expect([component1 wasAwakeCalled]).to.beTruthy();
			});
			
			it(@"returns the created component", ^{
				expect(returnedComponent1).to.beIdenticalTo(component1);
			});
			
			context(@"getting a component with the FUComponent class", ^{
				it(@"returns the component", ^{
					expect([gameObject componentWithClass:[FUComponent class]]).to.beIdenticalTo(component1);
				});
			});
			
			context(@"getting a component with a subclass of that class", ^{
				it(@"returns the component", ^{
					expect([gameObject componentWithClass:[FUTestComponent class]]).to.beIdenticalTo(component1);
				});
			});
			
			context(@"getting a component with the same class", ^{
				it(@"returns the component", ^{
					expect([gameObject componentWithClass:[FUUniqueTestComponent class]]).to.beIdenticalTo(component1);
				});
			});
			
			context(@"getting a component with a different class", ^{
				it(@"returns nil", ^{
					expect([gameObject componentWithClass:[FURequireComponent class]]).to.beNil();
				});
			});
			
			context(@"getting all the components with FUComponent class", ^{
				it(@"returns a set with the component", ^{
					NSSet* components = [gameObject allComponentsWithClass:[FUComponent class]];
					expect(components).to.haveCountOf(1);
					expect(components).to.contain(component1);
				});
			});
			
			context(@"getting all the components with a subclass of that class", ^{
				it(@"returns a set with the component", ^{
					NSSet* components = [gameObject allComponentsWithClass:[FUTestComponent class]];
					expect(components).to.haveCountOf(1);
					expect(components).to.contain(component1);
				});
			});
			
			context(@"getting all the components with the same class", ^{
				it(@"returns a set with the component", ^{
					NSSet* components = [gameObject allComponentsWithClass:[FUUniqueTestComponent class]];
					expect(components).to.haveCountOf(1);
					expect(components).to.contain(component1);
				});
			});
			
			context(@"getting all the components with a different class", ^{
				it(@"returns an empty set", ^{
					expect([gameObject allComponentsWithClass:[FURequireComponent class]]).to.beEmpty();
				});
			});
			
			context(@"adding a second component with the same unique class", ^{
#ifdef DEBUG
				it(@"throws on exception", ^{
					STAssertThrows([gameObject addComponentWithClass:[FUUniqueTestComponent class]], nil);
				});
#else
				it(@"returns nil", ^{
					FUComponent* component = [gameObject addComponentWithClass:[FUUniqueTestComponent class]];
					expect(component).to.beNil();
				});
#endif
			});
			
			context(@"added a second component with a the non-unique subclass", ^{
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
				
				context(@"getting a component with the FUComponent class", ^{
					it(@"returns any of the components", ^{
						FUComponent* searchedComponent = [gameObject componentWithClass:[FUComponent class]];
						expect((searchedComponent == component1) || (searchedComponent == component2)).to.beTruthy();
					});
				});
				
				context(@"getting a component with the second class", ^{
					it(@"returns any of the components", ^{
						FUComponent* searchedComponent = [gameObject componentWithClass:[FUTestComponent class]];
						expect((searchedComponent == component1) || (searchedComponent == component2)).to.beTruthy();
					});
				});
				
				context(@"getting a component with the first class", ^{
					it(@"returns the first component", ^{
						expect([gameObject componentWithClass:[FUUniqueTestComponent class]]).to.beIdenticalTo(component1);
					});
				});
				
				context(@"getting a component with a different class", ^{
					it(@"returns nil", ^{
						expect([gameObject componentWithClass:[FURequireComponent class]]).to.beNil();
					});
				});
				
				context(@"getting all the components with FUComponent class", ^{
					it(@"returns a set with both components", ^{
						NSSet* components = [gameObject allComponentsWithClass:[FUComponent class]];
						expect(components).to.haveCountOf(2);
						expect(components).to.contain(component1);
						expect(components).to.contain(component2);
					});
				});
				
				context(@"getting all the components with the second class", ^{
					it(@"returns a set with both components", ^{
						NSSet* components = [gameObject allComponentsWithClass:[FUTestComponent class]];
						expect(components).to.haveCountOf(2);
						expect(components).to.contain(component1);
						expect(components).to.contain(component2);
					});
				});
				
				context(@"getting all the components with the first class", ^{
					it(@"returns a set with the first component", ^{
						NSSet* components = [gameObject allComponentsWithClass:[FUUniqueTestComponent class]];
						expect(components).to.haveCountOf(1);
						expect(components).to.contain(component1);
					});
				});
				
				context(@"getting all the components with a different class", ^{
					it(@"returns an empty set", ^{
						expect([gameObject allComponentsWithClass:[FURequireComponent class]]).to.beEmpty();
					});
				});
				
				context(@"added a third component with the second non-unique class", ^{
					__block FUTestComponent* component3 = nil;
					__block FUTestComponent* returnedComponent3 = nil;
					
					beforeEach(^{
						component3 = [FUTestComponent testComponent];
						[FUTestComponent setAllocReturnValue:component3];
						returnedComponent3 = (FUTestComponent*)[gameObject addComponentWithClass:[FUTestComponent class]];
					});
					
					it(@"initializes a new component", ^{
						expect([component3 wasInitCalled]).to.beTruthy();
						expect([component3 wasAwakeCalled]).to.beTruthy();
					});
					
					it(@"returns the created component", ^{
						expect(returnedComponent3).to.beIdenticalTo(component3);
					});
				});
			});
		});
	});
});

SPEC_END
