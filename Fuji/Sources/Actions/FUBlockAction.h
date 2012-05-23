//
//  FUBlockAction.h
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUFiniteAction.h"


@interface FUBlockAction : NSObject<FUAction>

- (id)initWithBlock:(void (^)())block;

@end


static OBJC_INLINE FUBlockAction* FUBlock(void (^block)())
{
	return [[FUBlockAction alloc] initWithBlock:block];
}