//
//  FUTestComponents.h
//  Fuji
//
//  Created by Hart David on 15.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "FUComponent.h"
#import "Fuji.h"


@interface FUTestComponent : FUComponent

@property (nonatomic, readonly) BOOL wasInitCalled;
@property (nonatomic, readonly) BOOL wasAwakeCalled;

@end


@interface FUUniqueParentComponent : FUTestComponent @end
@interface FUUniqueChild1Component : FUUniqueParentComponent @end
@interface FUUniqueChild2Component : FUUniqueParentComponent @end
@interface FUCommonChildComponent : FUUniqueParentComponent @end
@interface FUUniqueGrandChildComponent : FUCommonChildComponent @end


@interface FURequireObjectComponent : FUTestComponent @end
@interface FURequireInvalidSuperclassComponent : FURequireObjectComponent @end
@interface FURequireNSStringComponent : FUTestComponent @end
@interface FURequireBaseComponent : FUTestComponent @end
@interface FURequireItselfComponent : FUTestComponent @end
@interface FURequireSubclassComponent : FUTestComponent @end
@interface FURequireRelativesComponent : FUTestComponent @end

@interface FUCommonParentComponent : FUTestComponent @end
@interface FURequireUniqueParentComponent : FUCommonParentComponent @end
@interface FURequireRequiredComponent : FURequireUniqueParentComponent @end
@interface FURequiredComponent : FUCommonParentComponent @end