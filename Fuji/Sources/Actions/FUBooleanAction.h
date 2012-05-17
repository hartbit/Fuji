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


#define FUToggle(_object, _key) [[FUBooleanAction alloc] initWithObject:(_object) key:(_key)]
#define FUSwitchOn(_object, _key) [[FUBooleanAction alloc] initWithObject:(_object) key:(_key) value:YES]
#define FUSwitchOff(_object, _key) [[FUBooleanAction alloc] initWithObject:(_object) key:(_key) value:NO]