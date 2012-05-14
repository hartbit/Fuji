//
//  FUTimingAction.h
//  Fuji
//
//  Created by David Hart
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUFiniteAction.h"
#import "FUTimingFunctions.h"


@interface FUTimingAction : FUFiniteAction

- (id)initWithAction:(FUFiniteAction*)action function:(FUTimingFunction)function;

@end


#define FUTiming(_action, _function) [[FUTimingAction alloc] initWithAction:(_action) function:(_function)]