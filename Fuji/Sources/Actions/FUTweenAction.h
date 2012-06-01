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
FUTweenAction* FUTweenTo(NSTimeInterval duration, id object, NSString* key, NSNumber* value);
FUTweenAction* FUTweenSum(NSTimeInterval duration, id object, NSString* key, NSNumber* addend);
FUTweenAction* FUTweenProduct(NSTimeInterval duration, id object, NSString* key, NSNumber* factor);
FUTweenAction* FUMoveTo(NSTimeInterval duration, id object, GLKVector2 position);
FUTweenAction* FUMoveBy(NSTimeInterval duration, id object, GLKVector2 translation);
FUTweenAction* FURotateTo(NSTimeInterval duration, id object, float rotation);
FUTweenAction* FURotateBy(NSTimeInterval duration, id object, float addend);
//FUTweenAction* FUScaleTo(NSTimeInterval duration, id object, GLKVector2 scale);
//FUTweenAction* FUScaleBy(NSTimeInterval duration, id object, GLKVector2 factor);
//FUTweenAction* FUTintTo(NSTimeInterval duration, id object, GLKVector4 tint);
//FUTweenAction* FUTintBy(NSTimeInterval duration, id object, GLKVector4 color);
