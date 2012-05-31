//
//  FUGroupAction.h
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUTimedAction.h"


@interface FUGroupAction : FUTimedAction

- (id)initWithActions:(NSArray*)actions;

@property (nonatomic, copy, readonly) NSArray* actions;

@end


FUGroupAction* FUGroup(NSArray* actions);