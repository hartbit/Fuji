//
//  FUDelayAction.m
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUDelayAction.h"
#import "FUSupport.h"


static NSString* const FUDelayNegativeMessage = @"Expected 'delay=%g' to be positive";


@implementation FUDelayAction

#pragma mark - Initialization

- (id)initWithDelay:(NSTimeInterval)delay
{
	FUCheck(delay >= 0, FUDelayNegativeMessage, delay);
	
	if ((self = [super initWithDuration:delay])) {
	}
	
	return self;
}

@end
