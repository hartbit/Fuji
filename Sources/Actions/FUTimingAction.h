//
//  FUTimingAction.h
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUTimedAction.h"
#import "FUTimingFunctions.h"


@interface FUTimingAction : FUTimedAction

- (id)initWithAction:(FUTimedAction*)action function:(FUTimingFunction)function;

@end


FUTimingAction* FUTiming(FUTimedAction* action, FUTimingFunction function);
