//
//  MOScene.m
//  Mocha2D
//
//  Created by Hart David on 28.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "MOScene.h"
#import "MOMacros.h"
#import "MOMath.h"


@implementation MOScene

@synthesize backgroundColor = _backgroundColor;

#pragma mark - Initialization

- (id)init
{
	if ((self = [super init]))
	{
		[self setBackgroundColor:MOColor3WithBytes(100, 149, 237)];
	}
	
	return self;
}

- (void)update
{
	
}

- (void)render
{
	GLKVector3 backgroundColor = [self backgroundColor];
	glClearColor(backgroundColor.r, backgroundColor.g, backgroundColor.b, 1);
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

@end
