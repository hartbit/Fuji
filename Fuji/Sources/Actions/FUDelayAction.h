//
//  FUDelayAction.h
//  Fuji
//
//  Created by David Hart
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import <Foundation/Foundation.h>
#import "FUFiniteAction.h"


@interface FUDelayAction : FUFiniteAction

- (id)initWithDelay:(FUTime)delay;

@end


#define FUDelay(_delay) [[FUDelayAction alloc] initWithDelay:(_delay)]