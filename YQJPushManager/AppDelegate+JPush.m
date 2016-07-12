//
//  AppDelegate+JPush.m
//  HappyBlueOcean
//
//  Created by Mopon on 16/7/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "AppDelegate+JPush.h"
#import "JPUSHService.h"
#import "YQJPushManager.h"

@implementation AppDelegate (JPush)

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // IOS 7 Support Required
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    YQJPushManager *manager =  [YQJPushManager sharedManager];
    [manager didReceiveRemoteNotification:userInfo];
    
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

@end
