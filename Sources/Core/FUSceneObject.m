//
//  FUSceneObject.m
//  Fuji
//
//  Created by Hart David on 11.04.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "FUSceneObject.h"
#import "FUSceneObject-Internal.h"
#import "FUEngine.h"


@implementation FUSceneObject

#pragma mark - Public Methods

- (void)registerWithEngine:(FUEngine*)engine
{
	[self makeEngine:engine performSelectorWithPrefix:@"register"];
}

- (void)unregisterFromEngine:(FUEngine*)engine
{
	[self makeEngine:engine performSelectorWithPrefix:@"unregister"];
}

#pragma mark - Private Methods

- (void)makeEngine:(FUEngine*)engine performSelectorWithPrefix:(NSString*)prefix
{
	Class currentAncestor = [self class];
	
	while ([currentAncestor isSubclassOfClass:[FUSceneObject class]])
	{
		NSString* selectorString = [NSString stringWithFormat:@"%@%@:", prefix, NSStringFromClass(currentAncestor)];
		SEL selector = NSSelectorFromString(selectorString);
		
		if ([engine respondsToSelector:selector])
		{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
			[engine performSelector:selector withObject:self];
#pragma clang diagnostic pop
			break;
		}
		
		currentAncestor = [currentAncestor superclass];
	}
}

#pragma mark - UIInterfaceRotation Methods

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
}

@end