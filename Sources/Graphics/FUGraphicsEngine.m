//
//  FUGraphicsEngine.m
//  Fuji
//
//  Created by Hart David on 30.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#include "Prefix.pch"
#import "FUMath.h"
#import "FUDirector.h"
#import "FUScene.h"
#import "FUGraphicsEngine.h"
#import "FUGraphicsSettings.h"
#import "FUSpriteRenderer.h"
#import "FUTransform.h"


@interface FUGraphicsEngine ()

@property (nonatomic, strong) GLKBaseEffect* effect;
@property (nonatomic, WEAK) FUGraphicsSettings* settings;
@property (nonatomic) GLKMatrixStackRef matrixStack;
@property (nonatomic) GLuint spriteBuffer;

@end


@implementation FUGraphicsEngine

@synthesize effect = _effect;
@synthesize settings = _settings;
@synthesize matrixStack = _matrixStack;
@synthesize spriteBuffer = _spriteBuffer;

#pragma mark - Initialization

- (id)init
{
	self = [super init];
	if (self == nil) return nil;
	
	glEnable(GL_CULL_FACE);
	glEnableVertexAttribArray(GLKVertexAttribPosition);
	
	[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(logFPS) userInfo:nil repeats:YES];
	
	return self;
}

- (void)dealloc
{
	[self setMatrixStack:NULL];
}

- (void)logFPS
{
	NSLog(@"FPS: %i", [[self director] framesPerSecond]);
}

#pragma mark - Properties

- (GLKBaseEffect*)effect
{
	if (_effect == nil)
	{
		GLKBaseEffect* effect = [GLKBaseEffect new];
		[self setEffect:effect];
		
		[effect setUseConstantColor:YES];
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

- (GLuint)spriteBuffer
{
	if (_spriteBuffer == 0)
	{
		float vertices[] = {
			-0.5f, -0.5f,
			-0.5f, 0.5f,
			0.5f,  -0.5f,
			0.5f,  0.5f
		};
		
		glGenBuffers(1, &_spriteBuffer);
		glBindBuffer(GL_ARRAY_BUFFER, _spriteBuffer);
		glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
	}
	
	return _spriteBuffer;
}

#pragma mark - Drawing

- (void)drawEnterFUScene:(FUScene*)scene
{
	FUGraphicsSettings* settings = [scene graphics];
	[self setSettings:settings];
	
	GLKVector4 backgroundColor = [settings backgroundColor];
	glClearColor(backgroundColor.r, backgroundColor.g, backgroundColor.b, backgroundColor.a);
	glClear(GL_COLOR_BUFFER_BIT);
	
	[[self effect] prepareToDraw];
	
//	NSLog(@"===================================");
}

- (void)updateFUTransform:(FUTransform*)transform
{
	[transform setPosition:GLKVector2Make(floorf(FURandomDouble(0, 320)), floorf(FURandomDouble(0, 480)))];
}

/*
- (void)drawEnterFUEntity:(FUEntity*)entity
{
	if ([entity transform] != nil)
	{
		GLKMatrixStackPush([self matrixStack]);
		GLKMatrixStackMultiplyMatrix4([self matrixStack], [[entity transform] matrix]);
	
//		NSLog(@"PUSH Transform: %p", entity);
	}
}

- (void)drawLeaveFUEntity:(FUEntity*)entity
{
	if ([entity transform] != nil)
	{
		GLKMatrixStackPop([self matrixStack]);
		
//		NSLog(@"POP Transform: %p", entity);
	}
}
*/
- (void)drawFUSpriteRenderer:(FUSpriteRenderer*)spriteRenderer
{
//	NSLog(@"Draw: %p", [spriteRenderer entity]);
	
	const CGFloat width = 1;
	const CGFloat height = 1;
	
	[[self effect] setConstantColor:[spriteRenderer color]];
//	[[[self effect] transform] setModelviewMatrix:GLKMatrixStackGetMatrix4([self matrixStack])];
	[[[self effect] transform] setModelviewMatrix:[[[spriteRenderer entity] transform] matrix]];
	[[self effect] prepareToDraw];
	
	CGFloat halfWidth = width / 2;
	CGFloat halfHeight = height / 2;
	
	float vertices[] = {
		-halfWidth, -halfHeight,
		-halfWidth, halfHeight,
		halfWidth,  -halfHeight,
		halfWidth,  halfHeight
	};
	
	glVertexAttribPointer(GLKVertexAttribPosition, 2, GL_FLOAT, GL_FALSE, 0, vertices);
	glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
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
