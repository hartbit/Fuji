//
//  FUScene.h
//  Fuji
//
//  Created by Hart David on 28.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
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
- (NSSet*)allEntities;

@end
