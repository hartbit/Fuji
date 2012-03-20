//
//  FUGameObject-Internal.h
//  Fuji
//
//  Created by Hart David on 12.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//


@class FUScene;

@interface FUGameObject ()

@property (nonatomic, WEAK) FUScene* scene;

- (id)initWithScene:(FUScene*)scene;

@end