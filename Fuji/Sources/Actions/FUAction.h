//
//  FUAction.h
//  Fuji
//
//  Created by David Hart
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import <Foundation/Foundation.h>
#import "FUMath.h"


@protocol FUAction <NSCopying>

@property (nonatomic, readonly, getter=isComplete) BOOL complete;

- (void)updateWithDeltaTime:(NSTimeInterval)deltaTime;

@end
