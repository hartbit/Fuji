//
//  FUEntitySpec.m
//  Fuji
//
//  Created by Hart David on 24.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#include "Prefix.pch"
#import "Fuji.h"
#import "FUVisitor-Internal.h"
#import "FUDirector-Internal.h"
#import "FUSceneObject-Internal.h"
#import "FUComponent-Internal.h"


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
		__block FUDirector* director = nil;
		__block FUScene* scene = nil;
		__block FUEntity* entity = nil;
		
		beforeEach(^{
			director = mock([FUDirector class]);
			scene = mock([FUScene class]);
			[given([scene director]) willReturn:director];
			entity = [[FUEntity alloc] initWithScene:scene];
		});
		
		it(@"is not nil", ^{
			expect(entity).toNot.beNil();
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

		context(@"accepting a visitor", ^{
			it(@"visits the entity and it's components", ^{
				FUVisitor* visitor = mock([FUVisitor class]);
				[entity acceptVisitor:visitor];
				[verify(visitor) visitSceneObject:entity];
				[verify(visitor) visitSceneObject:[entity transform]];
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
				expect([component1 scene]).to.beIdenticalTo(scene);
			});
			
			it(@"registers the component with the director", ^{
				[verify(director) didAddSceneObject:component1];
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
				
				it(@"registers the new component with the director", ^{
					[verify(director) didAddSceneObject:component2];
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
					expect([component2 scene]).to.beIdenticalTo(scene);
				});
				
				it(@"registers the new component with the director", ^{
					[verify(director) didAddSceneObject:component2];
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
					
					it(@"removes it from the entity", ^{
						NSSet* components = [entity allComponents];
						expect(components).to.haveCountOf(3);
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
	
	context(@"initialized a test entity", ^{
		__block FUTestEntity* entity = nil;
		
		beforeEach(^{
			entity = [[FUTestEntity alloc] initWithScene:mock([FUScene class])];
		});
		
		it(@"is not nil", ^{
			expect(entity).toNot.beNil();
		});
			
		context(@"adding a mock component", ^{
			__block FUComponent* component = nil;
				
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
