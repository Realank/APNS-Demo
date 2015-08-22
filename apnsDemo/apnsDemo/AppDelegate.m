//
//  AppDelegate.m
//  apnsDemo
//
//  Created by Realank on 15/8/20.
//  Copyright (c) 2015年 Realank. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    if ([application respondsToSelector:@selector(isRegisteredForRemoteNotifications)])
    {
        //IOS8
        //创建UIUserNotificationSettings，并设置消息的显示类类型
        UIUserNotificationSettings *notiSettings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound) categories:nil];
        
        [application registerUserNotificationSettings:notiSettings];
        [application registerForRemoteNotifications];
        
    } else{ // ios7
        [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge                                       |UIRemoteNotificationTypeSound                                      |UIRemoteNotificationTypeAlert)];
    }
    
    
//    NSDictionary * userInfo =
//    [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
//    if (userInfo) {
//        NSString *message = [[userInfo objectForKey:@"aps"]objectForKey:@"alert"];
//        NSLog(@"%@",message);
//        application.applicationIconBadgeNumber = application.applicationIconBadgeNumber-1;
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"didFinishLaunchingWithOptions" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        [alert show];
//    }
//    
    
    return YES;

}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)pToken{
    NSLog(@"---Token--%@", pToken);
}

//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
//    
//    NSLog(@"userInfo == %@",userInfo);
//    NSString *message = [[userInfo objectForKey:@"aps"]objectForKey:@"alert"];
//    application.applicationIconBadgeNumber = localNotif.applicationIconBadgeNumber-1;
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//
//    [alert show];
//}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    NSLog(@"userInfo == %@",userInfo);
    NSString *message = [[userInfo objectForKey:@"aps"]objectForKey:@"alert"];
    application.applicationIconBadgeNumber = 0;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"didReceiveRemoteNotification" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alert show];
    
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    
    NSLog(@"Regist fail%@",error);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    if (application.applicationIconBadgeNumber > 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"applicationDidBecomeActive" message:[NSString stringWithFormat:@"Received %ld message(s)",(long)application.applicationIconBadgeNumber] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        application.applicationIconBadgeNumber = 0;
    }
    

}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
