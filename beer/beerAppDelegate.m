//
//  beerAppDelegate.m
//  beer
//
//  Created by Chris Griffith on 1/21/12.
//  Copyright (c) 2012 Levi Strauss & Co. All rights reserved.
//

#import "beerAppDelegate.h"
#import "Parse/Parse.h"
#import "loginpage.h"
#import "MyTableController.h"


@implementation beerAppDelegate

@synthesize window = _window;
//@synthesize barPlotViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
   //self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //Override point for customization after application launch.
    //self.window.backgroundColor = [UIColor whiteColor];
    
    //barPlotViewController = [[BarPlotViewController alloc] init];
    //[self.window setRootViewController:barPlotViewController];
    //[self.window makeKeyAndVisible];
    

    
    // This is the key info for parse.com
    [Parse setApplicationId:@"vzgdhTdNRBcaT5WDsQM7rz2OyAHAGbwLfdxz4lap" 
                  clientKey:@"bozaqLkwN8dSsSMRRLtM9WyN1ouHlVzaCzhCQjki"];
    // This is the key info for parse.com   
    
    //facebookid
    
     [Parse setFacebookApplicationId:@"232190216866063"];
    
    
    // Register for push notifications
    [application registerForRemoteNotificationTypes: 
     UIRemoteNotificationTypeBadge |
     UIRemoteNotificationTypeAlert |             
     UIRemoteNotificationTypeSound];
    
   // PFQueryTableViewController *controller = [[PFQueryTableViewController alloc] initWithClassName:@"todo"];
    
   // self.window.rootViewController = controller;
  //  [self.window makeKeyAndVisible];
    
    
     // Override point for customization after application launch.
    //self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[UIViewController alloc] init]];
    //self.window.backgroundColor = [UIColor whiteColor];
    //[self.window makeKeyAndVisible];
    
    return YES;
}


- (void)application:(UIApplication *)application 
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)newDeviceToken
{
    [PFPush storeDeviceToken:newDeviceToken]; // Send parse the device token
    // Subscribe this user to the broadcast channel, "" 
    [PFPush subscribeToChannelInBackground:@"" block:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"Successfully subscribed to the broadcast channel.");
        } else {
            NSLog(@"Failed to subscribe to the broadcast channel.");
        }
    }];
}


- (void)application:(UIApplication *)application 
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
}



// ****************************************************************************
// App switching methods to support Facebook Single Sign-On
// ****************************************************************************

// Pre 4.2 support
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [[PFUser facebook] handleOpenURL:url]; 
}

// For 4.2+ support
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [[PFUser facebook] handleOpenURL:url]; 
} 



							
- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
