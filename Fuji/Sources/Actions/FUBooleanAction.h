//
//  FUBooleanAction.h
//  Fuji
//
//  Created by Hart David on 14.05.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "FUFiniteAction.h"

@interface FUBooleanAction : FUFiniteAction

- (id)initWithObject:(id)object key:(NSString*)key;
- (id)initWithObject:(id)object key:(NSString*)key value:(BOOL)value;

@end


#define FUToggle(object, property) [[FUBooleanAction alloc] initWithObject:(object) key:(property)]
#define FUSwitchOn(object, property) [[FUBooleanAction alloc] initWithObject:(object) key:(property) value:YES]
#define FUSwitchOff(object, property) [[FUBooleanAction alloc] initWithObject:(object) key:(property) value:NO]

#define FUToggleEnabled(object) FUToggle(object, @"enabled")
#define FUEnable(object) FUSwitchOn(object, @"enabled")
#define FUDisable(object) FUSwitchOff(object, @"enabled")