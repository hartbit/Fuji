//
//  FUSpriteBatch.m
//  Fuji
//
//  Created by David Hart on 4/24/12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "FUSpriteBatch.h"
#import "FUSupport.h"


@interface FUSpriteBatch ()

@property (nonatomic, strong) FUTexture* texture;
@property (nonatomic, strong) NSMutableSet* sprites;

@end


@implementation FUSpriteBatch

@synthesize drawIndex = _drawIndex;
@synthesize drawCount = _drawCount;
@synthesize texture = _texture;
@synthesize sprites = _sprites;

#pragma mark - Properties

- (NSUInteger)count
{
	return [[self sprites] count];
}

- (NSMutableSet*)sprites
{
	if (_sprites == nil)
	{
		[self setSprites:[NSMutableSet set]];
	}
	
	return _sprites;
}

#pragma mark - Initialization

- (id)initWithTexture:(FUTexture*)texture
{
	self = [super init];
	if (self == nil) return nil;
	
	[self setTexture:texture];
	
	return self;
}

#pragma mark - Public Methods

- (void)addSprite:(FUSpriteRenderer*)sprite
{
	[[self sprites] addObject:sprite];
}

- (void)removeSprite:(FUSpriteRenderer*)sprite
{
	FUAssert([[self sprites] containsObject:sprite], @"");
	[[self sprites] removeObject:sprite];
}

#pragma mark - NSFastEnumeration Methods

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState*)state objects:(id __unsafe_unretained []) stackbuf count:(NSUInteger)len
{
	return [[self sprites] countByEnumeratingWithState:state objects:stackbuf count:len];
}

@end
