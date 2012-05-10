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
#import "FUSupport.h"


static NSString* const FUActionNilMessage = @"Expected 'action' to not be nil";


@interface FUAnimator ()

@property (nonatomic, strong) NSMutableArray* actions;

@end


@implementation FUAnimator

@synthesize actions = _actions;

#pragma mark - Initialization

- (id)copyWithZone:(NSZone*)zone
{
	id copy;
	
	if ((copy = [[self class] new]))
	{
		NSMutableArray* actions = [[NSMutableArray alloc] initWithArray:[self actions] copyItems:YES];
		[copy setActions:actions];
	}
	
	return copy;
}

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

- (void)runAction:(id<FUAction>)action
{
	FUCheck(action != nil, FUActionNilMessage);
	
	if ([action isComplete])
	{
		return;
	}
	
	[[self actions] addObject:action];
	[action updateWithDeltaTime:0];
}

#pragma mark - FUAction Methods

- (void)updateWithDeltaTime:(NSTimeInterval)deltaTime
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
			[action updateWithDeltaTime:deltaTime];
		}
	}];
	
	if (completeIndices != nil)
	{
		[[self actions] removeObjectsAtIndexes:completeIndices];
	}
}

@end