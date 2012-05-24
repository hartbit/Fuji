//
//  FUSequenceAction.h
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import <Foundation/Foundation.h>
#import "FUAction.h"


@interface FUSequenceAction : NSObject<FUAction>

@property (nonatomic, copy, readonly) NSArray* actions;

- (id)initWithActions:(NSArray*)actions;

@end


#define FUSequence(actions...) ({ \
	id __objects[] = { actions }; \
	NSUInteger __count = sizeof(__objects) / sizeof(id); \
	NSArray* __array = [[NSArray alloc] initWithObjects:__objects count:__count]; \
	[[FUSequenceAction alloc] initWithActions:__array]; \
})
