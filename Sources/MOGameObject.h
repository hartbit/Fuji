//
//  MOGameObject.h
//  Mocha2D
//
//  Created by David Hart on 01.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <Foundation/Foundation.h>


@class MOComponent;

@interface MOGameObject : NSObject

- (MOComponent*)addComponentWithClass:(Class)componentClass;

@end
