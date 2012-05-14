//
//  FUBooleanAction.m
//  Fuji
//
//  Created by Hart David on 14.05.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "FUBooleanAction.h"


static NSString* const FUObjectNilMessage = @"Expect 'object' to not be nil";


@implementation FUBooleanAction

#pragma mark - Initialization

- (id)initWithObject:(id)object property:(NSString*)property value:(BOOL)value
{
	FUCheck(object != nil, FUObjectNilMessage);
	
	if ((self = [super initWithDuration:0.0f])) {
	}
	
	return self;
}

@end
