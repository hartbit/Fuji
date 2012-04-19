//
//  UIScreen+FUAdditions-Internal.m
//  FUAdditions
//
//  Created by Hart David on 20.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "UIScreen+FUAdditions-Internal.h"


@implementation UIScreen (FUAdditions)

- (NSString*)scaleSuffix
{
	if ([self scale] != 1)
	{
		return [NSString stringWithFormat:@"@%ix", (NSUInteger)[self scale]];
	}
	else
	{
		return @"";
	}
}

@end
