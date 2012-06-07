//
//  FUEntity.h
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import <Foundation/Foundation.h>
#import "FUSceneObject.h"
#import "FUSupport.h"


@class FUComponent;
@class FUTransform;
@class FURenderer;

@interface FUEntity : FUSceneObject

@property (nonatomic, WEAK, readonly) FUTransform* transform;
@property (nonatomic, WEAK, readonly) FURenderer* renderer;

- (id)addComponentWithClass:(Class)componentClass;
- (void)removeComponent:(FUComponent*)component;
- (id)componentWithClass:(Class)componentClass;
- (NSArray*)allComponentsWithClass:(Class)componentClass;
- (NSArray*)allComponents;

@end
