//
//  FUSpriteBatch.m
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUSpriteBatch-Internal.h"
#import "FUSpriteRenderer.h"
#import "FUTransform.h"
#import "FUEntity.h"
#import "FUTexture-Internal.h"
#import "FUSupport.h"


@interface FUSpriteBatch ()

@property (nonatomic, strong) FUTexture* texture;
@property (nonatomic, strong) NSString* textureName;
@property (nonatomic, strong) NSMutableArray* sprites;

@end


@implementation FUSpriteBatch

#pragma mark - Initialization

- (id)initWithTexture:(FUTexture*)texture withName:(NSString*)name
{
	if ((self = [super init])) {
		[self setTexture:texture];
		[self setTextureName:name];
	}
	
	return self;
}

#pragma mark - Properties

- (NSUInteger)count
{
	return [[self sprites] count];
}

- (NSMutableArray*)sprites
{
	if (_sprites == nil) {
		[self setSprites:[NSMutableArray new]];
	}
	
	return _sprites;
}

#pragma mark - Public Methods

- (void)addSprite:(FUSpriteRenderer*)sprite
{
	[[self sprites] addObject:sprite];
}

- (void)removeSprite:(FUSpriteRenderer*)sprite
{
	[[self sprites] removeObject:sprite];
}

- (NSArray*)removeInvalidSprites
{
	NSMutableArray* sprites = [self sprites];
	NSString* textureName = [self textureName];
	BOOL hasTexture = [self texture] != nil;
	
	NSIndexSet* invalidSpriteIndices = [sprites indexesOfObjectsPassingTest:^BOOL(FUSpriteRenderer* sprite, NSUInteger index, BOOL* stop) {
		if (hasTexture) {
			return ![[sprite texture] isEqualToString:textureName];
		} else {
			return [sprite texture] != nil;
		}
	}];

	NSArray* invalidSprites = [sprites objectsAtIndexes:invalidSpriteIndices];
	
	for (FUSpriteRenderer* sprite in invalidSprites) {
		[self removeSprite:sprite];
	}
	
	return invalidSprites;
}

#pragma mark - NSFastEnumeration Methods

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState*)state objects:(id __unsafe_unretained []) stackbuf count:(NSUInteger)len
{
	return [[self sprites] countByEnumeratingWithState:state objects:stackbuf count:len];
}

@end
