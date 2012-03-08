//
//  MOTransform.h
//  Mocha2D
//
//  Created by David Hart on 01.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <GLKit/GLKit.h>
#import "MOComponent.h"


@interface MOTransform : MOComponent

@property (nonatomic) GLKVector2 position;
@property (nonatomic) float positionX;
@property (nonatomic) float positionY;
@property (nonatomic) float rotation;
@property (nonatomic) GLKVector2 scale;
@property (nonatomic) float scaleX;
@property (nonatomic) float scaleY;
@property (nonatomic, readonly) GLKMatrix4 matrix;

@end
