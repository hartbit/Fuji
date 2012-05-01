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
#import "FUAction.h"


@interface FUAnimator : NSObject <FUAction>

@property (nonatomic, readonly) BOOL isComplete;

- (void)runAction:(id<FUAction>)action;
- (void)advanceTime:(NSTimeInterval)deltaTime;

@end