//
//  FUSceneObject.m
//  Fuji
//
//  Created by David Hart on 3/27/12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "FUSceneObject.h"


@interface FUSceneObject ()

- (void)acceptVisitor:(id)visitor withSelectorPrefix:(NSString*)prefix;

@end


@implementation FUSceneObject

#pragma mark - Public Methods

- (void)updateVisitor:(id)visitor
{
	[self acceptVisitor:visitor withSelectorPrefix:@"update"];
}

- (void)drawVisitor:(id)visitor
{
	[self acceptVisitor:visitor withSelectorPrefix:@"draw"];
}

#pragma mark - Private Methods

- (void)acceptVisitor:(id)visitor withSelectorPrefix:(NSString*)prefix
{
	Class currentAncestor = [self class];
	
	while ([currentAncestor isSubclassOfClass:[FUSceneObject class]])
	{
		NSString* selectorString = [NSString stringWithFormat:@"%@%@:", prefix, NSStringFromClass(currentAncestor)];
		SEL visitSelector = NSSelectorFromString(selectorString);
		
		if ([visitor respondsToSelector:visitSelector])
		{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
			[visitor performSelector:visitSelector withObject:self];
#pragma clang diagnostic pop
			break;
		}
		
		currentAncestor = [currentAncestor superclass];
	}
}

@end
