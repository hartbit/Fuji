//
//  FUTestAction.m
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUTestAction.h"


@implementation FUTestAction

- (id)copyWithZone:(NSZone*)zone
{
	return nil;
}

- (BOOL)isComplete
{
	return NO;
}

- (NSTimeInterval)consumeDeltaTime:(NSTimeInterval)deltaTime
{
	return 0.0;
}

@end
