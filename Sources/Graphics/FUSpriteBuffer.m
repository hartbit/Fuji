//
//  FUSpriteBuffer.m
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUSpriteBuffer-Internal.h"
#import "FUEntity.h"
#import "FUTransform.h"
#import "FUSpriteRenderer.h"
#import "FUSpriteBatch-Internal.h"
#import "FUTexture-Internal.h"
#import "FUAssetStore-Internal.h"
#import "FUGraphicsTypes-Internal.h"
#import "FUAssert.h"


static const NSUInteger kDefaultCapacity = 100;
static const NSUInteger kIndexSpriteCount = 6;
static const NSUInteger kVertexSpriteCount = 4;


@interface FUSpriteBuffer ()

@property (nonatomic, WEAK) FUAssetStore* assetStore;
@property (nonatomic) FUIndex capacity;
@property (nonatomic) FUIndex count;
@property (nonatomic, strong) NSMutableDictionary* spriteBatches;
@property (nonatomic, strong) NSMutableData* indexData;
@property (nonatomic, strong) NSMutableData* vertexData;
@property (nonatomic) GLuint vertexArray;
@property (nonatomic) GLuint indexBuffer;
@property (nonatomic) GLuint vertexBuffer;

@end


@implementation FUSpriteBuffer

#pragma mark - Initialization

- (id)init
{
	FUThrow(@"");
}

- (id)initWithAssetStore:(FUAssetStore*)assetStore
{
	return [self initWithAssetStore:assetStore capacity:kDefaultCapacity];
}

- (id)initWithAssetStore:(FUAssetStore*)assetStore capacity:(unsigned short)capacity
{
	if ((self = [super init])) {
		[self setAssetStore:assetStore];
		[self setCapacity:capacity];
		[self setupArrayAndBuffers];
	}
	
	return self;
}

- (void)dealloc
{
	glDeleteVertexArraysOES(1, &_vertexArray);
	glDeleteBuffers(1, &_indexBuffer);
	glDeleteBuffers(1, &_vertexBuffer);
}

#pragma mark - Properties

- (void)setCapacity:(FUIndex)capacity
{
	if (capacity != _capacity) {
		_capacity = capacity;
		[self updateDataLength];
	}
}

- (void)setCount:(FUIndex)count
{
	if (count != _count) {
		_count = count;
		
		if (count > [self capacity]) {
			[self setCapacity:count * 4 / 3];
		}
	}
}

- (NSMutableDictionary*)spriteBatches
{
	if (_spriteBatches == nil) {
		[self setSpriteBatches:[NSMutableDictionary dictionary]];
	}
	
	return _spriteBatches;
}

- (NSMutableData*)indexData
{
	if (_indexData == nil) {
		[self setIndexData:[NSMutableData data]];
	}
	
	return _indexData;
}

- (NSMutableData*)vertexData
{
	if (_vertexData == nil) {
		[self setVertexData:[NSMutableData data]];
	}
	
	return _vertexData;
}

- (GLuint)vertexArray
{
	if (_vertexArray == 0) {
		glGenVertexArraysOES(1, &_vertexArray);
	}
	
	return _vertexArray;
}

- (GLuint)indexBuffer
{
	if (_indexBuffer == 0) {
		glGenBuffers(1, &_indexBuffer);
	}
	
	return _indexBuffer;
}

- (GLuint)vertexBuffer
{
	if (_vertexBuffer == 0) {
		glGenBuffers(1, &_vertexBuffer);
	}
	
	return _vertexBuffer;
}

#pragma mark - Public Methods

- (void)addSprite:(FUSpriteRenderer*)sprite
{
	NSString* textureString = [sprite texture];
	id textureKey = (textureString != nil) ? textureString : [NSNull null];
	FUSpriteBatch* batch = [self spriteBatches][textureKey];
	
	if (batch == nil) {
		if (textureString != nil) {
			FUTexture* texture = [[self assetStore] textureWithName:textureString];
			batch = [[FUSpriteBatch alloc] initWithTexture:texture];
		} else {
			batch = [FUSpriteBatch new];
		}
				
		[self spriteBatches][textureKey] = batch;
	}
	
	[batch addSprite:sprite];
	[self setCount:[self count] + 1];
}

