//
//  FUSpriteRenderer.h
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import "FUBehavior.h"
#import "FUColor.h"


@interface FUSpriteRenderer : FUBehavior

@property (nonatomic, copy) NSString* texture;
@property (nonatomic) GLKVector4 color;

@end
