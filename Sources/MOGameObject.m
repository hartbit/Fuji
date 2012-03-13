//
//  MOGameObject.m
//  Mocha2D
//
//  Created by David Hart on 01.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "MOGameObject.h"
#import "MOGameObject-Internal.h"
#import "MOScene.h"
#import "MOComponent.h"
#import "MOComponent-Internal.h"
#import "MOMacros.h"


@implementation MOGameObject

#pragma mark - Initialization

- (id)init
{
	MOFail(@"Can not create a game object outside of a scene.");
	return nil;
}

- (id)initWithScene:(MOScene*)scene
{
	if ((self = [super init]))
	{
	}
	
	return self;
}

#pragma mark - Public Methods

- (MOComponent*)addComponentWithClass:(Class)componentClass
{
	MOAssertError([componentClass isSubclassOfClass:[MOComponent class]], @"class=%@", NSStringFromClass(componentClass));
	MOAssertError(componentClass != [MOComponent class], @"Can not create an abstract MOComponent.");
	
	MOComponent* component = [[componentClass alloc] initWithGameObject:self];
	[component awake];
	return component;
}

@end
