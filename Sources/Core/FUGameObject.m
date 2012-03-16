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
#import "FULog.h"


static __inline__ BOOL FUIsValidComponentClass(Class componentClass)
{
	return [componentClass isSubclassOfClass:[FUComponent class]] && (componentClass != [FUComponent class]);
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
	FULogError(@"Can not create a game object outside of a scene");
	return nil;
}

- (id)initWithScene:(FUScene*)scene
{
	if (scene == nil)
	{
		FULogError(@"Expected 'scene' to not be nil");
		return nil;
	}
	
	if ((self = [super init]))
	{
		[self setScene:scene];
	}
	
	return self;
}

#pragma mark - Public Methods

- (FUComponent*)addComponentWithClass:(Class)componentClass
{
	if (!FUIsValidComponentClass(componentClass))
	{
		FULogError(@"Expected 'componentClass=%@' to be a subclass of FUComponent (excluded)", NSStringFromClass(componentClass));
		return nil;
	}
	
	if ([componentClass isUnique] && ([self componentWithClass:componentClass] != nil))
	{
		FULogError(@"'componentClass=%@' is unique and another component of that class already exists", NSStringFromClass(componentClass));
		return nil;
	}
	
	NSSet* requiredComponents = [componentClass requiredComponents];
	
	for (id requiredClass in requiredComponents)
	{
		if (![requiredClass respondsToSelector:@selector(isSubclassOfClass:)] || !FUIsValidComponentClass(requiredClass))
		{
			FULogError(@"Expected 'requiredComponent=%@' to be a subclass of FUComponent (excluded)", NSStringFromClass(componentClass));
			return nil;
		}
	}
	
	FUComponent* component = [[componentClass alloc] initWithGameObject:self];
	[[self components] addObject:component];
	[component awake];
	return component;
}

- (FUComponent*)componentWithClass:(Class)componentClass
{
	if (!FUIsValidComponentClass(componentClass))
	{
		FULogError(@"Expected 'componentClass=%@' to be a subclass of FUComponent (excluded)", NSStringFromClass(componentClass));
		return nil;
	}
	
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
	if (!FUIsValidComponentClass(componentClass))
	{
		FULogError(@"Expected 'componentClass=%@' to be a subclass of FUComponent (excluded)", NSStringFromClass(componentClass));
		return nil;
	}
	
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
