//
//  FUSpriteBatch-Internal.h
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import <Foundation/Foundation.h>
#import "FUGraphicsTypes-Internal.h"


@class FUTexture;
@class FUSpriteRenderer;

@interface FUSpriteBatch : NSObject <NSFastEnumeration>

@property (nonatomic, strong, readonly) FUTexture* texture;
@property (nonatomic, strong, readonly) NSString* textureName;
@property (nonatomic, strong, readonly) NSMutableArray* sprites;
@property (nonatomic, readonly) NSUInteger count;
@property (nonatomic) NSUInteger drawOffset;
@property (nonatomic) NSUInteger drawCount;

- (id)initWithTexture:(FUTexture*)texture withName:(NSString*)name;

- (void)addSprite:(FUSpriteRenderer*)sprite;
- (void)removeSprite:(FUSpriteRenderer*)sprite;
- (NSArray*)removeInvalidSprites;

@end
