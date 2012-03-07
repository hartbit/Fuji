//
//  MOMacros.h
//  Mocha2D
//
//  Created by Hart David on 24.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "DDLog.h"
#import <GLKit/GLKit.h>


#ifdef DEBUG
static const int ddLogLevel = LOG_LEVEL_VERBOSE;
#else
static const int ddLogLevel = LOG_LEVEL_WARN;
#endif


#if !defined(NS_BLOCK_ASSERTIONS)

#define MOFail(format, ...) \
	[[NSAssertionHandler currentHandler] handleFailureInMethod:_cmd object:self file:[NSString stringWithUTF8String:__FILE__] lineNumber:__LINE__ description:(format), ##__VA_ARGS__]
#define MOCFail(format, ...) \
	[[NSAssertionHandler currentHandler] handleFailureInFunction:[NSString stringWithUTF8String:__PRETTY_FUNCTION__] file:[NSString stringWithUTF8String:__FILE__] lineNumber:__LINE__ description:(format), ##__VA_ARGS__]

#else

#define MOFail(format, ...) do {} while (0)
#define MOCFail(format, ...) do {} while (0)

#endif

#define _MOAssert(logMacro, failMacro, condition, conditionString, format, ...) do { \
	if (!(condition)) { \
		NSString* description = nil; \
		if (format == nil) { \
			description = [NSString stringWithFormat:@"Assertion failed: '%@'", conditionString]; \
		} else { \
			description = [NSString stringWithFormat:@"Assertion failed: '%@' (%@)", conditionString, (format)]; \
		} \
		DD##logMacro(description, ##__VA_ARGS__); \
		MO##failMacro(description, ##__VA_ARGS__); \
	} \
} while(0)

#define MOAssertError(condition, format, ...) _MOAssert(LogError, Fail, condition, @#condition, format, ##__VA_ARGS__)
#define MOAssertWarn(condition, format, ...) _MOAssert(LogWarn, Fail, condition, @#condition, format, ##__VA_ARGS__)
#define MOCAssertError(condition, format, ...) _MOAssert(CLogError, CFail, condition, @#condition, format, ##__VA_ARGS__)
#define MOCAssertWarn(condition, format, ...) _MOAssert(CLogWarn, CFail, condition, @#condition, format, ##__VA_ARGS__)


#define MOStringIsValid(string) ((string) != nil) && ([string length] != 0)
#define MOIsInInterval(value, min, max) ((value) >= (min)) && ((value) <= (max))


// From http://lukeredpath.co.uk/blog/a-note-on-objective-c-singletons.html
#define MO_SINGLETON_WITH_BLOCK(block) do { \
	static dispatch_once_t predicate = 0; \
	__strong static id _sSharedInstance = nil; \
	dispatch_once(&predicate, ^{ \
		_sSharedInstance = block(); \
	}); \
	return _sSharedInstance; \
} while(0)
