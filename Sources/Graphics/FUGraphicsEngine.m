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


typedef struct
{
	GLKVector3 position;
	GLKVector4 color;
	GLKVector2 texCoord;
} FUVertex;


static inline FUVertex FUVertexMake(GLKVector3 position, GLKVector4 color, GLKVector2 texCoord)
{
	return (FUVertex){ position, color, texCoord };
}


@interface FUGraphicsEngine ()

@property (nonatomic, strong) GLKBaseEffect* effect;
@property (nonatomic, WEAK) FUGraphicsSettings* settings;
@property (nonatomic) GLKMatrixStackRef matrixStack;
@property (nonatomic) NSMutableData* vertexData;
@property (nonatomic) NSMutableData* indexData;

@end


@implementation FUGraphicsEngine

@synthesize effect = _effect;
@synthesize settings = _settings;
@synthesize matrixStack = _matrixStack;
@synthesize vertexData = _vertexData;
@synthesize indexData = _indexData;

#pragma mark - Initialization

- (id)init
{
	self = [super init];
	if (self == nil) return nil;
	
	glEnable(GL_CULL_FACE);
	glEnable(GL_DEPTH_TEST);
	glDepthFunc(GL_LEQUAL);
	glClearDepthf(1.0f);
	
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

- (NSMutableData*)vertexData
{
	if (_vertexData == nil)
	{
		[self setVertexData:[NSMutableData data]];
	}
	
	return _vertexData;
}

- (NSMutableData*)indexData
{
	if (_indexData == nil)
	{
		[self setIndexData:[NSMutableData data]];
	}
	
	return _indexData;
}

#pragma mark - Drawing

- (void)drawSceneEnter:(FUScene*)scene
{
	FUGraphicsSettings* settings = [scene graphics];
	[self setSettings:settings];
	
	GLKVector4 backgroundColor = [settings backgroundColor];
	glClearColor(backgroundColor.r, backgroundColor.g, backgroundColor.b, backgroundColor.a);
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
}

- (void)drawSceneLeave:(FUScene*)scene
{	
	[[self effect] prepareToDraw];
	
	glEnableVertexAttribArray(GLKVertexAttribPosition);
	glEnableVertexAttribArray(GLKVertexAttribColor);
	glEnableVertexAttribArray(GLKVertexAttribTexCoord0);

	FUVertex* vertices = [[self vertexData] mutableBytes];
	glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(FUVertex), &vertices[0].position);
	glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, sizeof(FUVertex), &vertices[0].color);
	glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(FUVertex), &vertices[0].texCoord);	

	NSUInteger indicesLength = [[self indexData] length];
	NSUInteger indexCount = indicesLength / sizeof(GLushort);
	GLushort* indices = [[self indexData] mutableBytes];
	glDrawElements(GL_TRIANGLES, indexCount, GL_UNSIGNED_SHORT, indices);
	
	glDisableVertexAttribArray(GLKVertexAttribPosition);
	glDisableVertexAttribArray(GLKVertexAttribColor);
	glDisableVertexAttribArray(GLKVertexAttribTexCoord0);
	
	[[self vertexData] setLength:0];
	[[self indexData] setLength:0];
}

- (void)updateTransform:(FUTransform*)transform
{
	[transform setPosition:GLKVector2Make(floorf(FURandomDouble(0, 320)), floorf(FURandomDouble(0, 480)))];
}

- (void)drawSpriteRenderer:(FUSpriteRenderer*)spriteRenderer
{
	const CGFloat width = 1;
	const CGFloat height = 1;
	
	NSMutableData* vertexData = [self vertexData];
	GLushort i0 = [vertexData length] / sizeof(FUVertex);
	GLushort i1 = i0 + 1;
	GLushort i2 = i0 + 2;
	GLushort i3 = i0 + 3;
	GLushort indices[] = { i0, i1, i2, i2, i1, i3 };
	NSUInteger indicesLength = sizeof(GLushort) * 6;
	[[self indexData] appendBytes:&indices length:indicesLength];
	
	CGFloat halfWidth = width / 2;
	CGFloat halfHeight = height / 2;
	FUEntity* entity = [spriteRenderer entity];
	FUTransform* transform = [entity transform];
	GLKMatrix4 matrix = [transform matrix];
	GLKVector3 p0 = GLKMatrix4MultiplyVector3WithTranslation(matrix, GLKVector3Make(-halfWidth, -halfHeight, 1));
	GLKVector3 p1 = GLKMatrix4MultiplyVector3WithTranslation(matrix, GLKVector3Make(-halfWidth, halfHeight, 1));
	GLKVector3 p2 = GLKMatrix4MultiplyVector3WithTranslation(matrix, GLKVector3Make(halfWidth, -halfHeight, 1));
	GLKVector3 p3 = GLKMatrix4MultiplyVector3WithTranslation(matrix, GLKVector3Make(halfWidth, halfHeight, 1));
	GLKVector4 color = [spriteRenderer color];
	GLKVector2 t0 = GLKVector2Make(0, 0);
	GLKVector2 t1 = GLKVector2Make(0, 1);
	GLKVector2 t2 = GLKVector2Make(1, 0);
	GLKVector2 t3 = GLKVector2Make(1, 1);
	FUVertex v0 = FUVertexMake(p0, color, t0);
	FUVertex v1 = FUVertexMake(p1, color, t1);
	FUVertex v2 = FUVertexMake(p2, color, t2);
	FUVertex v3 = FUVertexMake(p3, color, t3);
	FUVertex vertices[] = { v0, v1, v2, v3 };
	NSUInteger verticesLength = sizeof(FUVertex) * 4;
	[vertexData appendBytes:&vertices length:verticesLength];
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
	GLKMatrix4 projectionMatrix = GLKMatrix4MakeOrtho(0, viewSize.width, viewSize.height, 0, 0, FLT_MAX);
	[[[self effect] transform] setProjectionMatrix:projectionMatrix];
	[[self effect] prepareToDraw];
}

@end
