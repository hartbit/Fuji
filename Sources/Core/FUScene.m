//
//  FUScene.m
//  Fuji
//
//  Created by Hart David on 28.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#include "Prefix.pch"
#import "FUScene.h"
#import "FUGameObject.h"
#import "FUGameObject-Internal.h"
#import "FUMacros.h"


@implementation FUScene

#pragma mark - Public Methods

- (FUGameObject*)createGameObject
{
	return [[FUGameObject alloc] initWithScene:self];
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
