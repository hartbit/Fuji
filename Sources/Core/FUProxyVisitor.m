//
//  FUProxyVisitor.m
//  Fuji
//
//  Created by David Hart
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
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