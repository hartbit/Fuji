//
//  FUBooleanAction.h
//  Fuji
//
//  Created by Hart David on 14.05.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "FUFiniteAction.h"

@interface FUBooleanAction : FUFiniteAction

- (id)initWithObject:(id)object property:(NSString*)property;
- (id)initWithObject:(id)object property:(NSString*)property value:(BOOL)value;

@end


#define FUToggle(object, prop) [[FUBooleanAction alloc] initWithObject:(object) property:(prop)]
#define FUSwitchOn(object, prop) [[FUBooleanAction alloc] initWithObject:(object) property:(prop) value:YES]
#define FUSwitchOff(object, prop) [[FUBooleanAction alloc] initWithObject:(object) property:(prop) value:NO]

#define FUToggleEnabled(object) FUToggle(object, @"enabled")
#define FUEnable(object) FUSwitchOn(object, @"enabled")
#define FUDisable(object) FUSwitchOff(object, @"enabled")