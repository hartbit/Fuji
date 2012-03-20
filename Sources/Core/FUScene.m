//
//  FUScene.m
//  Fuji
//
//  Created by Hart David on 28.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#include "Prefix.pch"
#import "FUScene.h"
#import "FUGameObject-Internal.h"
#import "FUMacros.h"


static NSString* const FUGameObjectNilMessage = @"Expected 'gameObject' to not be nil";
static NSString* const FUGameObjectNonexistentMessage = @"Can not remove a 'gameObject=%@' that does not exist";


@interface FUScene ()

@property (nonatomic, strong) NSMutableSet* gameObjects;

@end


@implementation FUScene

@synthesize gameObjects = _gameObjects;

#pragma mark - Class Methods

+ (FUScene*)scene
{
	FUScene* scene = [self alloc];
	return [scene initWithScene:scene];
}

#pragma mark - Properties

- (NSMutableSet*)gameObjects
{
	if (_gameObjects == nil)
	{
		[self setGameObjects:[NSMutableSet set]];
	}
	
	return _gameObjects;
}

#pragma mark - Public Methods

- (id)createGameObject
{
	FUGameObject* gameObject = [[FUGameObject alloc] initWithScene:self];
	[[self gameObjects] addObject:gameObject];
	return gameObject;
}

- (void)removeGameObject:(FUGameObject*)gameObject
{
	FUAssert(gameObject != nil, FUGameObjectNilMessage);
	
	if (![[self gameObjects] containsObject:gameObject])
	{
		FUThrow(FUGameObjectNonexistentMessage, gameObject);
	}
	
	[[self gameObjects] removeObject:gameObject];
	[gameObject setScene:nil];
}

- (NSSet*)allGameObjects
{
	return [NSSet setWithSet:[self gameObjects]];
}

/*
- (void)update
{
	
}

- (void)render
{
	GLKVector4 backgroundColor = [self backgroundColor];
	glClearColor(backgroundColor.r, backgroundColor.g, backgroundColor.b, backgroundColor.a);
	glClear(GL_COLOR_BUFFER_BIT);
	
	float vertices[] = {
		-220, -200,
		0,  500,
		500, -200
	};

	glEnableVertexAttribArray(GLKVertexAttribPosition);
	glVertexAttribPointer(GLKVertexAttribPosition, 2, GL_FLOAT, GL_FALSE, 0, vertices);
	glDrawArrays(GL_TRIANGLES, 0, 3);
	glDisableVertexAttribArray(GLKVertexAttribPosition);
}
*/

@end
