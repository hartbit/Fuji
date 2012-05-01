//
//  FUVisitor.m
//  Fuji
//
//  Created by David Hart
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUVisitor-Internal.h"
#import "FUSceneObject.h"


@implementation FUVisitor

#pragma mark - Class Methods

+ (SEL)visitSelectorForClass:(Class)sceneObjectClass
{
	if (![sceneObjectClass isSubclassOfClass:[FUSceneObject class]])
	{
		return NULL;
	}
	
	static NSMutableDictionary* sSelectors;
	
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
	
	NSString* selectorString = [classSelectors objectForKey:sceneObjectClass];
	SEL selector = NULL;
	
	if (selectorString == nil)
	{ 
		selectorString = [NSString stringWithFormat:@"visit%@:", NSStringFromClass(sceneObjectClass)];
		selector = NSSelectorFromString(selectorString);
		
		if (![self instancesRespondToSelector:selector])
		{
			selector = [self visitSelectorForClass:[sceneObjectClass superclass]];
			selectorString = (selector != NULL) ? NSStringFromSelector(selector) : [NSString string];
		}
		
		[classSelectors setObject:selectorString forKey:sceneObjectClass];
	}
	else if ([selectorString length] != 0)
	{
		selector = NSSelectorFromString(selectorString);
	}
	
	return selector;
}

+ (NSString*)selectorForClass:(Class)sceneObjectClass inDictionary:(NSMutableDictionary*)dictionary
{	
	if (![sceneObjectClass isSubclassOfClass:[FUSceneObject class]])
	{
		return [NSString string];
	}
	
	NSString* selectorString = [dictionary objectForKey:sceneObjectClass];
	
	if (selectorString == nil)
	{ 
		selectorString = [NSString stringWithFormat:@"visit%@:", NSStringFromClass(sceneObjectClass)];
		SEL selector = NSSelectorFromString(selectorString);
		
		if (![self instancesRespondToSelector:selector])
		{
			selectorString = [self selectorForClass:[sceneObjectClass superclass] inDictionary:dictionary];
		}
		
		[dictionary setObject:selectorString forKey:sceneObjectClass];
	}
	
	return selectorString;
}

#pragma mark - Internal Methods

- (void)visitSceneObject:(FUSceneObject*)sceneObject
{
	SEL selector = [[self class] visitSelectorForClass:[sceneObject class]];
	
	if (selector != NULL)
	{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
		[self performSelector:selector withObject:sceneObject];
#pragma clang diagnostic pop
	}
}

@end
