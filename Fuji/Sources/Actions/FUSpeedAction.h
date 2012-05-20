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


static OBJC_INLINE FUSpeedAction* FUSpeed(id<FUAction> action, float speed)
{
	return [[FUSpeedAction alloc] initWithAction:action speed:speed];
}