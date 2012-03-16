//
//  FUTestComponents.h
//  Fuji
//
//  Created by Hart David on 15.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "FUComponent.h"


@interface FUTestComponent : FUComponent

@property (nonatomic, readonly) BOOL wasInitCalled;
@property (nonatomic, readonly) BOOL wasAwakeCalled;

+ (id)testComponent;
+ (void)setAllocReturnValue:(FUTestComponent*)component;

@end


@interface FUCommonComponent : FUTestComponent @end
@interface FURequireObjectComponent : FUComponent @end
@interface FURequireNSStringComponent : FUComponent @end
@interface FURequireBaseComponent : FUComponent @end