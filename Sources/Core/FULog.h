//
//  FULog.h
//  Fuji
//
//  Created by Hart David on 15.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "DDLog.h"


#ifdef DEBUG
static const int ddLogLevel = LOG_LEVEL_VERBOSE;
#else
static const int ddLogLevel = LOG_LEVEL_WARN;
#endif

#if !defined(NS_BLOCK_ASSERTIONS)
	#define FUFail(format, ...) [[NSAssertionHandler currentHandler] handleFailureInMethod:_cmd object:self file:[NSString stringWithUTF8String:__FILE__] lineNumber:__LINE__ description:(format), ##__VA_ARGS__]
	#define FUCFail(format, ...) [[NSAssertionHandler currentHandler] handleFailureInFunction:[NSString stringWithUTF8String:__PRETTY_FUNCTION__] file:[NSString stringWithUTF8String:__FILE__] lineNumber:__LINE__ description:(format), ##__VA_ARGS__]
#else
	#define FUFail(format, ...) do {} while (0)
	#define FUCFail(format, ...) do {} while (0)
#endif

#define _FULog(logMacro, failMacro, format, ...) do { \
	DDLog##logMacro(format, ##__VA_ARGS__); \
	FU##failMacro(format, ##__VA_ARGS__); \
} while(0)

#define FULogError(format, ...) _FULog(Error, Fail, format, ##__VA_ARGS__)
#define FULogWarn(format, ...) _FULog(Warn, Fail, format, ##__VA_ARGS__)
#define FUCLogError(format, ...) _FULog(CError, CFail, format, ##__VA_ARGS__)
#define FUCLogWarn(format, ...) _FULog(CWarn, CFail, format, ##__VA_ARGS__)