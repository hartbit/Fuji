//
//  FUSceneSpec.m
//  Fuji
//
//  Created by Hart David on 24.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#define SPT_CEDAR_SYNTAX
#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"
#import "Fuji.h"


SPEC_BEGIN(FUMathSpec)

describe(@"FUMath", ^{
	context(@"FUClamp", ^{
		it(@"should return the min if the value is less than min", ^{
			expect(FUClamp(-2, 3, 4)).to.equal(3);
			expect(FUClamp(-4, -2, 4)).to.equal(-2);
			expect(FUClamp(2.3, 3.5, 4)).to.equal(3.5);
		});
		
		it(@"should return the max if the value is greater than max", ^{
			expect(FUClamp(-2, -4, -3)).to.equal(-3);
			expect(FUClamp(4, -4, -3)).to.equal(-3);
			expect(FUClamp(5.6, 0, 2.4)).to.equal(2.4);
		});
		
		it(@"should return the value if it is in range", ^{
			expect(FUClamp(1, -2, 2)).to.equal(1);
			expect(FUClamp(-1, -2, 2)).to.equal(-1);
			expect(FUClamp(5.5, 3.4, 6.4)).to.equal(5.5);
		});
		
		it(@"should raise if min is greater than max", ^{
			STAssertThrows(FUClamp(4, 5, -2), nil);
		});
	});
});

SPEC_END
