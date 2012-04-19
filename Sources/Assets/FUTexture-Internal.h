//
//  FUTexture-Internal.h
//  Fuji
//
//  Created by Hart David on 26.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FUTexture ()

+ (void)textureWithName:(NSString*)name completionHandler:(void (^)(FUTexture* texture))block;
- (id)initWithName:(NSString*)name;

@end