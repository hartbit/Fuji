//
//  FUDirectorVisitor.m
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUDirectorVisitor-Internal.h"
#import "FUVisitor-Internal.h"
#import "FUDirector-Internal.h"
#import "FUComponent-Internal.h"


@interface FUDirectorVisitor ()

@property (nonatomic, strong) NSMutableArray* visitors;

@end


@implementation FUDirectorVisitor

@synthesize visitors = _visitors;

#pragma mark - Properties

- (NSMutableArray*)visitors
{
	if (_visitors == nil) {
		[self setVisitors:[NSMutableArray array]];
	}
	
	return _visitors;
}

#pragma mark - FUVisitor Methods

- (void)visitSceneObject:(FUSceneObject*)sceneObject
{
	
	for (FUVisitor* visitor in [self visitors]) {
		[visitor visitSceneObject:sceneObject];
	}
}

@end