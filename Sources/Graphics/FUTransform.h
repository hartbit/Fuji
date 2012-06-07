//
//  FUTransform.h
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import <GLKit/GLKit.h>
#import "FUComponent.h"


@interface FUTransform : FUComponent

@property (nonatomic) GLKVector2 position;
@property (nonatomic) float positionX;
@property (nonatomic) float positionY;
@property (nonatomic) float depth;
@property (nonatomic) float rotation;
@property (nonatomic) GLKVector2 scale;
@property (nonatomic) float scaleX;
@property (nonatomic) float scaleY;
@property (nonatomic, readonly) GLKMatrix4 matrix;

@end
