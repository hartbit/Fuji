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
#import "FUVisitor.h"
#import "FUDirector.h"
#import "FUScene.h"
#import "FUGraphicsEngine.h"
#import "FUGraphicsSettings.h"
#import "FUSpriteRenderer.h"
#import "FUTransform.h"
#import "FUAssetStore.h"
#import "FUAssetStore-Internal.h"
#import "FUTexture-Internal.h"


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


@interface FUGraphicsRegistrationVisitor : FUVisitor
@property (nonatomic, WEAK) FUGraphicsEngine* graphicsEngine;
@end

@interface FUGraphicsUnregistrationVisitor : FUVisitor
@property (nonatomic, WEAK) FUGraphicsEngine* graphicsEngine;
@end

@interface FUDrawBatch : NSObject
@property (nonatomic, strong) FUTexture* texture;
@property (nonatomic, strong) NSMutableArray* renderers;
@end


@interface FUGraphicsEngine ()

@property (nonatomic, strong) FUVisitor* registrationVisitor;
@property (nonatomic, strong) FUVisitor* unregistrationVisitor;
@property (nonatomic, strong) GLKBaseEffect* effect;
@property (nonatomic, strong) FUGraphicsSettings* settings;
@property (nonatomic, strong) NSMutableDictionary* drawBatches;
@property (nonatomic, strong) NSMutableData* vertexData;
@property (nonatomic, strong) NSMutableData* indexData;

@end


@implementation FUGraphicsEngine

@synthesize registrationVisitor = _registrationVisitor;
@synthesize unregistrationVisitor = _unregistrationVisitor;
@synthesize effect = _effect;
@synthesize settings = _settings;
@synthesize drawBatches = _drawBatches;
@synthesize vertexData = _vertexData;
@synthesize indexData = _indexData;

#pragma mark - Initialization

- (id)init
{
	self = [super init];
	if (self == nil) return nil;
	
	glEnable(GL_CULL_FACE);
	glEnable(GL_DEPTH_TEST);
	glEnable(GL_BLEND);
	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
	glDepthFunc(GL_LEQUAL);
	glClearDepthf(1.0f);
	
	return self;
}

#pragma mark - Properties

- (FUVisitor*)registrationVisitor
{
	if (_registrationVisitor == nil)
	{
		FUGraphicsRegistrationVisitor* visitor = [FUGraphicsRegistrationVisitor new];
		[self setRegistrationVisitor:visitor];
		
		[visitor setGraphicsEngine:self];
	}
	
	return _registrationVisitor;
}

- (FUVisitor*)unregistrationVisitor
{
	if (_unregistrationVisitor == nil)
	{
		FUGraphicsUnregistrationVisitor* visitor = [FUGraphicsUnregistrationVisitor new];
		[self setUnregistrationVisitor:visitor];
		
		[visitor setGraphicsEngine:self];
	}
	
	return _unregistrationVisitor;
}

- (GLKBaseEffect*)effect
{
	if (_effect == nil)
	{
		GLKBaseEffect* effect = [GLKBaseEffect new];
		[self setEffect:effect];
		
		GLKEffectPropertyTexture* textureProperty = [[self effect] texture2d0];
		[textureProperty setEnvMode:GLKTextureEnvModeModulate];
		[textureProperty setTarget:GLKTextureTarget2D];
		
		[self updateProjection];
	}
 
	return _effect;
}

- (NSMutableDictionary*)drawBatches
{
	if (_drawBatches == nil)
	{
		[self setDrawBatches:[NSMutableDictionary dictionary]];
	}
	
	return _drawBatches;
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

#pragma mark - FUEngine Methods

- (void)unregisterAll
{
	[self setSettings:nil];
	[[self drawBatches] removeAllObjects];
}

#pragma mark - Drawing

- (void)update
{
	NSTimeInterval speed = [[self director] timeSinceFirstResume] * 5;
	
	[[self drawBatches] enumerateKeysAndObjectsUsingBlock:^(id key, FUDrawBatch* batch, BOOL* stop) {
		[[batch	renderers] enumerateObjectsUsingBlock:^(FUSpriteRenderer* renderer, NSUInteger idx, BOOL* stop) {
			FUTransform* transform = [[renderer entity] transform];
			float scale = cosf(idx + speed) * 0.25f + 0.5f;
			[transform setScale:GLKVector2Make(scale, scale)];
			
			float rotation = 0.1f * (idx + speed) * M_PI;
			[transform setRotation:rotation];
		}];
	}];
}

- (void)draw
{
	[self setConstants];	
	[self clearScreen];
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

- (void)setConstants
{
	static BOOL constantsSet = NO;
	
	if (!constantsSet)
	{
		[[self effect] prepareToDraw];
		
		glEnableVertexAttribArray(GLKVertexAttribPosition);
		glEnableVertexAttribArray(GLKVertexAttribColor);
		glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
		
		FUVertex* vertices = [[self vertexData] mutableBytes];
		glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(FUVertex), &vertices[0].position);
		glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, sizeof(FUVertex), &vertices[0].color);
		glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(FUVertex), &vertices[0].texCoord);	
		
		constantsSet = YES;
	}	
}

- (void)clearScreen
{
	FUGraphicsSettings* settings = [self settings];
	GLKVector4 backgroundColor = (settings != nil) ? [settings backgroundColor] : FUColorBlack;
	glClearColor(backgroundColor.r, backgroundColor.g, backgroundColor.b, backgroundColor.a);
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
}

