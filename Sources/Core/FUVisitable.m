//
//  FUVisitable.m
//  Fuji
//
//  Created by David Hart on 3/27/12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "FUVisitable.h"


@implementation FUVisitable

#pragma mark - Class Methods

+ (SEL)visitSelector
{
	static SEL sVisitSelector = NULL;
	
	if (sVisitSelector == NULL)
	{
		NSString* selector = [NSString stringWithFormat:@"visit%@:", NSStringFromClass(self)];
		sVisitSelector = NSSelectorFromString(selector);
	}
	
	return sVisitSelector;
}

#pragma mark - Public Methods

- (void)acceptVisitor:(id)visitor
{
	Class currentAncestor = [self class];
	
	while ([currentAncestor isSubclassOfClass:[FUVisitable class]])
	{
		SEL visitSelector = [currentAncestor visitSelector];
		
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
