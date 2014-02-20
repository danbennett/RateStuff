//
//  DBAppDelegate.m
//  Auditr
//
//  Created by Daniel Bennett on 09/12/2013.
//  Copyright (c) 2013 Daniel Bennett. All rights reserved.
//

#import "DBAppDelegate.h"
#import "DBCoreDataManager.h"
#import "DBParseSettings.h"
#import <AFNetworking/AFNetworking.h>
#import <Parse/Parse.h>

@implementation DBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[self setupTyphoon];
	
	[self setupCoreData];
	
	[self styleNavBar];
	
	[[AFNetworkActivityIndicatorManager sharedManager] setEnabled: YES];
	
	DBParseSettings *settings = [DBParseSettings sharedInstance];
	[Parse setApplicationId: settings.applicationId
				  clientKey: settings.clientKey];
	
	[PFUser enableAutomaticUser];
	
    return YES;
}

- (void) setupTyphoon
{
	TyphoonComponentFactory *factory = [TyphoonBlockComponentFactory factoryWithAssembly: [DBAssembly assembly]];
	[factory makeDefault];
}

#pragma mark - Core Data setup.
- (void) setupCoreData
{
	[[DBCoreDataManager sharedInstance] setupStack];
}

- (void) styleNavBar
{
	UIImage *backgroundImage = [[UIImage imageNamed:@"topBarBackground"] resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeTile];
	[[UINavigationBar appearance] setBackgroundImage: backgroundImage forBarMetrics: UIBarMetricsDefault];
	UIImage *shadowImage = [[UIImage imageNamed:@"topBarShadow"] resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeTile];
	[[UINavigationBar appearance] setShadowImage: shadowImage];
	
	NSShadow *shadow = [[NSShadow alloc] init];
	shadow.shadowColor = [[UIColor blackColor] colorWithAlphaComponent: 0.2f];
	shadow.shadowOffset = CGSizeMake(0.0, 2.0);
	
	NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"Museo Sans" size: 20.0f],
								 NSForegroundColorAttributeName: [UIColor whiteColor],
								 NSShadowAttributeName: shadow};
	[[UINavigationBar appearance] setTitleTextAttributes: attributes];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Saves changes in the application's managed object context before the application terminates.
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
