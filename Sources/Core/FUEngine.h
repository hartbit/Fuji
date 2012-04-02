//
//  FUEngine.h
//  Fuji
//
//  Created by Hart David on 30.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FUMacros.h"
#import "FUInterfaceRotation.h"


@class FUDirector;

@interface FUEngine : NSObject <FUInterfaceRotation>

@property (nonatomic, WEAK, readonly) FUDirector* director;

@end
