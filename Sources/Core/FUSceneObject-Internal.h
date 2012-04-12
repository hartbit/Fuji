//
//  FUSceneObject-Internal.h
//  Fuji
//
//  Created by Hart David on 11.04.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FUMacros.h"


@class FUScene;

@interface FUSceneObject ()

@property (nonatomic, WEAK) FUScene* scene;

- (id)initWithScene:(FUScene*)scene;

- (void)register;
- (void)unregister;

@end