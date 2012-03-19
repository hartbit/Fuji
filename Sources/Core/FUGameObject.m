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
#import <objc/objc-class.h>


static NSString* const FUCreationInvalidMessage = @"Can not create a game object outside of a scene";
static NSString* const FUSceneNilMessage = @"Expected 'scene' to not be nil";
static NSString* const FUComponentClassInvalidMessage = @"Expected 'componentClass=%@' to be a subclass of FUComponent (excluded)";
static NSString* const FUComponentUniqueAndExistsMessage = @"'componentClass=%@' is unique and another component of that class already exists";
static NSString* const FURequiredComponentTypeMessage = @"Expected 'requiredComponent=%@' to be of type Class";
static NSString* const FURequiredComponentSubclassMessage = @"Expected 'requiredComponent=%@' to be a subclass of FUComponent (excluded)";


static __inline__ BOOL FUIsValidComponentClass(Class componentClass)
{
	return [componentClass isSubclassOfClass:[FUComponent class]] && (componentClass != [FUComponent class]);
}

static __inline__ BOOL FUIsClass(id object)
{
	return !class_isMetaClass(object) && class_isMetaClass(object_getClass(object));
}


@interface FUGameObject ()

@property (nonatomic, WEAK) FUScene* scene;
@property (nonatomic, strong) NSMutableSet* components;

@end


@implementation FUGameObject

@synthesize scene = _scene;
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
	NSAssert(NO, FUCreationInvalidMessage);
	return nil;
}

- (id)initWithScene:(FUScene*)scene
{
	NSAssert(scene != nil, FUSceneNilMessage);
	
	if ((self = [super init]))
	{
		[self setScene:scene];
	}
	
	return self;
}

#pragma mark - Public Methods

- (FUComponent*)addComponentWithClass:(Class)componentClass
{
	NSAssert(FUIsValidComponentClass(componentClass), FUComponentClassInvalidMessage, NSStringFromClass(componentClass));
	NSAssert(![componentClass isUnique] || ([self componentWithClass:componentClass] == nil), FUComponentUniqueAndExistsMessage, NSStringFromClass(componentClass));
	
	NSSet* requiredComponents = [componentClass requiredComponents];
	
	for (id requiredClass in requiredComponents)
	{
		NSAssert(FUIsClass(requiredClass), FURequiredComponentTypeMessage, requiredClass);
		NSAssert(FUIsValidComponentClass(requiredClass), FURequiredComponentSubclassMessage, NSStringFromClass(componentClass));
	}
	
	FUComponent* component = [[componentClass alloc] initWithGameObject:self];
	[[self components] addObject:component];
	[component awake];
	return component;
}

- (FUComponent*)componentWithClass:(Class)componentClass
{
	NSAssert(FUIsValidComponentClass(componentClass), FUComponentClassInvalidMessage, NSStringFromClass(componentClass));
	
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
	NSAssert(FUIsValidComponentClass(componentClass), FUComponentClassInvalidMessage, NSStringFromClass(componentClass));
	
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

@end
