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
#import "FUAction.h"


typedef FUTime (^FUTimingFunction)(FUTime t);


@interface FUTimingAction : FUFiniteAction

- (id)initWithAction:(id<FUAction>)action function:(FUTimingFunction)function;

@end
