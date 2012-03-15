//
//  MOGameObject.h
//  Mocha2D
//
//  Created by David Hart on 01.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MOMacros.h"


@class MOScene;
@class MOComponent;

@interface MOGameObject : NSObject

@property (nonatomic, WEAK, readonly) MOScene* scene;

- (MOComponent*)addComponentWithClass:(Class)componentClass;

@end
