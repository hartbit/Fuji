//
//  FUTestAction.m
//  Fuji
//
//  Created by David Hart on 5/23/12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
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
