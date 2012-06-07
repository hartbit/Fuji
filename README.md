# Fuji

Fuji is an Objective-C 2D game framework that is simple, extensible, and documentated. It currently only builds on iOS.

It strives to be simple by following [convention over configuration](http://en.wikipedia.org/wiki/Convention_over_configuration), but without loosing any flexibility by offering many points of extensibility. It also makes a priority of containning quality documentation that is always complete and up to date.

## Features

* Flexible entity-component model.
* Powerful and expressive animation system.
* Intelligent asset management.

## Installation

Fuji uses [CocoaPods](https://github.com/CocoaPods/CocoaPods). If you have never used it before, these steps will get you started:

1. Create an empty Xcode project.
2. Run the following commands from the project directory:

	```bash
	$ sudo gem install cocoapods --pre
	$ pod setup
	$ echo -e "platform :ios, '5.0'\n\ndependency 'Fuji'" > Podfile
	$ pod install
	```

3. Open and work from the newly created Xcode Workspace.

## Setup

Here is an example of setting up Fuji in the `application:didFinishLaunchingWithOptions:` method.

```objective-c
- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
	FUDirector* director = [FUDirector new];
	[director setPreferredFramesPerSecond:60];

	UIWindow* window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	[window setRootViewController:director];
	[window makeKeyAndVisible];
	return YES;
}
```

`FUDirector` is a subclass of `GLKViewController`, so we can call `setPreferredFramesPerSecond:` on it and set it as the `rootViewController`.

## Entities and Components

Fuji follows an entity-component model. Each object in a scene is represented by an instance of the `FUEntity` class, and each entity is defined by it's components, instances of the `FUComponent` class. They model the behavior and properties of that entity. Here's a sample code that creates and positios a sprite in the scene:

```objective-c
FUEntity* entity = [scene createEntity];
			
FUSpriteRenderer* renderer = [entity addComponentWithClass:[FUSpriteRenderer class]];
[renderer setTexture:@"Sprite.png"];
[renderer setColor:FURandomColor()];
			
FUTransform* transform = [entity transform];
[transform setPosition:GLKVector2Make(120.0f, 240.0f))];
```

## Actions

Actions are strongly influenced by cocos2d actions but with three key differences:

* They use a different function-based syntax.
* They are not tied to components (nodes in cocos2d). This allows sequences/spawns/groups of actions to affect different components.
* Time can flow backwards without having to reverse an action.

Here is an example that runs a couple of actions:

```objective-c
GLKVector2 targetPosition = GLKVector2Make(0.0f, 0.0f);
id moveRotateAction = FUSpeed(FUSpawn(FUMoveTo(2.0, entity, targetPosition), FURotateBy(1.5, entity, M_PI), 1.0f);
[[scene animator] runAction:moveRotateAction];

id timeModificationAction = FUTweenTo(2.0, moveRotateAction, @"speed", -1.0f);
[[scene animator] runAction:timeModificationAction];
```

* The `FUSpeed` action runs the `FUSpawn` action at a speed of `1.0f`.
* The `FUSpawn` action runs the `FUMoveTo` and `FURotateBy` actions in parallel.
* The `FUMoveTo` action will move the entity to the `targetPosition` in `2.0` seconds.
* The `FURotateBy` action will rotate the entity by `M_PI` in `1.5` seconds.
* The `FUTweenTo` action will interpolate the `speed` property of the `FUSpeed` action to the value `-1.0f` in `2.0` seconds. This will slow down the `moveRotateAction` until it stops after `1.0f` seconds and it will then slowly reverse it until it reaches it's start state.

## Acknowledgments

I'd like to thank the developers of the following engines that have greatly influenced me:

* Unity3D
* XNA Framework
* cocos2d