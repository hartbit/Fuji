//
//  FUTweenAction.h
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUTimedAction.h"


typedef void (^FUTweenBlock)(float t);


@interface FUTweenAction : FUTimedAction

- (id)initWithDuration:(NSTimeInterval)duration block:(FUTweenBlock)block;

@end


FUTweenAction* FUTween(NSTimeInterval duration, FUTweenBlock block);
FUTweenAction* FUTweenTo(NSTimeInterval duration, id target, NSString* property, NSNumber* value);
FUTweenAction* FUTweenSum(NSTimeInterval duration, id target, NSString* property, NSNumber* addend);
FUTweenAction* FUTweenProduct(NSTimeInterval duration, id target, NSString* property, NSNumber* factor);
FUTweenAction* FURotateTo(NSTimeInterval duration, id target, float rotation);
FUTweenAction* FURotateBy(NSTimeInterval duration, id target, float addend);
