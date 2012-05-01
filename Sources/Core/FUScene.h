//
//  FUScene.h
//  Fuji
//
//  Created by David Hart
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import <Foundation/Foundation.h>
#import "FUEntity.h"


@class FUDirector;
@class FUGraphicsSettings;

@interface FUScene : FUEntity

@property (nonatomic, WEAK, readonly) FUDirector* director;
@property (nonatomic, WEAK, readonly) FUGraphicsSettings* graphics;

+ (id)scene;

- (FUEntity*)createEntity;
- (void)removeEntity:(FUEntity*)entity;
- (NSArray*)allEntities;

@end
