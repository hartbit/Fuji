//
//  FUScene.h
//  Fuji
//
//  Created by Hart David on 28.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FUGameObject.h"


@class FUGraphicsEngine;

@interface FUScene : FUGameObject <GLKViewControllerDelegate, GLKViewDelegate>

@property (nonatomic, WEAK, readonly) FUGraphicsEngine* graphics;

- (id)createGameObject;
- (void)removeGameObject:(FUGameObject*)gameObject;
- (NSSet*)allGameObjects;

@end
