//
//  FUSpeedAction.h
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import <Foundation/Foundation.h>
#import "FUAction.h"


@interface FUSpeedAction : NSObject<FUAction>

- (id)initWithAction:(id<FUAction>)action speed:(float)speed;

@property (nonatomic, strong, readonly) id<FUAction> action;
@property (nonatomic) float speed;

@end


FUSpeedAction* FUSpeed(id<FUAction> action, float speed);
