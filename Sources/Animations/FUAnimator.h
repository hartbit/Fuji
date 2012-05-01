//
//  FUAnimator.h
//  Fuji
//
//  Created by David Hart
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import <Foundation/Foundation.h>
#import "FUAnimatable.h"


@interface FUAnimator : NSObject <FUAnimatable>

@property (nonatomic, readonly) BOOL isComplete;

- (void)playAnimatable:(id<FUAnimatable>)animatable;
- (void)advanceTime:(NSTimeInterval)deltaTime;

@end
