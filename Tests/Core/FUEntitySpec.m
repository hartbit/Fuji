//
//  FUEntitySpec.m
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
#import "FUDirector-Internal.h"
#import "FUSceneObject-Internal.h"
#import "FUComponent-Internal.h"
#import "FUTestSupport.h"


static NSString* const FUComponentAncestoryInvalidMessage = @"A non-unique 'component=%@' has a unique parent 'component=%@'";
static NSString* const FUComponentClassInvalidMessage = @"Expected 'componentClass=%@' to be a subclass of FUComponent (excluded)";
static NSString* const FUComponentUniqueAndExistsMessage = @"The 'componentClass=%@' is unique and another component of that class already exists";
static NSString* const FUComponentNilMessage = @"Expected 'component' to not be nil";
static NSString* const FUComponentNonexistentMessage = @"Can not remove a 'component=%@' that does not exist";
static NSString* const FURequiredComponentTypeMessage = @"Expected 'requiredComponent=%@' to be of type Class";
static NSString* const FURequiredComponentSuperclassMessage = @"The 'requiredComponent=%@' can not be the same class or a superclass of added 'componentClass=%@'";
static NSString* const FURequiredComponentSubclassMessage = @"The 'requiredComponent=%@' can not be the same class or a subclass of other 'requiredComponent=%@'";
static NSString* const FUComponentRequiredMessage = @"Can not remove 'component=%@' because it is required by another 'component=%@'.";


@interface FUTestEntity : FUEntity @end

@interface FUTestComponent : FUComponent
@property (nonatomic, readonly) BOOL wasInitCalled;
@end

@interface FUUniqueParentComponent : FUTestComponent @end
@interface FUUniqueChild1Component : FUUniqueParentComponent @end
@interface FUUniqueChild2Component : FUUniqueParentComponent @end
@interface FUCommonChildComponent : FUUniqueParentComponent @end
@interface FUUniqueGrandChildComponent : FUCommonChildComponent @end

@interface FURequireObjectComponent : FUTestComponent @end
@interface FURequireInvalidSuperclassComponent : FURequireObjectComponent @end
@interface FURequireNSStringComponent : FUTestComponent @end
@interface FURequireBaseComponent : FUTestComponent @end
@interface FURequireItselfComponent : FUTestComponent @end
@interface FURequireSubclassComponent : FUTestComponent @end
@interface FURequireRelativesComponent : FUTestComponent @end

@interface FUCommonParentComponent : FUTestComponent @end
@interface FURequireUniqueParentComponent : FUCommonParentComponent @end
@interface FURequireRequiredComponent : FURequireUniqueParentComponent @end
@interface FURequiredComponent : FUCommonParentComponent @end


SPEC_BEGIN(FUEntity)

