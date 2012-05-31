//
//  FUSpawnAction.h
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import <Foundation/Foundation.h>
#import "FUAction.h"


@interface FUSpawnAction : NSObject<FUAction>

- (id)initWithActions:(NSArray*)actions;

@property (nonatomic, copy, readonly) NSArray* actions;

@end


FUSpawnAction* FUSpawn(NSArray* actions);
