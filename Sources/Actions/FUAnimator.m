//
//  FUAnimator.m
//  Fuji
//
//  Created by David Hart
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUAnimator.h"


@interface FUAnimator ()

@property (nonatomic, strong) NSMutableArray* actions;

@end


@implementation FUAnimator

@synthesize actions = _actions;

#pragma mark - Properties

- (BOOL)isComplete
{
	return NO;
}

- (NSMutableArray*)actions
{
	if (_actions == nil)
	{
		[self setActions:[NSMutableArray array]];
	}
	
	return _actions;
}

#pragma mark - Public Methods

- (void)playAction:(id<FUAction>)action
{
	[[self actions] addObject:action];
}

- (void)advanceTime:(NSTimeInterval)deltaTime
{
	__block NSMutableIndexSet* completeIndices;
	
	[[self actions] enumerateObjectsUsingBlock:^(id<FUAction> action, NSUInteger index, BOOL* stop) {
		if ([action isComplete])
		{
			if (completeIndices == nil)
			{
				completeIndices = [NSMutableIndexSet indexSet];
			}
			
			[completeIndices addIndex:index];
		}
		else
		{
			[action advanceTime:deltaTime];
		}
	}];
	
	if (completeIndices != nil)
	{
		[[self actions] removeObjectsAtIndexes:completeIndices];
	}
}

@end
