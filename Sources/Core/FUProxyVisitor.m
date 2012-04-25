//
//  FUProxyVisitor.m
//  Fuji
//
//  Created by Hart David on 18.04.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "FUProxyVisitor-Internal.h"
#import "FUVisitor-Internal.h"


@interface FUProxyVisitor ()

@property (nonatomic, strong) NSMutableSet* visitors;

@end


@implementation FUProxyVisitor

@synthesize visitors = _visitors;

#pragma mark - Properties

- (NSMutableSet*)visitors
{
	if (_visitors == nil)
	{
		[self setVisitors:[NSMutableSet set]];
	}
	
	return _visitors;
}

#pragma mark - FUVisitor Methods

- (void)visitSceneObject:(FUSceneObject*)sceneObject
{
	for (FUVisitor* visitor in [self visitors])
	{
		[visitor visitSceneObject:sceneObject];
	}
}

@end