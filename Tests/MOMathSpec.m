//
//  MOSceneSpec.m
//  Mocha2D
//
//  Created by Hart David on 24.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#define SPT_CEDAR_SYNTAX
#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"
#import "Mocha2D.h"


SPEC_BEGIN(MOMathSpec)

describe(@"MOMath", ^{
	context(@"MOClamp", ^{
		it(@"should return the min if the value is less than min", ^{
			expect(MOClamp(-2, 3, 4)).to.equal(3);
			expect(MOClamp(-4, -2, 4)).to.equal(-2);
			expect(MOClamp(2.3, 3.5, 4)).to.equal(3.5);
		});
		
		it(@"should return the max if the value is greater than max", ^{
			expect(MOClamp(-2, -4, -3)).to.equal(-3);
			expect(MOClamp(4, -4, -3)).to.equal(-3);
			expect(MOClamp(5.6, 0, 2.4)).to.equal(2.4);
		});
		
		it(@"should return the value if it is in range", ^{
			expect(MOClamp(1, -2, 2)).to.equal(1);
			expect(MOClamp(-1, -2, 2)).to.equal(-1);
			expect(MOClamp(5.5, 3.4, 6.4)).to.equal(5.5);
		});
		
		it(@"should raise if min is greater than max", ^{
			STAssertThrows(MOClamp(4, 5, -2), nil);
		});
	});
});

SPEC_END