describe(@"An entity", ^{
	it(@"is a scene object", ^{
		expect([FUEntity class]).to.beSubclassOf([FUSceneObject class]);
	});
	
	it(@"can react to interface rotations", ^{
		expect([[FUEntity class] conformsToProtocol:@protocol(FUInterfaceRotating)]).to.beTruthy();
	});
	
	context(@"initialized with a valid scene", ^{
		__block FUDirector* director;
		__block FUScene* scene;
		__block FUEntity* entity;
		
		beforeEach(^{
			director = mock([FUDirector class]);
			scene = mock([FUScene class]);
			[given([scene director]) willReturn:director];
			entity = [[FUEntity alloc] initWithScene:scene];
		});
		
		it(@"has a transform component", ^{
			FUTransform* transform = [entity componentWithClass:[FUTransform class]];
			expect(transform).toNot.beNil();
			
			NSArray* components = [entity allComponents];
			expect(components).to.contain(transform);
		});
		
		it(@"the transform property returns the transform component", ^{
			FUTransform* transform = [entity componentWithClass:[FUTransform class]];
			expect([entity transform]).to.beIdenticalTo(transform);
		});
		
		it(@"the renderer property returns nil", ^{
			expect([entity componentWithClass:[FURenderer class]]).to.beNil();
		});
		
		context(@"adding a renderer", ^{
			it(@"the renderer property returns the renderer", ^{
				FURenderer* renderer = [entity addComponentWithClass:[FURenderer class]];
				expect(renderer).toNot.beNil();
				expect([entity renderer]).to.beIdenticalTo(renderer);
			});
		});
		
		it(@"does not register the transform component", ^{
			[verifyCount(director, never()) didAddSceneObject:[entity transform]];
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
				assertThrows([entity addComponentWithClass:NULL], NSInvalidArgumentException, FUComponentClassInvalidMessage, NSStringFromClass(NULL));
			});
		});
		
		context(@"adding a component with a class that does not subclass FUComponent", ^{
			it(@"throws an exception", ^{
				assertThrows([entity addComponentWithClass:[NSString class]], NSInvalidArgumentException, FUComponentClassInvalidMessage, NSStringFromClass([NSString class]));
			});
		});
		
		context(@"adding a component with the FUComponent class", ^{
			it(@"throws an exception", ^{
				assertThrows([entity addComponentWithClass:[FUComponent class]], NSInvalidArgumentException, FUComponentClassInvalidMessage, NSStringFromClass([FUComponent class]));
			});
		});
		
		context(@"adding a component that requires an object that is not a class", ^{
			it(@"throws an exception", ^{
				assertThrows([entity addComponentWithClass:[FURequireObjectComponent class]], NSInvalidArgumentException, FURequiredComponentTypeMessage, NSStringFromClass([NSString string]));
			});
		});
		
		context(@"adding a component who's superclass requires an invalid component class", ^{
			it(@"throws an exception", ^{
				assertThrows([entity addComponentWithClass:[FURequireInvalidSuperclassComponent class]], NSInvalidArgumentException, FURequiredComponentTypeMessage, NSStringFromClass([NSString string]));
			});
		});
		
		context(@"adding a component that requires a class that does not subclass FUComponent", ^{
			it(@"throws an exception", ^{
				assertThrows([entity addComponentWithClass:[FURequireNSStringComponent class]], NSInvalidArgumentException, FUComponentClassInvalidMessage, NSStringFromClass([NSString class]));
			});
		});
		
		context(@"adding a component that requires a FUComponent", ^{
			it(@"throws an exception", ^{
				assertThrows([entity addComponentWithClass:[FURequireBaseComponent class]], NSInvalidArgumentException, FURequiredComponentSuperclassMessage, NSStringFromClass([FUComponent class]), NSStringFromClass([FURequireBaseComponent class]));
			});
		});
		
		context(@"adding a component that requires itself", ^{
			it(@"throws an exception", ^{
				assertThrows([entity addComponentWithClass:[FURequireItselfComponent class]], NSInvalidArgumentException, FURequiredComponentSuperclassMessage, NSStringFromClass([FURequireItselfComponent class]), NSStringFromClass([FURequireItselfComponent class]));
			});
		});

		context(@"adding a component that requires a subclass of itself", ^{
			it(@"throws an exception", ^{
				assertThrows([entity addComponentWithClass:[FURequireSubclassComponent class]], NSInvalidArgumentException, FURequiredComponentSuperclassMessage, NSStringFromClass([FUTestComponent class]), NSStringFromClass([FURequireSubclassComponent class]));
			});
		});
		
		context(@"adding a component that requires relatives", ^{
			it(@"throws an exception", ^{
				assertThrows([entity addComponentWithClass:[FURequireRelativesComponent class]], NSInvalidArgumentException, FURequiredComponentSubclassMessage, NSStringFromClass([FUUniqueChild1Component class]), NSStringFromClass([FURequireRelativesComponent class]));
			});
		});
		
		context(@"removing a nil component", ^{
			it(@"throws an exception", ^{
				assertThrows([entity removeComponent:nil], NSInvalidArgumentException, FUComponentNilMessage);
			});
		});
		
		context(@"removing a component that does not exist", ^{
			it(@"throws an exception", ^{
				id component = mock([FUComponent class]);
				assertThrows([entity removeComponent:component], NSInvalidArgumentException, FUComponentNonexistentMessage, component);
			});
		});
		
		context(@"getting a component with a NULL class", ^{
			it(@"throws an exception", ^{
				assertThrows([entity componentWithClass:NULL], NSInvalidArgumentException, FUComponentClassInvalidMessage, NSStringFromClass(NULL));
			});
		});
		
		context(@"getting a component with the FUComponent class", ^{
			it(@"throws an exception", ^{
				assertThrows([entity componentWithClass:[FUComponent class]], NSInvalidArgumentException, FUComponentClassInvalidMessage, NSStringFromClass([FUComponent class]));
			});
		});
		
		context(@"getting a component with a subclass of FUComponent", ^{
			it(@"returns nil", ^{
				expect([entity componentWithClass:[FUTestComponent class]]).to.beNil();
			});
		});
		
		context(@"getting all components with a NULL class", ^{
			it(@"throws an exception", ^{
				assertThrows([entity allComponentsWithClass:NULL], NSInvalidArgumentException, FUComponentClassInvalidMessage, NSStringFromClass(NULL));
			});
		});
		
		context(@"getting all components with the FUComponent class", ^{
			it(@"throws an exception", ^{
				assertThrows([entity allComponentsWithClass:[FUComponent class]], NSInvalidArgumentException, FUComponentClassInvalidMessage, NSStringFromClass([FUComponent class]));
			});
		});
		
		context(@"getting all components with a subclass of FUComponent", ^{
			it(@"returns an empty set", ^{
				expect([entity allComponentsWithClass:[FUTestComponent class]]).to.beEmpty();
			});
		});
		
		context(@"adding a non-unique component that has a unique ancestor", ^{
			it(@"throws an exception", ^{
				assertThrows([entity addComponentWithClass:[FUCommonChildComponent class]], NSInvalidArgumentException, FUComponentAncestoryInvalidMessage, NSStringFromClass([FUCommonChildComponent class]), NSStringFromClass([FUUniqueParentComponent class]));
			});
		});
		
		context(@"adding a unique component that has a non-unique ancestor that itself has a unique ancestor", ^{
			it(@"throws an exception", ^{
				assertThrows([entity addComponentWithClass:[FUUniqueGrandChildComponent class]], NSInvalidArgumentException, FUComponentAncestoryInvalidMessage, NSStringFromClass([FUCommonChildComponent class]), NSStringFromClass([FUUniqueParentComponent class]));
			});
		});

		context(@"accepting a visitor", ^{
			it(@"visits the entity and it's components", ^{
				FUVisitor* visitor = mock([FUVisitor class]);
				[entity acceptVisitor:visitor];
				[verify(visitor) visitSceneObject:entity];
				[verify(visitor) visitSceneObject:[entity transform]];
			});
		});
		
		context(@"added a unique component", ^{
			__block FUUniqueChild1Component* component1;
			
			beforeEach(^{
				component1 = [entity addComponentWithClass:[FUUniqueChild1Component class]];
			});
			
			it(@"initializes a new component", ^{
				expect(component1).toNot.beNil();
				expect([component1 wasInitCalled]).to.beTruthy();
				expect([component1 scene]).to.beIdenticalTo(scene);
			});
			
			it(@"registers the component with the director", ^{
				[verify(director) didAddSceneObject:component1];
			});
			
			it(@"has that component", ^{
				NSArray* components = [entity allComponents];
				expect(components).to.contain(component1);
			});
			
			context(@"adding the same component", ^{
				it(@"throws an exception", ^{
					assertThrows([entity addComponentWithClass:[FUUniqueChild1Component class]], NSInvalidArgumentException, FUComponentUniqueAndExistsMessage, NSStringFromClass([FUUniqueChild1Component class]));
				});
			});
			
			context(@"adding a unique ancestor component", ^{
				it(@"throws an exception", ^{
					assertThrows([entity addComponentWithClass:[FUUniqueParentComponent class]], NSInvalidArgumentException, FUComponentUniqueAndExistsMessage, NSStringFromClass([FUUniqueParentComponent class]));
				});
			});
			
			context(@"adding a sibling that has the same unique ancestor component", ^{
				it(@"throws an exception", ^{
					assertThrows([entity addComponentWithClass:[FUUniqueChild2Component class]], NSInvalidArgumentException, FUComponentUniqueAndExistsMessage, NSStringFromClass([FUUniqueChild2Component class]));
				});
			});
			
			context(@"added a non-unique component", ^{
				__block FUTestComponent* component2;
				
				beforeEach(^{
					component2 = [entity addComponentWithClass:[FUTestComponent class]];
				});
				
				it(@"initializes a new component", ^{
					expect([component2 wasInitCalled]).to.beTruthy();
				});
				
				it(@"registers the new component with the director", ^{
					[verify(director) didAddSceneObject:component2];
				});
				
				it(@"has both components", ^{
					NSArray* components = [entity allComponents];
					expect(components).to.contain(component1);
					expect(components).to.contain(component2);
				});
			});
			
			context(@"added a component that requires the unique parent component and another one", ^{
				__block FURequireRequiredComponent* component2;
				__block FURequiredComponent* component3;
				
				beforeEach(^{
					component2 = [entity addComponentWithClass:[FURequireRequiredComponent class]];
					component3 = [entity componentWithClass:[FURequiredComponent class]];
				});
				
				it(@"initializes a new component", ^{
					expect([component2 wasInitCalled]).to.beTruthy();
					expect([component2 scene]).to.beIdenticalTo(scene);
				});
				
				it(@"registers the new component with the director", ^{
					[verify(director) didAddSceneObject:component2];
				});
				
				it(@"has three components, including both explicitely created", ^{
					NSArray* components = [entity allComponents];
					expect(components).to.contain(component1);
					expect(components).to.contain(component2);
				});
				
				it(@"had implicitely created the second required component", ^{
					expect([component3 class]).to.beIdenticalTo([FURequiredComponent class]);
					expect([component3 wasInitCalled]).to.beTruthy();
					expect([component3 scene]).to.beIdenticalTo(scene);
					expect([entity allComponents]).to.contain(component3);
				});
				
				it(@"registers the implicit component with the director", ^{
					[verify(director) didAddSceneObject:component3];
				});
				
				it(@"has not registered the first component", ^{
					[verify(director) didAddSceneObject:component1];
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
						NSArray* components = [entity allComponentsWithClass:[FUTestComponent class]];
						expect(components).to.contain(component1);
						expect(components).to.contain(component2);
						expect(components).to.contain(component3);
					});
				});
				
				context(@"getting all the components with a common ancestor of the last two components", ^{
					it(@"returns a set with the last two components", ^{
						NSArray* components = [entity allComponentsWithClass:[FUCommonParentComponent class]];
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
					
					it(@"removes it from the entity", ^{
						NSArray* components = [entity allComponents];
						expect(components).to.contain(component1);
						expect(components).to.contain(component3);
					});
					
					it(@"sets the entity property of the component to nil", ^{
						expect([component2 entity]).to.beNil();
					});
					
					it(@"unregistered the component", ^{
						[verify(director) willRemoveSceneObject:component2];
					});
				});
				
				context(@"removing the first component", ^{
					it(@"throws an exception", ^{
						assertThrows([entity removeComponent:component1], NSInternalInconsistencyException, FUComponentRequiredMessage, component1, component2);
					});
				});
				
				context(@"removing the second required component", ^{
					it(@"throws an exception", ^{
						assertThrows([entity removeComponent:component3], NSInternalInconsistencyException, FUComponentRequiredMessage, component3, component2);
					});
				});
			});
		});
	});
	
	context(@"initialized a test entity", ^{
		__block FUTestEntity* entity;
		
		beforeEach(^{
			entity = [[FUTestEntity alloc] initWithScene:mock([FUScene class])];
		});
			
		context(@"adding a mock component", ^{
			__block FUComponent* component;
				
			beforeEach(^{
				component = [entity addComponentWithClass:[FUComponent class]];
			});
				
			context(@"calling the rotation methods", ^{
				it(@"called the rotation methods on it's entity", ^{
					[entity willRotateToInterfaceOrientation:UIInterfaceOrientationPortrait duration:1];
					[verify(component) willRotateToInterfaceOrientation:UIInterfaceOrientationPortrait duration:1];
					
					[entity willAnimateRotationToInterfaceOrientation:UIInterfaceOrientationPortrait duration:1];
					[verify(component) willAnimateRotationToInterfaceOrientation:UIInterfaceOrientationPortrait duration:1];
						
					[entity didRotateFromInterfaceOrientation:UIInterfaceOrientationLandscapeLeft];
					[verify(component) didRotateFromInterfaceOrientation:UIInterfaceOrientationLandscapeLeft];
				});
			});
		});
	});
});

