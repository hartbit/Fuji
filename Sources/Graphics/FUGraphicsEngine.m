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
@property (nonatomic) NSMutableData* vertexData;

@end


@implementation FUGraphicsEngine

@synthesize effect = _effect;
@synthesize settings = _settings;
@synthesize matrixStack = _matrixStack;
@synthesize vertexData = _vertexData;

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

- (NSMutableData*)vertexData
{
	if (_vertexData == nil)
	{
		[self setVertexData:[NSMutableData data]];
	}
	
	return _vertexData;
}

/*
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
*/
#pragma mark - Drawing

- (void)drawSceneEnter:(FUScene*)scene
{
	FUGraphicsSettings* settings = [scene graphics];
	[self setSettings:settings];
	
	GLKVector4 backgroundColor = [settings backgroundColor];
	glClearColor(backgroundColor.r, backgroundColor.g, backgroundColor.b, backgroundColor.a);
	glClear(GL_COLOR_BUFFER_BIT);
	
	[[self effect] prepareToDraw];
}

- (void)updateTransform:(FUTransform*)transform
{
	[transform setPosition:GLKVector2Make(floorf(FURandomDouble(0, 320)), floorf(FURandomDouble(0, 480)))];
}

- (void)drawSpriteRenderer:(FUSpriteRenderer*)spriteRenderer
{
//	NSLog(@"Draw: %p", [spriteRenderer entity]);
	
	const CGFloat width = 1;
	const CGFloat height = 1;
	
	[[self effect] setConstantColor:[spriteRenderer color]];
	
	CGFloat halfWidth = width / 2;
	CGFloat halfHeight = height / 2;
	GLKMatrix4 matrix = [[[spriteRenderer entity] transform] matrix];
	GLKVector3 p0 = GLKMatrix4MultiplyVector3WithTranslation(matrix, GLKVector3Make(-halfWidth, -halfHeight, 0));
	GLKVector3 p1 = GLKMatrix4MultiplyVector3WithTranslation(matrix, GLKVector3Make(-halfWidth, halfHeight, 0));
	GLKVector3 p2 = GLKMatrix4MultiplyVector3WithTranslation(matrix, GLKVector3Make(halfWidth, -halfHeight, 0));
	GLKVector3 p3 = GLKMatrix4MultiplyVector3WithTranslation(matrix, GLKVector3Make(halfWidth, halfHeight, 0));
	
	NSUInteger vertexSize = sizeof(GLKVector2);
	NSUInteger dataLength = [[self vertexData] length];
	NSUInteger vertexIndex = dataLength / vertexSize;
	[[self vertexData] setLength:dataLength + (vertexSize * 6)];
	GLKVector2* vertexPointer = [[self vertexData] mutableBytes];
	vertexPointer[vertexIndex] = GLKVector2Make(p0.x, p0.y);
	vertexPointer[vertexIndex+1] = GLKVector2Make(p1.x, p1.y);
	vertexPointer[vertexIndex+2] = GLKVector2Make(p2.x, p2.y);
	vertexPointer[vertexIndex+3] = GLKVector2Make(p3.x, p3.y);
	vertexPointer[vertexIndex+3] = GLKVector2Make(p3.x, p3.y);
	vertexPointer[vertexIndex+3] = GLKVector2Make(p3.x, p3.y);
/*	[[[self effect] transform] setModelviewMatrix:matrix];
	[[self effect] prepareToDraw];*/
	
	
/*	
	float vertices[] = {
		p0.x, p0.y,
		p1.x, p1.y,
		p2.x, p2.y,
		p3.x, p3.y
	};
	
	glEnableVertexAttribArray(GLKVertexAttribPosition);
	glVertexAttribPointer(GLKVertexAttribPosition, 2, GL_FLOAT, GL_FALSE, 0, vertices);
 glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
 */

	
	/*
	glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
    glVertexAttribPointer(GLKVertexAttribPosition, 2, GL_FLOAT, GL_FALSE, sizeof(GLKVector2), 0);
    glEnableVertexAttribArray(GLKVertexAttribPosition);
	
	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
    glDrawElements(GL_TRIANGLE_STRIP, sizeof(_indexBuffer)/sizeof(GLubyte), GL_UNSIGNED_BYTE, (void*)0);*/
}

#pragma mark - FUInterfaceRotation Methods

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
	[self updateProjection];
}

#pragma mark - Private Methods

- (void)updateProjection
{
	CGSize viewSize = [[[self director] view] bounds].size;
	GLKMatrix4 projectionMatrix = GLKMatrix4MakeOrtho(0, viewSize.width, viewSize.height, 0, -1, 1);
	[[[self effect] transform] setProjectionMatrix:projectionMatrix];
}

@end
