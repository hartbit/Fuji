//
//  FUSequenceAction.m
//  Fuji
//
//  Created by David Hart
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUSequenceAction.h"
#import "FUSupport.h"


static NSString* const FUArrayNilMessage = @"Expected array to not be nil";


@interface FUSequenceAction ()

@end


@implementation FUSequenceAction

#pragma mark - Initialization

+ (FUSequenceAction*)actionWithArray:(NSArray*)array
{
	return [[self alloc] initWithArray:array];
}

- (id)initWithArray:(NSArray*)array
{
	FUCheck(array != nil, FUArrayNilMessage);

	if ((self = [super init]))
	{
	}
	
	return self;
}

@end
