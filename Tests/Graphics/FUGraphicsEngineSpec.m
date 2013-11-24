//
//  FUGraphicsEngineSpec.m
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#include "Prefix.pch"
#import "Fuji.h"
#import "FUEngine-Internal.h"
#import "FUComponent-Internal.h"


SPEC_BEGIN(FUGraphicsEngine)

describe(@"The graphics engine", ^{
	it(@"is a subclass of FUEngine", ^{
		expect([FUGraphicsEngine class]).to.beSubclassOf([FUEngine class]);
	});
	
	context(@"initialized a graphics engine", ^{
		__block FUGraphicsEngine* graphicsEngine;
		
		beforeEach(^{
			EAGLContext* context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
			[EAGLContext setCurrentContext:context];
			
			FUViewController * director = mock([FUViewController class]);
			graphicsEngine = [[FUGraphicsEngine alloc] initWithDirector:director];
		});
		
		it(@"is not nil", ^{
			expect(graphicsEngine).toNot.beNil();
		});
		
		it(@"enabled GL_CULL_FACE", ^{
			expect(glIsEnabled(GL_CULL_FACE)).to.beTruthy();
		});
		
		it(@"enabled GL_DEPTH_TEST", ^{
			expect(glIsEnabled(GL_DEPTH_TEST)).to.beTruthy();
		});
	});
});

SPEC_END
