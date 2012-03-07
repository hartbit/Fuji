//
//  MOGameObject.m
//  Mocha2D
//
//  Created by David Hart on 01.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "MOGameObject.h"
#import "MOComponent.h"
#import "MOComponent-Internal.h"
#import "MOMacros.h"


@implementation MOGameObject

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
