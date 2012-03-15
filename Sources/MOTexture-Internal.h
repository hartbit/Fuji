//
//  FUTexture-Internal.h
//  Fuji
//
//  Created by Hart David on 26.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//


@interface FUTexture ()

+ (void)textureWithName:(NSString*)name completion:(void (^)(FUTexture* texture))completion;
- (id)initWithName:(NSString*)name;

@end