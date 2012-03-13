//
//  MOScene.h
//  Mocha2D
//
//  Created by Hart David on 28.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>


@class MOGameObject;

@interface MOScene : NSObject

@property (nonatomic, assign) GLKVector4 backgroundColor;

- (MOGameObject*)addGameObject;

@end
