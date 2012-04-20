//
//  FUAsset-Internal.m
//  Fuji
//
//  Created by David Hart on 4/20/12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "FUAsset-Internal.h"
#import "FUSupport.h"


static NSString* const FUAccessMatchingError = @"Call to 'endContentAccess' on 'asset=%@' did not match a previous call to 'beginContentAccess'";
static NSString* const FUAccessError = @"Accessing 'asset=%@' without a prior call to 'beginContentAccess'";


@interface FUAsset ()

@property (nonatomic) NSInteger accessCount;

@end


@implementation FUAsset

@synthesize accessCount = _accessCount;

#pragma mark - Initialization

- (id)init
{
	self = [super init];
	if (self == nil) return nil;
	
	[self setAccessCount:1];
	return self;
}

#pragma mark - NSDiscardableContent Methods

- (BOOL)beginContentAccess
{
	if ([self isContentDiscarded])
	{
		return NO;
	}
	
	[self setAccessCount:[self accessCount] + 1];
	return YES;
}

- (void)endContentAccess
{
	if ([self accessCount] < 1)
	{
		FUThrow(FUAccessMatchingError, self);
	}

	[self setAccessCount:[self accessCount] - 1];
}

- (void)discardContentIfPossible
{
	if ([self accessCount] == 0)
	{
		[self discardContent];
		[self setAccessCount:-1];
	}
}

- (BOOL)isContentDiscarded
{
	return [self accessCount] == -1;
}

#pragma mark - Internal Methods

- (void)verifyAccessibility
{
	if ([self accessCount] < 1)
	{
		FUThrow(FUAccessError, self);
	}
}

- (void)discardContent
{
	
}

@end
