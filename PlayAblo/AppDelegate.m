

#import "AppDelegate.h"
#import "Reachability.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Tab bar text colour
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    
       // Tab bar colour
   [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.99 green:0.30 blue:0.26 alpha:1.0]];
   [[UITabBar appearance] setBarTintColor:[UIColor colorWithRed:0.22 green:0.22 blue:0.22 alpha:1.0]];
    
    // Set the selected colors
       [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0.12 green:0.54 blue:1.0 alpha:1.0], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];

    
    [[UITabBarItem appearance] setTitleTextAttributes:@{UITextAttributeFont:[UIFont boldSystemFontOfSize:14]} forState:UIControlStateNormal];
    
    [GIDSignIn sharedInstance].clientID = @"100763065088-gslautaimg4jfibuku90422vah3plefc.apps.googleusercontent.com";
    
    UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                    UIUserNotificationTypeBadge |
                                                    UIUserNotificationTypeSound);
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes categories:nil];
    [application registerUserNotificationSettings:settings];
   
        return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    if (notificationSettings.types != UIUserNotificationTypeNone) {
        NSLog(@"didRegisterUser");
        [application registerForRemoteNotifications];
    }}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSString *str = [NSString stringWithFormat: @"Error: %@", error];
    NSLog(@"%@",str);
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    /*
     // Store the deviceToken in the current installation and save it to Parse.
     PFInstallation *currentInstallation = [PFInstallation currentInstallation];
     [currentInstallation setDeviceTokenFromData:deviceToken];
     currentInstallation.channels = @[ @"global" ];
     [currentInstallation saveInBackground];
     */
    NSString *deviceTokenString = deviceToken.description;
    deviceTokenString = [deviceTokenString stringByReplacingOccurrencesOfString:@"[< >]" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, deviceTokenString.length)];
    NSUserDefaults*userdefault=[NSUserDefaults standardUserDefaults];
    [userdefault setObject:deviceTokenString forKey:@"deviceToken"];
     [userdefault setValue:deviceTokenString forKey:@"deviceToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSLog(@"%@", deviceTokenString.description);
    NSLog(@"did register notif");
}

@end
