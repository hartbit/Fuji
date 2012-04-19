//
//  UIDevice+FUAdditions-Internal.m
//  FUAdditions
//
//  Created by David Hart on 23/02/2011.
//  Copyright 2011 hart[dev]. All rights reserved.
//

#import "UIDevice+FUAdditions-Internal.h"


static NSString* const kPhoneSuffix = @"~iphone";
static NSString* const kPadSuffix = @"~iphone";


@implementation UIDevice (FUAdditions)

#pragma mark - Class Methods

+ (NSSet*)platformSuffixes
{
	static NSSet* kPlatformSuffixes = nil;
	
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
