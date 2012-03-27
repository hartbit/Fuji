//
//  FUScene.h
//  Fuji
//
//  Created by Hart David on 28.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FUEntity.h"


@class FUGraphicsEngine;

@interface FUScene : FUEntity <GLKViewControllerDelegate, GLKViewDelegate>

@property (nonatomic, WEAK, readonly) FUGraphicsEngine* graphics;

- (id)createEntity;
- (void)removeEntity:(FUEntity*)entity;
- (NSSet*)allEntitys;

@end
