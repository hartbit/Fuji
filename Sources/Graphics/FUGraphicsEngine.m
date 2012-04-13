//
//  FUGraphicsEngine.m
//  Fuji
//
//  Created by Hart David on 30.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#include "Prefix.pch"
#import "FUMath.h"
#import "FUColor.h"
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


static const NSUInteger kIndexSpriteCount = 6;
static const NSUInteger kVertexSpriteCount = 4;
static const NSUInteger kIndexSpriteStride = kIndexSpriteCount * sizeof(GLushort);
static const NSUInteger kVertexSpriteStride = kVertexSpriteCount * sizeof(FUVertex);


@interface FUGraphicsEngine ()

@property (nonatomic, strong) GLKBaseEffect* effect;
@property (nonatomic, strong) FUGraphicsSettings* settings;
@property (nonatomic, strong) NSMutableArray* renderers;
@property (nonatomic, strong) NSMutableData* vertexData;
@property (nonatomic, strong) NSMutableData* indexData;

@end


@implementation FUGraphicsEngine

@synthesize effect = _effect;
@synthesize settings = _settings;
@synthesize renderers = _renderers;
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

- (NSMutableArray*)renderers
{
	if (_renderers == NULL)
	{
		[self setRenderers:[NSMutableArray array]];
	}
	
	return _renderers;
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

#pragma mark - Registration

- (void)registerFUScene:(FUScene*)scene
{
	[self setSettings:[scene graphics]];
}

- (void)registerFUSpriteRenderer:(FUSpriteRenderer*)renderer
{
	[[self renderers] addObject:renderer];
	[[self indexData] increaseLengthBy:kIndexSpriteStride];
	[[self vertexData] increaseLengthBy:kVertexSpriteStride];
}

- (void)unregisterAll
{
	[self setSettings:nil];
	[[self renderers] removeAllObjects];
}

#pragma mark - Drawing

- (void)update
{
	for (FUSpriteRenderer* renderer in [self renderers])
	{
		FUTransform* transform = [[renderer entity] transform];
		[transform setPosition:GLKVector2Make(floorf(FURandomDouble(0, 320)), floorf(FURandomDouble(0, 480)))];
	}
}

- (void)draw
{
	[self clearScreen];
	[self fillSpriteData];
	[self drawSprites];
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

- (void)clearScreen
{
	FUGraphicsSettings* settings = [self settings];
	GLKVector4 backgroundColor = (settings != nil) ? [settings backgroundColor] : FUColorBlack;
	glClearColor(backgroundColor.r, backgroundColor.g, backgroundColor.b, backgroundColor.a);
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
}

- (void)fillSpriteData
{
	GLushort i0 = 0;
	GLushort i1 = 1;
	GLushort i2 = 2;
	GLushort i3 = 3;
	GLushort* indices = [[self indexData] mutableBytes];
	FUVertex* vertices = [[self vertexData] mutableBytes];
	
	static const CGFloat kHalfSize = 0.5f;
	static const CGFloat kDepth = 1.0f;
	static const GLKVector3 kP0 = { -kHalfSize, -kHalfSize, kDepth };
	static const GLKVector3 kP1 = { -kHalfSize, kHalfSize, kDepth };
	static const GLKVector3 kP2 = { kHalfSize, -kHalfSize, kDepth };
	static const GLKVector3 kP3 = { kHalfSize, kHalfSize, kDepth };
	static const GLKVector2 kT0 = { 0, 0 };
	static const GLKVector2 kT1 = { 0, 1 };
	static const GLKVector2 kT2 = { 1, 0 };
	static const GLKVector2 kT3 = { 1, 1 };
	
	for (FUSpriteRenderer* renderer in [self renderers])
	{
		*indices++ = i0;
		*indices++ = i1;
		*indices++ = i2;
		*indices++ = i2;
		*indices++ = i1;
		*indices++ = i3;
		
		i0 += kVertexSpriteCount;
		i1 += kVertexSpriteCount;
		i2 += kVertexSpriteCount;
		i3 += kVertexSpriteCount;
		
		GLKMatrix4 matrix = [[[renderer entity] transform] matrix];
		GLKVector3 p0 = GLKMatrix4MultiplyVector3WithTranslation(matrix, kP0);
		GLKVector3 p1 = GLKMatrix4MultiplyVector3WithTranslation(matrix, kP1);
		GLKVector3 p2 = GLKMatrix4MultiplyVector3WithTranslation(matrix, kP2);
		GLKVector3 p3 = GLKMatrix4MultiplyVector3WithTranslation(matrix, kP3);
		GLKVector4 color = [renderer color];
		
		*vertices++ = FUVertexMake(p0, color, kT0);
		*vertices++ = FUVertexMake(p1, color, kT1);
		*vertices++ = FUVertexMake(p2, color, kT2);
		*vertices++ = FUVertexMake(p3, color, kT3);
	}
}

- (void)drawSprites
{
	[[self effect] prepareToDraw];
	
	glEnableVertexAttribArray(GLKVertexAttribPosition);
	glEnableVertexAttribArray(GLKVertexAttribColor);
	glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
	
	FUVertex* vertices = [[self vertexData] mutableBytes];
	glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(FUVertex), &vertices[0].position);
	glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, sizeof(FUVertex), &vertices[0].color);
	glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(FUVertex), &vertices[0].texCoord);	
	
	NSMutableData* indexData = [self indexData];
	NSUInteger indexCount = [indexData length] / sizeof(GLushort);
	GLushort* indices = [indexData mutableBytes];
	glDrawElements(GL_TRIANGLES, indexCount, GL_UNSIGNED_SHORT, indices);
}

@end
