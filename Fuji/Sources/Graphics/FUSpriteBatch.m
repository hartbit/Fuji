//
//  FUSpriteBatch.m
//  Fuji
//
//  Created by David Hart
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUSpriteBatch-Internal.h"
#import "FUSupport.h"


@interface FUSpriteBatch ()

@property (nonatomic, strong) FUTexture* texture;
@property (nonatomic, strong) NSMutableArray* sprites;

@end


@implementation FUSpriteBatch

@synthesize drawIndex = _drawIndex;
@synthesize drawCount = _drawCount;
@synthesize texture = _texture;
@synthesize sprites = _sprites;

#pragma mark - Initialization

- (id)initWithTexture:(FUTexture*)texture
{
	if ((self = [super init])) {
		[self setTexture:texture];
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
		[self setSprites:[NSMutableArray array]];
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

#pragma mark - NSFastEnumeration Methods

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState*)state objects:(id __unsafe_unretained []) stackbuf count:(NSUInteger)len
{
	return [[self sprites] countByEnumeratingWithState:state objects:stackbuf count:len];
}

@end
