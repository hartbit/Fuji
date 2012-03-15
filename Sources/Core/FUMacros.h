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

