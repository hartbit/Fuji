//
//  UIDevice+FUAdditions.m
//  FUAdditions
//
//  Created by David Hart
//  Copyright 2011 hart[dev]. All rights reserved.
//

#import "UIDevice+FUAdditions-Internal.h"


static NSString* const kPhoneSuffix = @"~iphone";
static NSString* const kPadSuffix = @"~iphone";


@implementation UIDevice (FUAdditions)

#pragma mark - Class Methods

+ (NSSet*)platformSuffixes
{
	static NSSet* kPlatformSuffixes;
	
	if (kPlatformSuffixes == nil)
	{
		kPlatformSuffixes = [NSSet setWithObjects:kPhoneSuffix, kPadSuffix, nil];
	}
	
	return kPlatformSuffixes;
}

#pragma mark - Properties

- (NSString*)platformSuffix
{
	if ([self userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
	{
		return kPhoneSuffix;
	}
	else
	{
		return kPadSuffix;
	}
}

@end