- (void)removeSprite:(FUSpriteRenderer*)sprite
{
	NSString* textureString = [sprite texture];
	id textureKey = (textureString != nil) ? textureString : [NSNull null];
	FUSpriteBatch* batch = [self spriteBatches][textureKey];
	
	[batch removeSprite:sprite];
	[self setCount:[self count] - 1];
	
	if ([batch count] == 0) {
		[[self spriteBatches] removeObjectForKey:textureKey];
	}
}

- (void)removeAllSprites
{
	[[self spriteBatches] removeAllObjects];
}

- (void)drawWithEffect:(GLKBaseEffect*)effect
{
	[self checkTextureChanges];
	[self fillVertexBuffer];
	[self drawSpritesWithEffect:effect];
}

#pragma mark - Private Methods

- (void)setupArrayAndBuffers
{
	glBindVertexArrayOES([self vertexArray]);
	
	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, [self indexBuffer]);
	glBindBuffer(GL_ARRAY_BUFFER, [self vertexBuffer]);

	glEnableVertexAttribArray(GLKVertexAttribPosition);
	glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(FUVertex), (GLvoid*)offsetof(FUVertex, position));
	
	glEnableVertexAttribArray(GLKVertexAttribColor);
	glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, sizeof(FUVertex), (GLvoid*)offsetof(FUVertex, color));
	
	glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
	glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(FUVertex), (GLvoid*)offsetof(FUVertex, texCoord));
	
	glBindVertexArrayOES(0);
	
	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
	glBindBuffer(GL_ARRAY_BUFFER, 0);
	
	FUCheckOGLError();
}

- (void)updateDataLength
{
	NSMutableData* indexData = [self indexData];
	
	FUIndex oldCapacity = (FUIndex)[indexData length] / sizeof(FUIndex);
	FUIndex newCapacity = [self capacity];

	NSUInteger indexLength = newCapacity * kIndexSpriteCount * sizeof(FUIndex);
	[indexData setLength:indexLength];
	
	FUIndex* indices = [indexData mutableBytes];
	FUIndex indexIndex = (FUIndex)oldCapacity * kIndexSpriteCount;
	FUIndex vertexIndex = oldCapacity * kVertexSpriteCount;
	FUIndex indexCount = newCapacity * kIndexSpriteCount;
	FUIndex index0, index1, index2, index3;
	
	while (indexIndex < indexCount) {
		index0 = vertexIndex++;
		index1 = vertexIndex++;
		index2 = vertexIndex++;
		index3 = vertexIndex++;
			
		indices[indexIndex++] = index0;
		indices[indexIndex++] = index1;
		indices[indexIndex++] = index2;
		indices[indexIndex++] = index2;
		indices[indexIndex++] = index1;
		indices[indexIndex++] = index3;
	}

	if ([self indexBuffer] != 0) {
		glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, [self indexBuffer]);
		glBufferData(GL_ELEMENT_ARRAY_BUFFER, (GLsizeiptr)[indexData length], indices, GL_STATIC_DRAW);
		glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
	}
	
	NSMutableData* vertexData = [self vertexData];
	NSUInteger vertexLength = [self capacity] * kVertexSpriteCount * sizeof(FUVertex);
	[vertexData setLength:vertexLength];
	
	FUCheckOGLError();
}

- (void)checkTextureChanges
{
	NSMutableArray* spritesToUpdate = [NSMutableArray array];
	
	[[self spriteBatches] enumerateKeysAndObjectsUsingBlock:^(id textureKey, FUSpriteBatch* batch, BOOL* stop) {
		for (FUSpriteRenderer* sprite in batch) {
			NSString* spriteTexture = [sprite texture];
			
			if (((textureKey == [NSNull null]) && (spriteTexture != nil)) || ![spriteTexture isEqualToString:textureKey]) {
				[spritesToUpdate addObject:sprite];
			}
		}
	}];
	
	for (FUSpriteRenderer* sprite in spritesToUpdate) {
		[self removeSprite:sprite];
		[self addSprite:sprite];
	}
}

