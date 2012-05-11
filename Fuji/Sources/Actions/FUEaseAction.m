//
//  FUEaseAction.m
//  Fuji
//
//  Created by David Hart
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUEaseAction.h"
#import "FUSupport.h"


static NSString* const FUActionNilMessage = @"Expected 'action' to not be nil";
static NSString* const FUFunctionNullMessage = @"Expected 'function' to not be NULL";


@implementation FUEaseAction

#pragma mark - Initialization

- (id)initWithAction:(id<FUAction>)action function:(FUTimingFunction)function
{
	FUCheck(action != nil, FUActionNilMessage);
	FUCheck(function != NULL, FUFunctionNullMessage);
	
	if ((self = [super init]))
	{
	}
	
	return self;
}

@end
