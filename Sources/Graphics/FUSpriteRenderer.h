//
//  FUSpriteRenderer.h
//  Fuji
//
//  Created by Hart David on 02.04.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import "FUBehavior.h"
#import "FUColor.h"


@interface FUSpriteRenderer : FUBehavior

@property (nonatomic, copy) NSString* texture;
@property (nonatomic) FUColor color;

@end
