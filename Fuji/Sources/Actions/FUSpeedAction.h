//
//  FUSpeedAction.h
//  Fuji
//
//  Created by David Hart
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import <Foundation/Foundation.h>
#import "FUAction.h"


@interface FUSpeedAction : NSObject <FUAction>

@property (nonatomic) float speed;

- (id)initWithAction:(id<FUAction>)action speed:(float)speed;

@end


#define FUSpeed(_action, _speed) [[FUSpeedAction alloc] initWithAction:(_action) speed:(_speed)]