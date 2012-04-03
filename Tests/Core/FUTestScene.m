//
//  FUTestScene.m
//  Fuji
//
//  Created by Hart David on 03.04.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#include "Prefix.pch"
#import "FUTestScene.h"
#import "FUScene-Internal.h"


@implementation FUTestScene

#pragma mark - FUScene Methods

- (FUEntity*)createEntity
{
	FUEntity* mockEntity = mock([FUEntity class]);
	[[self performSelector:@selector(entities)] addObject:mockEntity];
	return mockEntity;
}

@end
