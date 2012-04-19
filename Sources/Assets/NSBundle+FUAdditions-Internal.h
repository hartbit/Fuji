//
//  NSBundle+FUAdditions-Internal.h
//  Fuji
//
//  Created by Hart David on 24.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSBundle (FUAdditions)

+ (NSBundle*)currentBundle;

- (NSString*)platformPathForResource:(NSString*)name ofType:(NSString*)extension;

@end
