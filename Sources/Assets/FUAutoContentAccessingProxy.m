//
//  FUAutoContentAccessingProxy.m
//  Fuji
//
//  Created by David Hart
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//
//  From: http://stackoverflow.com/a/9182946
//

#import <objc/runtime.h>
#import "FUAutoContentAccessingProxy-Internal.h"


@implementation FUAutoContentAccessingProxy

@synthesize target = _target;

static id autoContentAccessingProxy(id self, SEL _cmd)
{
	return [FUAutoContentAccessingProxy proxyWithTarget:self];
}

#pragma mark - Class Methods

+ (void)load
{
	method_setImplementation(class_getInstanceMethod([NSObject class], @selector(autoContentAccessingProxy)), (IMP)autoContentAccessingProxy);
}

+ (FUAutoContentAccessingProxy*)proxyWithTarget:(id)target
{
	if (![target conformsToProtocol:@protocol(NSDiscardableContent)])
	{
		return nil;
	}
	
	if (![target beginContentAccess])
	{
		return nil;
	}
	
	FUAutoContentAccessingProxy* proxy = [self alloc];
	[proxy setTarget:target];
	return proxy;
}

#pragma mark - Initialization

- (void)dealloc
{
	[[self target] endContentAccess];
}

#pragma mark - NSProxy Methods

- (id)forwardingTargetForSelector:(SEL)selector
{
	return [self target];
}

- (NSMethodSignature*)methodSignatureForSelector:(SEL)selector
{
	return [[self target] methodSignatureForSelector:selector];
}

- (void)forwardInvocation:(NSInvocation*)invocation
{
	[invocation setTarget:[self target]];
	[invocation invoke];
}

@end
