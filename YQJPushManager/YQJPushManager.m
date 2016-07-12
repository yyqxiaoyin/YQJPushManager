//
//  YQJPushManager.m
//  HappyBlueOcean
//
//  Created by Mopon on 16/7/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "YQJPushManager.h"
#import "JPUSHService.h"
#import <UIKit/UIKit.h>

#define JPushAppKey @"d471ea2f00a3094f30fb7847"
#define JPushChannel @"appStore"

@interface YQJPushManager ()

@property (nonatomic ,strong)NSMutableArray *listeners;//监听对象数组

@end

@implementation YQJPushManager

+ (YQJPushManager *)sharedManager
{
    static YQJPushManager *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}

+(void)registerJPush:(NSDictionary *)launchOptions{
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];

    [JPUSHService setupWithOption:launchOptions appKey:JPushAppKey channel:JPushChannel apsForProduction:NO];
}

+(void)addListener:(id<YQJPushManagerDelegate>)listener{

    YQJPushManager *manager = [YQJPushManager sharedManager];
    if ([manager.listeners containsObject:listener]) {//如果对象已经添加了监听但没有被移除
        return;
    }else{
        [manager.listeners addObject:listener];
    }
}

+(void)removeListener:(id<YQJPushManagerDelegate>)listener{

    YQJPushManager *manager = [YQJPushManager sharedManager];
    if ([manager.listeners containsObject:listener]) {//如果存在该监听对象，移除
        [manager.listeners removeObject:listener];
    }else{
        return;
    }
}

-(void)didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    if (self.listeners.count == 0) return;//没有监听对象。return
    [self.listeners enumerateObjectsUsingBlock:^(id<YQJPushManagerDelegate>listener , NSUInteger idx, BOOL * _Nonnull stop) {
       
        if ([listener respondsToSelector:@selector(didReceiveRemoteNotification:)]) {
            
            [listener didReceiveRemoteNotification:userInfo];
        }
        
    }];
}


-(NSMutableArray *)listeners{

    if (!_listeners) {
        _listeners = [NSMutableArray array];
    }
    return _listeners;
}

@end
