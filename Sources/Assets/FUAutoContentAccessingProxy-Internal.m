//
//  FUAutoContentAccessingProxy-Internal.m
//  Fuji
//
//  Created by David Hart on 4/20/12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//  From: http://stackoverflow.com/a/9182946
//

#import "FUAutoContentAccessingProxy-Internal.h"
#import <objc/runtime.h>


@implementation FUAutoContentAccessingProxy

@synthesize target = _target;

static id autoContentAccessingProxy(id self, SEL _cmd)
{
	return [FUAutoContentAccessingProxy proxyWithTarget:self];
}

+ (void) load
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

- (void)dealloc
{
	[[self target] endContentAccess];
}

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