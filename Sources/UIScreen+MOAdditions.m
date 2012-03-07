//
//  UIScreen+MOAdditions.m
//  MOAdditions
//
//  Created by Hart David on 20.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <UIKit/UIKit.h>


@implementation UIScreen (MOAdditions)

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
