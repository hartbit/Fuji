//
//  MOComponent.h
//  Mocha2D
//
//  Created by David Hart on 01.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <Foundation/Foundation.h>


@class MOGameObject;

@interface MOComponent : NSObject

@property (nonatomic, weak, readonly) MOGameObject* gameObject;

- (void)awake;

@end
