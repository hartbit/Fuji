//
//  FUTestComponent.m
//  Fuji
//
//  Created by Hart David on 15.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "FUTestComponents.h"
#import "Fuji.h"
#import "FUComponent-Internal.h"
#import "FUEntity.h"


@interface FUTestComponent ()

@property (nonatomic) NSUInteger initCallCount;
@property (nonatomic) NSUInteger willRotateCallCount;
@property (nonatomic) NSUInteger willAnimateRotationCallCount;
@property (nonatomic) NSUInteger didRotateCallCount;

@end


@implementation FUTestComponent

@synthesize initCallCount = _initCallCount;
@synthesize willRotateCallCount = _willRotateCallCount;
@synthesize willAnimateRotationCallCount = _willAnimateRotationCallCount;
@synthesize didRotateCallCount = _didRotateCallCount;

#pragma mark - Properties

- (BOOL)wasInitCalled
{
	return [self initCallCount] == 1;
}

- (BOOL)wasWillRotateCalled
{
	return [self willRotateCallCount] == 1;
}

- (BOOL)wasWillAnimateRotationCalled
{
	return [self willAnimateRotationCallCount] == 1;
}

- (BOOL)wasDidRotateCalled
{
	return [self didRotateCallCount] == 1;
}

#pragma mark - Initialization

- (id)init
{
	if ((self = [super init]))
	{
		[self setInitCallCount:[self initCallCount] + 1];
	}
	
	return self;
}

#pragma mark - FUInterfaceRotation Methods

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	[self setWillRotateCallCount:[self willRotateCallCount] + 1];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
	[self setWillAnimateRotationCallCount:[self willAnimateRotationCallCount] + 1];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
	[self setDidRotateCallCount:[self didRotateCallCount] + 1];
}

@end


@implementation FUUniqueParentComponent

+ (BOOL)isUnique
{
	return YES;
}

@end


@implementation FUUniqueChild1Component

@end


@implementation FUUniqueChild2Component

@end


@implementation FUCommonChildComponent

+ (BOOL)isUnique
{
	return NO;
}

@end


@implementation FUUniqueGrandChildComponent

+ (BOOL)isUnique
{
	return YES;
}

@end


@implementation FURequireObjectComponent

+ (NSSet*)requiredComponents
{
	return [NSSet setWithObject:[NSString string]];
}

@end


@implementation FURequireInvalidSuperclassComponent

+ (NSSet*)requiredComponents
{
	return [NSSet setWithObject:[FURequiredComponent class]];
}

@end


@implementation FURequireNSStringComponent

+ (NSSet*)requiredComponents
{
	return [NSSet setWithObject:[NSString class]];
}

@end


@implementation FURequireBaseComponent

+ (NSSet*)requiredComponents
{
	return [NSSet setWithObject:[FUComponent class]];
}

@end


@implementation FURequireItselfComponent

+ (NSSet*)requiredComponents
{
	return [NSSet setWithObject:self];
}

@end


@implementation FURequireSubclassComponent

+ (NSSet*)requiredComponents
{
	return [NSSet setWithObject:[FUTestComponent class]];
}

@end


@implementation FURequireRelativesComponent

+ (NSSet*)requiredComponents
{
	return [NSSet setWithObjects:[FUUniqueParentComponent class], [FUUniqueChild1Component class], nil];
}

@end


@implementation FUCommonParentComponent

@end


@implementation FURequireUniqueParentComponent

+ (NSSet*)requiredComponents
{
	return [NSSet setWithObject:[FUUniqueParentComponent class]];
}

@end


@implementation FURequireRequiredComponent

+ (NSSet*)requiredComponents
{
	return [NSSet setWithObject:[FURequiredComponent class]];
}

@end


@implementation FURequiredComponent

@end
