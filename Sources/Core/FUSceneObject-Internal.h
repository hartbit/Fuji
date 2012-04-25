//
//  FUSceneObject-Internal.h
//  Fuji
//
//  Created by Hart David on 11.04.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "FUSceneObject.h"
#import "FUSupport.h"


@class FUScene;
@class FUVisitor;

@interface FUSceneObject ()

@property (nonatomic, WEAK) FUScene* scene;

- (id)initWithScene:(FUScene*)scene;

- (void)acceptVisitor:(FUVisitor*)visitor;

@end