SPEC_END


@implementation FUTestEntity
- (id)addComponentWithClass:(Class)componentClass
{
	FUComponent* mockComponent = mock(componentClass);
	[[self performSelector:@selector(components)] addObject:mockComponent];
	return mockComponent;
}
@end

@interface FUTestComponent ()
@property (nonatomic) NSUInteger initCallCount;
@end

@implementation FUTestComponent
@synthesize initCallCount = _initCallCount;

- (BOOL)wasInitCalled
{
	return [self initCallCount] == 1;
}

- (id)init
{
	if ((self = [super init]))
	{
		[self setInitCallCount:[self initCallCount] + 1];
	}
	
	return self;
}
@end


@implementation FUUniqueParentComponent
+ (BOOL)isUnique {return YES; }
@end

@implementation FUUniqueChild1Component
@end

@implementation FUUniqueChild2Component
@end

@implementation FUCommonChildComponent
+ (BOOL)isUnique { return NO; }
@end

@implementation FUUniqueGrandChildComponent
+ (BOOL)isUnique { return YES; }
@end

@implementation FURequireObjectComponent
+ (NSSet*)requiredComponents { return [NSSet setWithObject:[NSString string]]; }
@end

@implementation FURequireInvalidSuperclassComponent
+ (NSSet*)requiredComponents { return [NSSet setWithObject:[FURequiredComponent class]]; }
@end

@implementation FURequireNSStringComponent
+ (NSSet*)requiredComponents { return [NSSet setWithObject:[NSString class]]; }
@end

@implementation FURequireBaseComponent
+ (NSSet*)requiredComponents { return [NSSet setWithObject:[FUComponent class]]; }
@end

@implementation FURequireItselfComponent
+ (NSSet*)requiredComponents { return [NSSet setWithObject:self]; }
@end

@implementation FURequireSubclassComponent
+ (NSSet*)requiredComponents { return [NSSet setWithObject:[FUTestComponent class]]; }
@end

@implementation FURequireRelativesComponent
+ (NSSet*)requiredComponents { return [NSSet setWithObjects:[FUUniqueParentComponent class], [FUUniqueChild1Component class], nil]; }
@end

@implementation FUCommonParentComponent
@end

@implementation FURequireUniqueParentComponent
+ (NSSet*)requiredComponents { return [NSSet setWithObject:[FUUniqueParentComponent class]]; }
@end

@implementation FURequireRequiredComponent
+ (NSSet*)requiredComponents { return [NSSet setWithObject:[FURequiredComponent class]]; }
@end

@implementation FURequiredComponent
@end
