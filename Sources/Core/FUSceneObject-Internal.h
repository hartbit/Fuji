//
//  FUSceneObject-Internal.h
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
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
