//
//  ASRangeSliderAppDelegate.m
//  ASRangeSlider
//
//  Created by Avraham Shukron on 6/9/11.
//

#import "ASRangeSliderAppDelegate.h"
#import "ASRangeSliderViewController.h"

@implementation ASRangeSliderAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
	ASRangeSliderViewController *viewController = [[ASRangeSliderViewController alloc] init];
	[window addSubview:viewController.view];
	[window makeKeyAndVisible];
	self.window = window;
	self.viewController = viewController;
	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
	self.window = nil;
}

@end
