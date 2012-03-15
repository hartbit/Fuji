//
//  FUTestComponent.m
//  Fuji
//
//  Created by Hart David on 15.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "FUTestComponent.h"
#import "FUComponent-Internal.h"
#import "FUGameObject.h"


static FUTestComponent* sReturnedComponent = nil;


@interface FUTestComponent ()

@property (nonatomic) NSUInteger initCallCount;
@property (nonatomic) NSUInteger awakeCallCount;

@end


@implementation FUTestComponent

@synthesize initCallCount = _initCallCount;
@synthesize awakeCallCount = _awakeCallCount;

#pragma mark - Class Methods

+ (id)testComponent
{
	return [super alloc];
}

+ (void)setAllocReturnValue:(FUTestComponent*)component
{
	sReturnedComponent = component;
}

+ (id)alloc
{
	return sReturnedComponent;
}

#pragma mark - Properties

- (BOOL)wasInitCalled
{
	return [self initCallCount] == 1;
}

- (BOOL)wasAwakeCalled
{
	return [self awakeCallCount] == 1;
}

#pragma mark - Initialization

- (id)initWithGameObject:(FUGameObject*)gameObject
{
	if ((self = [super initWithGameObject:gameObject]))
	{
		[self setInitCallCount:[self initCallCount] + 1];
	}
	
	return self;
}

- (void)awake
{
	[self setAwakeCallCount:[self awakeCallCount] + 1];
}

@end


@implementation FUUniqueTestComponent

+ (BOOL)isUnique
{
	return YES;
}

@end
