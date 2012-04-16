//
//  FUEngine.m
//  Fuji
//
//  Created by Hart David on 30.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "FUEngine.h"
#import "FUEngine-Internal.h"
#import "FUSceneObject.h"


@implementation FUEngine

@synthesize director = _director;

#pragma mark - Class Methods

+ (SEL)registerSelectorForSceneObject:(FUSceneObject*)sceneObject
{
	static NSMutableDictionary* sSelectors = nil;
	
	if (sSelectors == nil)
	{
		sSelectors = [NSMutableDictionary dictionary];
	}
	
	NSMutableDictionary* classSelectors = [sSelectors objectForKey:self];
	
	if (classSelectors == nil)
	{
		classSelectors = [NSMutableDictionary dictionary];
		[sSelectors setObject:classSelectors forKey:self];
	}
	
	NSString* selectorString = [self selectorForClass:[sceneObject class] withPrefix:@"register" inDictionary:classSelectors];
	return ([selectorString length] != 0) ? NSSelectorFromString(selectorString) : NULL;
}

+ (SEL)unregisterSelectorForSceneObject:(FUSceneObject*)sceneObject
{
	static NSMutableDictionary* sSelectors = nil;
	
	if (sSelectors == nil)
	{
		sSelectors = [NSMutableDictionary dictionary];
	}
	
	NSMutableDictionary* classSelectors = [sSelectors objectForKey:self];
	
	if (classSelectors == nil)
	{
		classSelectors = [NSMutableDictionary dictionary];
		[sSelectors setObject:classSelectors forKey:self];
	}
	
	NSString* selectorString = [self selectorForClass:[sceneObject class] withPrefix:@"unregister" inDictionary:classSelectors];
	return ([selectorString length] != 0) ? NSSelectorFromString(selectorString) : NULL;
}

+ (NSString*)selectorForClass:(Class)sceneObjectClass withPrefix:(NSString*)prefix inDictionary:(NSMutableDictionary*)dictionary
{	
	if (![sceneObjectClass isSubclassOfClass:[FUSceneObject class]])
	{
		return [NSString string];
	}
	
	NSString* selectorString = [dictionary objectForKey:sceneObjectClass];
	
	if (selectorString == nil)
	{ 
		selectorString = [NSString stringWithFormat:@"%@%@:", prefix, NSStringFromClass(sceneObjectClass)];
		SEL selector = NSSelectorFromString(selectorString);
		
		if (![self instancesRespondToSelector:selector])
		{
			selectorString = [self selectorForClass:[sceneObjectClass superclass] withPrefix:prefix inDictionary:dictionary];
		}
		
		[dictionary setObject:selectorString forKey:sceneObjectClass];
	}
	
	return selectorString;
}

#pragma mark - Public Methods

- (void)unregisterAll
{
}

- (void)update
{
}

- (void)draw
{
}

#pragma mark - UIInterfaceRotating Methods

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
}

#pragma mark - Internal Methods

- (void)registerSceneObject:(FUSceneObject*)sceneObject
{
	SEL selector = [[self class] registerSelectorForSceneObject:sceneObject];
	
	if (selector != NULL)
	{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
		[self performSelector:selector withObject:sceneObject];
#pragma clang diagnostic pop
	}
}

- (void)unregisterSceneObject:(FUSceneObject*)sceneObject
{
	SEL selector = [[self class] unregisterSelectorForSceneObject:sceneObject];
	
	if (selector != NULL)
	{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
		[self performSelector:selector withObject:sceneObject];
#pragma clang diagnostic pop
	}
}

#pragma mark - Private Methods



@end
