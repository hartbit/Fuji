//
//  FUCallAction.h
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUTimedAction.h"


typedef void (^FUCallBlock)();


@interface FUCallAction : FUTimedAction

- (id)initWithBlock:(FUCallBlock)block;

@end


FUCallAction* FUCall(FUCallBlock block);
FUCallAction* FUToggle(id target, NSString* property);
FUCallAction* FUSwitchOn(id target, NSString* property);
FUCallAction* FUSwitchOff(id target, NSString* property);
FUCallAction* FUToggleEnabled(id target);
FUCallAction* FUEnable(id target);
FUCallAction* FUDisable(id target);
