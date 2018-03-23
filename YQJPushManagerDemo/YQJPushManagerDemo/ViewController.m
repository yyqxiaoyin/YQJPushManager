//
//  ViewController.m
//  YQJPushManagerDemo
//
//  Created by Mopon on 16/7/12.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import "ViewController.h"
#import "YQJPushManager.h"

@interface ViewController ()<YQJPushManagerDelegate>

@end

//新版本

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [YQJPushManager addListener:self];
    
}
-(void)didReceiveRemoteNotification:(NSDictionary *)userInfo{
    NSLog(@"推送数据：%@",userInfo);
}

-(void)dealloc{

    [YQJPushManager removeListener:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
