//
//  FUGroupAction.m
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUGroupAction.h"
#import "FUSupport.h"


static NSString* const FUArrayNilMessage = @"Expected array to not be nil";
static NSString* const FUFiniteActionSubclassMessage = @"Expected 'action=%@' to be a subclass of FUFiniteAction";


@interface FUGroupAction ()

@property (nonatomic, strong) NSArray* actions;

@end


@implementation FUGroupAction

@synthesize actions = _actions;

#pragma mark - Initialization

- (id)initWithActions:(NSArray*)actions
{
	FUCheck(actions != nil, FUArrayNilMessage);
	
	NSTimeInterval duration = 0.0f;
	
	for (FUFiniteAction* action in actions) {
		FUCheck([action isKindOfClass:[FUFiniteAction class]], FUFiniteActionSubclassMessage, action);
		duration += [action duration];
	}
	
	if ((self = [super initWithDuration:duration])) {
		[self setActions:[actions copy]];
	}
	
	return self;
}

@end
