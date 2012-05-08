//
//  FUSequenceAction.h
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


@interface FUSequenceAction : FUFiniteAction

+ (FUSequenceAction*)sequenceWithActions:(FUFiniteAction*)actions, ... NS_REQUIRES_NIL_TERMINATION;
+ (FUSequenceAction*)sequenceWithArray:(NSArray*)array;
- (id)initWithActions:(FUFiniteAction*)actions, ... NS_REQUIRES_NIL_TERMINATION;
- (id)initWithArray:(NSArray*)array;

@end
