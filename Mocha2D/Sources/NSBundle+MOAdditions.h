//
//  NSBundle+MOAdditions.h
//  Mocha2D
//
//  Created by Hart David on 24.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSBundle (MOAdditions)

+ (NSBundle*)currentBundle;

- (NSString*)platformPathForResource:(NSString*)name ofType:(NSString*)extension;

@end
