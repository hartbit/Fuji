//
//  MOGameObjectSpec.m
//  Mocha2D
//
//  Created by Hart David on 24.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import	"MOComponent-Internal.h"


SPEC_BEGIN(MOGameObjectSpec)

describe(@"MOGameObject", ^{
	__block MOGameObject* gameObject = nil;
	
	beforeEach(^{
		gameObject = [MOGameObject new];
	});
	
	it(@"should return a valid game object", ^{
		expect(gameObject).toNot.beNil();
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
			id transformClassMock = [OCMockObject mockForClassObject:[MOTransform class]];
			id transformMock = [OCMockObject niceMockForClass:[MOTransform class]];
			
			BOOL yes = YES;
			[[[transformClassMock stub] andReturnValue:OCMOCK_VALUE(yes)] isSubclassOfClass:[MOComponent class]];
			[[[transformClassMock stub] andReturn:transformMock] alloc];
			id __attribute__((unused)) c = [[[transformMock expect] andReturn:transformMock] initWithGameObject:gameObject];
			[[transformMock expect] awake];

			MOComponent* component = [gameObject addComponentWithClass:transformClassMock];
			expect(component).to.beIdenticalTo((__bridge void*)transformMock);
			
			[transformMock verify];
		});
	});
});

SPEC_END
