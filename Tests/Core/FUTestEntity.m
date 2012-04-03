//
//  FUTestEntity.m
//  Fuji
//
//  Created by Hart David on 03.04.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "FUTestEntity.h"


@implementation FUTestEntity

#pragma mark - FUScene Methods

- (id)addComponentWithClass:(Class)componentClass
{
	FUComponent* mockComponent = mock(componentClass);
	[[self performSelector:@selector(components)] addObject:mockComponent];
	return mockComponent;
}

@end
