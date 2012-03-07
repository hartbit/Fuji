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

@property (nonatomic, readonly) GLKVector2 position;
@property (nonatomic, readonly) float rotation;
@property (nonatomic, readonly) GLKVector2 scale;

@end
