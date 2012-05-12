//
//  FUFiniteAction.h
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


@interface FUFiniteAction : NSObject <FUAction>

- (id)initWithDuration:(FUTime)duration;

@property (nonatomic, readonly) FUTime duration;
@property (nonatomic, readonly) float factor;
@property (nonatomic, readonly, getter=isComplete) BOOL complete;

- (void)updateWithDeltaTime:(FUTime)deltaTime;
- (void)updateWithFactor:(float)factor;

@end