- (void)drawSprites
{
	static const GLKVector2 kT0 = { 0, 0 };
	static const GLKVector2 kT1 = { 0, 1 };
	static const GLKVector2 kT2 = { 1, 0 };
	static const GLKVector2 kT3 = { 1, 1 };
	
	GLKEffectPropertyTexture* textureProperty = [[self effect] texture2d0];
	GLushort* indices = [[self indexData] mutableBytes];
	FUVertex* vertices = [[self vertexData] mutableBytes];
	__block NSUInteger indexIndex = 0;
	__block NSUInteger vertexIndex = 0;
	__block NSUInteger spriteCount = 0;
	__block GLushort i0 = 0;
	__block GLushort i1 = 1;
	__block GLushort i2 = 2;
	__block GLushort i3 = 3;
	
	[[self drawBatches] enumerateKeysAndObjectsUsingBlock:^(id key, FUDrawBatch* batch, BOOL* stop) {
		FUTexture* texture = [batch texture];
		
		if ([textureProperty name] != [texture name])
		{
			[textureProperty setName:[texture name]];
			[[self effect] prepareToDraw];
		}
		
		float halfWidth = [texture width] / 2;
		float halfHeight = [texture height] / 2;
		GLKVector3 kP0 = { -halfWidth, -halfHeight, 0 };
		GLKVector3 kP1 = { -halfWidth, halfHeight, 0 };
		GLKVector3 kP2 = { halfWidth, -halfHeight, 0 };
		GLKVector3 kP3 = { halfWidth, halfHeight, 0 };
		
		GLushort* indicesStart = indices;
		
		for (FUSpriteRenderer* renderer in [batch renderers])
		{
			if (![renderer isEnabled])
			{
				continue;
			}
			
			indices[indexIndex++] = i0;
			indices[indexIndex++] = i1;
			indices[indexIndex++] = i2;
			indices[indexIndex++] = i2;
			indices[indexIndex++] = i1;
			indices[indexIndex++] = i3;
			
			GLKMatrix4 matrix = [[[renderer entity] transform] matrix];
			GLKVector3 p0 = GLKMatrix4MultiplyVector3WithTranslation(matrix, kP0);
			GLKVector3 p1 = GLKMatrix4MultiplyVector3WithTranslation(matrix, kP1);
			GLKVector3 p2 = GLKMatrix4MultiplyVector3WithTranslation(matrix, kP2);
			GLKVector3 p3 = GLKMatrix4MultiplyVector3WithTranslation(matrix, kP3);
			GLKVector4 color = [renderer color];
			
			vertices[vertexIndex++] = FUVertexMake(p0, color, kT0);
			vertices[vertexIndex++] = FUVertexMake(p1, color, kT1);
			vertices[vertexIndex++] = FUVertexMake(p2, color, kT2);
			vertices[vertexIndex++] = FUVertexMake(p3, color, kT3);
			
			spriteCount++;
			i0 += kVertexSpriteCount;
			i1 += kVertexSpriteCount;
			i2 += kVertexSpriteCount;
			i3 += kVertexSpriteCount;
		}
		
		NSUInteger indexCount = spriteCount * kIndexSpriteCount;
		glDrawElements(GL_TRIANGLES, indexCount, GL_UNSIGNED_SHORT, indicesStart);
	}];
}

@end


@implementation FUGraphicsRegistrationVisitor

@synthesize graphicsEngine = _graphicsEngine;

- (void)visitFUScene:(FUScene*)scene
{
	[[self graphicsEngine] setSettings:[scene graphics]];
}

- (void)visitFUSpriteRenderer:(FUSpriteRenderer*)renderer
{
	FUGraphicsEngine* graphicsEngine = [self graphicsEngine];
	
	NSString* rendererTexture = [renderer texture];
	id textureKey = (rendererTexture != nil) ? rendererTexture : [NSNull null];
	FUDrawBatch* batch = [[graphicsEngine drawBatches] objectForKey:textureKey];
	
	if (batch == nil)
	{
		batch = [FUDrawBatch new];
		[batch setRenderers:[NSMutableArray array]];
		
		if (rendererTexture != nil)
		{
			FUTexture* texture = [[[graphicsEngine director] assetStore] textureWithName:rendererTexture];
			[batch setTexture:texture];
		}
		
		[[graphicsEngine drawBatches] setObject:batch forKey:textureKey];
	}
	
	[[batch renderers] addObject:renderer];
	
	[[graphicsEngine indexData] increaseLengthBy:kIndexSpriteStride];
	[[graphicsEngine vertexData] increaseLengthBy:kVertexSpriteStride];
}

@end


@implementation FUGraphicsUnregistrationVisitor

@synthesize graphicsEngine = _graphicsEngine;

- (void)unregisterFUSpriteRenderer:(FUSpriteRenderer*)renderer
{
	FUGraphicsEngine* graphicsEngine = [self graphicsEngine];
	
	NSString* rendererTexture = [renderer texture];
	id textureKey = (rendererTexture != nil) ? rendererTexture : [NSNull null];
	FUDrawBatch* batch = [[graphicsEngine drawBatches] objectForKey:textureKey];
	
	[[batch renderers] removeObject:renderer];
	
	if ([[batch renderers] count] == 0)
	{
		[[graphicsEngine drawBatches] removeObjectForKey:textureKey];
	}
	
	NSMutableData* indexData = [graphicsEngine indexData];
	[indexData setLength:[indexData length] - kIndexSpriteStride];
	
	NSMutableData* vertexData = [graphicsEngine vertexData];
	[vertexData setLength:[vertexData length] - kVertexSpriteStride];
}

@end


@implementation FUDrawBatch
@synthesize texture = _texture;
@synthesize renderers = _renderers;
@end

