//
//  FUBooleanAction.h
//  Fuji
//
//  Created by Hart David on 14.05.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "FUFiniteAction.h"

@interface FUBooleanAction : FUFiniteAction

- (id)initWithObject:(id)object property:(NSString*)property value:(BOOL)value;

@end
