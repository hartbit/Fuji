//
//  NSBundle+FUAdditions.m
//  Fuji
//
//  Created by Hart David on 24.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSBundle+FUAdditions-Internal.h"
#import "UIDevice+FUAdditions-Internal.h"
#import "UIScreen+FUAdditions-Internal.h"
#import "FUDirector.h"
#import "FUSupport.h"


@implementation NSBundle (FUAdditions)

+ (NSBundle*)currentBundle
{
	static NSBundle* sCurrentBundle = nil;
	
	if (sCurrentBundle == nil)
	{
		sCurrentBundle = [NSBundle bundleForClass:[FUDirector class]];
	}
	
	return sCurrentBundle;
}

- (NSString*)platformPathForResource:(NSString*)name ofType:(NSString*)extension
{
	NSString* platformSuffix = [[UIDevice currentDevice] platformSuffix];
	NSString* scaleSuffix = [[UIScreen mainScreen] scaleSuffix];
	BOOL hasScaleSuffix = [scaleSuffix length] != 0;
	
	NSString* nameWithSuffix = nil;
	NSString* path = nil;
	
	if (hasScaleSuffix)
	{
		nameWithSuffix = [NSString stringWithFormat:@"%@%@%@", name, scaleSuffix, platformSuffix];
		path = [self pathForResource:nameWithSuffix ofType:extension];
		if (path != nil) return path;
	}
	
	nameWithSuffix = [NSString stringWithFormat:@"%@%@", name, platformSuffix];
	path = [self pathForResource:nameWithSuffix ofType:extension];
	if (path != nil) return path;
	
	if (hasScaleSuffix)
	{
		nameWithSuffix = [NSString stringWithFormat:@"%@%@", name, scaleSuffix];
		path = [self pathForResource:nameWithSuffix ofType:extension];
		if (path != nil) return path;
	}
	
	return [self pathForResource:name ofType:extension];
}

@end
