//
//  FUGraphicsEngine.m
//  Fuji
//
//  Created by Hart David on 30.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#include "Prefix.pch"
#import "FUDirector.h"
#import "FUScene.h"
#import "FUGraphicsEngine.h"
#import "FUGraphicsSettings.h"
#import "FUSpriteRenderer.h"
#import "FUTransform.h"


@interface FUGraphicsEngine ()

@property (nonatomic, strong) GLKBaseEffect* effect;
@property (nonatomic, WEAK) FUGraphicsSettings* settings;
@property (nonatomic, assign) GLKMatrixStackRef matrixStack;

@end


@implementation FUGraphicsEngine

@synthesize effect = _effect;
@synthesize settings = _settings;
@synthesize matrixStack = _matrixStack;

#pragma mark - Initialization

- (id)init
{
	self = [super init];
	if (self == nil) return nil;
	
	glEnable(GL_CULL_FACE);
	
	return self;
}

- (void)dealloc
{
	[self setMatrixStack:NULL];
}

#pragma mark - Properties

- (GLKBaseEffect*)effect
{
	if (_effect == nil)
	{
		GLKBaseEffect* effect = [GLKBaseEffect new];
		[self setEffect:effect];
		[self updateProjection];
	}
 
	return _effect;
}

- (GLKMatrixStackRef)matrixStack
{
	if (_matrixStack == NULL)
	{
		GLKMatrixStackRef matrixStack = GLKMatrixStackCreate(NULL);
		[self setMatrixStack:matrixStack];
	}
	
	return _matrixStack;
}

- (void)setMatrixStack:(GLKMatrixStackRef)matrixStack
{
	if (matrixStack != _matrixStack)
	{
		if (_matrixStack != NULL)
		{
			CFRelease(_matrixStack);
		}
		
		_matrixStack = matrixStack;
		
		if (_matrixStack != NULL)
		{
			CFRetain(_matrixStack);
		}
	}
}

#pragma mark - Drawing

- (void)drawFUScene:(FUScene*)scene
{
	FUGraphicsSettings* settings = [scene graphics];
	[self setSettings:settings];
	
	GLKVector4 backgroundColor = [settings backgroundColor];
	glClearColor(backgroundColor.r, backgroundColor.g, backgroundColor.b, backgroundColor.a);
	glClear(GL_COLOR_BUFFER_BIT);
	
	[[self effect] prepareToDraw];
}

- (void)drawFUTransform:(FUTransform*)transform
{
	GLKMatrixStackPush([self matrixStack]);
	GLKMatrixStackMultiplyMatrix4([self matrixStack], [transform matrix]);
}

- (void)drawFUSpriteRenderer:(FUSpriteRenderer*)spriteRenderer
{
	const CGFloat width = 100;
	const CGFloat height = 100;
	
	CGFloat halfWidth = width / 2;
	CGFloat halfHeight = height / 2;
	
	float vertices[] = {
		-halfWidth, -halfHeight,
		-halfWidth, halfHeight,
		halfWidth,  -halfHeight,
		halfWidth,  halfHeight
	};
	
	[[[self effect] transform] setModelviewMatrix:GLKMatrixStackGetMatrix4([self matrixStack])];
	GLKMatrixStackPop([self matrixStack]);
	
	glEnableVertexAttribArray(GLKVertexAttribPosition);
	glVertexAttribPointer(GLKVertexAttribPosition, 2, GL_FLOAT, GL_FALSE, 0, vertices);
	glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
	glDisableVertexAttribArray(GLKVertexAttribPosition);
}

#pragma mark - FUInterfaceRotation Methods

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
	[self updateProjection];
}

#pragma maek - Private Methods

- (void)updateProjection
{
	CGSize viewSize = [[[self director] view] bounds].size;
	GLKMatrix4 projectionMatrix = GLKMatrix4MakeOrtho(0, viewSize.width, viewSize.height, 0, -1, 1);
	[[[self effect] transform] setProjectionMatrix:projectionMatrix];
}

@end
