//
//  MOGameObjectSpec.m
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
#import "OCMockito.h"
#import "Mocha2D.h"
#import	"MOComponent-Internal.h"


SPEC_BEGIN(MOGameObjectSpec)

describe(@"MOGameObject", ^{
	__block MOGameObject* gameObject = nil;
	
	beforeEach(^{
		gameObject = [[MOScene new] addGameObject];
	});
	
	it(@"should raise when initialized directly", ^{
		STAssertThrows([MOGameObject new], nil);
	});
	
	context(@"addComponentWithClass:", ^{
		it(@"should raise when given a NULL class", ^{
			STAssertThrows([gameObject addComponentWithClass:NULL], nil);
		});
		
		it(@"should raise when given a class that does not subclass MOComponent", ^{
			STAssertThrows([gameObject addComponentWithClass:[NSString class]], nil);
		});
		   
		it(@"should raise when given the MOComponent class", ^{
			STAssertThrows([gameObject addComponentWithClass:[MOComponent class]], nil);
		});
		
		it(@"should return an instance of the class if the class is a subclass of MOComponent", ^{
			expect([MOTransform class]).to.beASubclassOf([MOComponent class]);
			MOComponent* component = [gameObject addComponentWithClass:[MOTransform class]];
			expect(component).to.beAnInstanceOf([MOTransform class]);
		});
		
		it(@"should initialize the newly created component", ^{
			Class transformClassMock = mockClass([MOTransform class]);
			id transformMock = mock([MOTransform class]);
			
			[given([transformClassMock isSubclassOfClass:[MOComponent class]]) willReturnBool:YES];
			[given([transformClassMock alloc]) willReturn:transformMock];
			[given([transformMock initWithGameObject:gameObject]) willReturn:transformMock];
			
			MOComponent* component = [gameObject addComponentWithClass:transformClassMock];
			expect(component).to.beIdenticalTo((__bridge void*)transformMock);
			
			id __attribute__((unused)) c = [verify(transformMock) initWithGameObject:gameObject];
			[verify(transformMock) awake];
		});
	});
});

SPEC_END
