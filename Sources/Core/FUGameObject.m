//
//  FUGameObject.m
//  Fuji
//
//  Created by David Hart on 01.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#include "Prefix.pch"
#import "FUGameObject.h"
#import "FUGameObject-Internal.h"
#import "FUScene.h"
#import "FUComponent.h"
#import "FUComponent-Internal.h"
#import "FUTransform.h"
#import <objc/objc-class.h>


static NSString* const FUComponentAncestoryInvalidMessage = @"A non-unique 'component=%@' has a unique parent 'component=%@'";
static NSString* const FUCreationInvalidMessage = @"Can not create a game object outside of a scene";
static NSString* const FUSceneNilMessage = @"Expected 'scene' to not be nil";
static NSString* const FUComponentClassInvalidMessage = @"Expected 'componentClass=%@' to be a subclass of FUComponent (excluded)";
static NSString* const FUComponentUniqueAndExistsMessage = @"'componentClass=%@' is unique and another component of that class already exists";
static NSString* const FUComponentNilMessage = @"Expected 'component' to not be nil";
static NSString* const FUComponentNonexistentMessage = @"Can not remove a 'component=%@' that does not exist";
static NSString* const FURequiredComponentTypeMessage = @"Expected 'requiredComponent=%@' to be of type Class";
static NSString* const FURequiredComponentSuperclassMessage = @"The 'requiredComponent=%@' can not be the same class or a superclass of added 'componentClass=%@'";
static NSString* const FURequiredComponentSubclassMessage = @"The 'requiredComponent=%@' can not be the same class or a subclass of other 'requiredComponent=%@'";
static NSString* const FUComponentRequiredMessage = @"Can not remove 'component=%@' because it is required by another 'component=%@'.";


static OBJC_INLINE BOOL FUIsValidComponentClass(Class componentClass)
{
	return [componentClass isSubclassOfClass:[FUComponent class]] && (componentClass != [FUComponent class]);
}

static OBJC_INLINE BOOL FUIsClass(id object)
{
	return !class_isMetaClass(object) && class_isMetaClass(object_getClass(object));
}

static Class FUGetOldestUniqueAncestorClass(Class componentClass)
{
	Class currentAncestor = componentClass;
	Class oldestUniqueAncestor = componentClass;
	
	do
	{
		Class parentClass = [currentAncestor superclass];
		
		if (![currentAncestor isUnique] && [parentClass isUnique])
		{
			FUThrow(FUComponentAncestoryInvalidMessage, NSStringFromClass(currentAncestor), NSStringFromClass(parentClass));
		}
		else if ([currentAncestor isUnique] && ![parentClass isUnique])
		{
			oldestUniqueAncestor = currentAncestor;
		}
		
		currentAncestor = parentClass;
	} while (FUIsValidComponentClass(currentAncestor));
	
	return oldestUniqueAncestor;
}


@interface FUGameObject ()

@property (nonatomic, WEAK) FUTransform* transform;
@property (nonatomic, strong) NSMutableSet* components;

- (void)addRequiredComponentsForClass:(Class)componentClass;
- (void)validateRemovalOfComponent:(FUComponent*)component;

@end


@implementation FUGameObject

@synthesize scene = _scene;
@synthesize transform = _transform;
@synthesize components = _components;

#pragma mark - Properties

- (NSMutableSet*)components
{
	if (_components == nil)
	{
		[self setComponents:[NSMutableSet set]];
	}
	
	return _components;
}

#pragma mark - Initialization

- (id)init
{
	FUThrow(FUCreationInvalidMessage);
}

- (id)initWithScene:(FUScene*)scene
{
	FUAssert(scene != nil, FUSceneNilMessage);
	
	if ((self = [super init]))
	{
		[self setScene:scene];
		[self addComponentWithClass:[FUTransform class]];
	}
	
	return self;
}

#pragma mark - Public Methods

- (id)addComponentWithClass:(Class)componentClass
{
	FUAssert(FUIsValidComponentClass(componentClass), FUComponentClassInvalidMessage, NSStringFromClass(componentClass));
	
	Class oldestUniqueAncestor = FUGetOldestUniqueAncestorClass(componentClass);
	
	if ([componentClass isUnique] && ([self componentWithClass:oldestUniqueAncestor] != nil))
	{
		FUThrow(FUComponentUniqueAndExistsMessage, NSStringFromClass(componentClass));
	}

	[self addRequiredComponentsForClass:componentClass];
	
	id component = [[componentClass alloc] initWithGameObject:self];
	[[self components] addObject:component];
	[component awake];
	
	if (([self transform] == nil) && (componentClass == [FUTransform class]))
	{
		[self setTransform:component];
	}
	
	return component;
}

- (void)removeComponent:(FUComponent*)component
{
	FUAssert(component != nil, FUComponentNilMessage);
	
	if (![[self components] containsObject:component])
	{
		FUThrow(FUComponentNonexistentMessage, component);
	}
	
	[self validateRemovalOfComponent:component];	
	[[self components] removeObject:component];
	[component setGameObject:nil];
	
	if (component == [self transform])
	{
		[self setTransform:[self componentWithClass:[FUTransform class]]];
	}
}

- (id)componentWithClass:(Class)componentClass
{
	FUAssert(FUIsValidComponentClass(componentClass), FUComponentClassInvalidMessage, NSStringFromClass(componentClass));
	
	for (FUComponent* component in [self components])
	{
		if ([[component class] isSubclassOfClass:componentClass])
		{
			return component;
		}
	}
	
	return nil;
}

- (NSSet*)allComponentsWithClass:(Class)componentClass
{
	FUAssert(FUIsValidComponentClass(componentClass), FUComponentClassInvalidMessage, NSStringFromClass(componentClass));
	
	NSMutableSet* components = [NSMutableSet set];
	
	for (FUComponent* component in [self components])
	{
		if ([[component class] isSubclassOfClass:componentClass])
		{
			[components addObject:component];
		}
	}
	
	return [NSSet setWithSet:components];
}

- (NSSet*)allComponents
{
	return [NSSet setWithSet:[self components]];
}

#pragma mark - Private Methods

- (void)addRequiredComponentsForClass:(Class)componentClass
{
	NSSet* requiredComponents = [componentClass requiredComponents];
	
	for (id requiredClass in requiredComponents)
	{
		FUAssert(FUIsClass(requiredClass), FURequiredComponentTypeMessage, requiredClass);
		
		if ([componentClass isSubclassOfClass:requiredClass])
		{
			FUThrow(FURequiredComponentSuperclassMessage, NSStringFromClass(requiredClass), NSStringFromClass(componentClass));
		}
		
		for (id otherRequiredClass in requiredComponents)
		{
			if ((otherRequiredClass != requiredClass) && [requiredClass isSubclassOfClass:otherRequiredClass])
			{
				FUThrow(FURequiredComponentSubclassMessage, NSStringFromClass(requiredClass), NSStringFromClass(componentClass));
			}
		}
		
		if ([self componentWithClass:requiredClass] == nil)
		{
			[self addComponentWithClass:requiredClass];
		}
	}
}

- (void)validateRemovalOfComponent:(FUComponent*)component
{
	Class currentAncestor = [component class];
	
	while (FUIsValidComponentClass(currentAncestor) && ([[self allComponentsWithClass:currentAncestor] count] == 1))
	{
		for (FUComponent* otherComponent in [self components])
		{
			if ((otherComponent != component) && [[[otherComponent class] requiredComponents] containsObject:currentAncestor])
			{
				FUThrow(FUComponentRequiredMessage, component, otherComponent);
			}
		}
		
		currentAncestor = [currentAncestor superclass];
	}
}

@end
