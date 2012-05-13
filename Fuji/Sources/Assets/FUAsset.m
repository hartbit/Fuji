//
//  FUAsset.m
//  Fuji
//
//  Created by David Hart
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUAsset-Internal.h"
#import "FUSupport.h"


static NSString* const FUAccessMatchingMessage = @"Call to 'endContentAccess' on 'asset=%@' did not match a previous call to 'beginContentAccess'";
static NSString* const FUAccessMessage = @"Accessing 'asset=%@' without a prior call to 'beginContentAccess'";


@interface FUAsset ()

@property (nonatomic) NSInteger accessCount;

@end


@implementation FUAsset

@synthesize accessCount = _accessCount;

#pragma mark - Initialization

- (id)init
{
	if ((self = [super init])) {
		[self setAccessCount:1];
	}
	
	return self;
}

#pragma mark - NSDiscardableContent Methods

- (BOOL)beginContentAccess
{
	if ([self isContentDiscarded]) {
		return NO;
	}
	
	[self setAccessCount:[self accessCount] + 1];
	return YES;
}

- (void)endContentAccess
{
	if ([self accessCount] < 1) {
		FUThrow(FUAccessMatchingMessage, self);
	}

	[self setAccessCount:[self accessCount] - 1];
}

- (void)discardContentIfPossible
{
	if ([self accessCount] == 0) {
		[self discardContent];
		[self setAccessCount:-1];
	}
}

- (BOOL)isContentDiscarded
{
	return [self accessCount] == -1;
}

#pragma mark - Internal Methods

- (NSUInteger)sizeInBytes
{
	return 0;
}

- (void)verifyAccessibility
{
	if ([self accessCount] < 1) {
		FUThrow(FUAccessMessage, self);
	}
}

- (void)discardContent
{
}

@end
