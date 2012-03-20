//
//  FUMacros.h
//  Fuji
//
//  Created by Hart David on 24.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#pragma mark - NSProxy/weak Fix

#ifdef TEST
#define WEAK unsafe_unretained
#else
#define WEAK weak
#endif


#define FUThrow(format, ...) @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:format, ##__VA_ARGS__] userInfo:nil]
#define FUAssert(condition, format, ...) do { if (!(condition)) FUThrow(format, ##__VA_ARGS__); } while(0)