- (void)fillVertexBuffer
{
	static const GLKVector2 kT0 = { 0, 0 };
	static const GLKVector2 kT1 = { 0, 1 };
	static const GLKVector2 kT2 = { 1, 0 };
	static const GLKVector2 kT3 = { 1, 1 };
	
	FUVertex* vertices = [[self vertexData] mutableBytes];
	__block NSUInteger vertexIndex = 0;
	__block NSUInteger drawIndex = 0;
	
	[[self spriteBatches] enumerateKeysAndObjectsUsingBlock:^(id textureKey, FUSpriteBatch* batch, BOOL* stop) {
		FUTexture* texture = [batch texture];
		
		if (texture == nil) {
			return;
		}
		
		float halfWidth = [texture width] / 2;
		float halfHeight = [texture height] / 2;
		GLKVector3 kP0 = { -halfWidth, -halfHeight, 0 };
		GLKVector3 kP1 = { -halfWidth, halfHeight, 0 };
		GLKVector3 kP2 = { halfWidth, -halfHeight, 0 };
		GLKVector3 kP3 = { halfWidth, halfHeight, 0 };
		
		[batch setDrawIndex:drawIndex];
		NSUInteger drawCount = 0;
		
		for (FUSpriteRenderer* sprite in batch) {
			if (![sprite isEnabled]) {
				continue;
			}
			
			GLKMatrix4 matrix = [[[sprite entity] transform] matrix];			
			GLKVector3 p0 = GLKMatrix4MultiplyVector3WithTranslation(matrix, kP0);
			GLKVector3 p1 = GLKMatrix4MultiplyVector3WithTranslation(matrix, kP1);
			GLKVector3 p2 = GLKMatrix4MultiplyVector3WithTranslation(matrix, kP2);
			GLKVector3 p3 = GLKMatrix4MultiplyVector3WithTranslation(matrix, kP3);
			GLKVector4 color = [sprite tint];
			
			vertices[vertexIndex++] = FUVertexMake(p0, color, kT0);
			vertices[vertexIndex++] = FUVertexMake(p1, color, kT1);
			vertices[vertexIndex++] = FUVertexMake(p2, color, kT2);
			vertices[vertexIndex++] = FUVertexMake(p3, color, kT3);
			
			drawCount++;
		}
		
		[batch setDrawCount:drawCount];
		drawIndex += drawCount;
	}];
	
	glBindBuffer(GL_ARRAY_BUFFER, [self vertexBuffer]);
	glBufferData(GL_ARRAY_BUFFER, (GLsizeiptr)(vertexIndex * sizeof(FUVertex)), vertices, GL_DYNAMIC_DRAW);
	glBindBuffer(GL_ARRAY_BUFFER, 0);
	
	FUCheckOGLError();
}

- (void)drawSpritesWithEffect:(GLKBaseEffect*)effect
{
	glBindVertexArrayOES([self vertexArray]);

	GLKEffectPropertyTexture* textureProperty = [effect texture2d0];
	
	[[self spriteBatches] enumerateKeysAndObjectsUsingBlock:^(id textureKey, FUSpriteBatch* batch, BOOL* stop) {
		FUTexture* texture = [batch texture];
		
		if (texture == nil) {
			return;
		}
		
		if ([textureProperty name] != [texture name]) {
			[textureProperty setName:[texture name]];
			[effect prepareToDraw];
		}
		
		NSUInteger indexCount = [batch drawCount] * kIndexSpriteCount;
		NSUInteger indexOffset = [batch drawIndex] * kIndexSpriteCount * sizeof(FUIndex);
		glDrawElements(GL_TRIANGLES, (GLsizei)indexCount, FU_INDEX_TYPE, (GLvoid*)indexOffset);
	}];

	glBindVertexArrayOES(0);
	
	FUCheckOGLError();
}

@end
