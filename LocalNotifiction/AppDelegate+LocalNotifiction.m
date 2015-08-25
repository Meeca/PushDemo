//
//  AppDelegate+LocalNotifiction.m
//  PushDemo
//
//  Created by 冯洪建 on 15/8/25.
//  Copyright (c) 2015年 冯洪建. All rights reserved.
//

#import "AppDelegate+LocalNotifiction.h"

@implementation AppDelegate (LocalNotifiction)

///本地添加
-(void)addLocalPushNotification{
    
    // 创建一个本地推送
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    
    // 打开程序 10 秒 后 推送一条消息
    NSDate * nowDate = [NSDate dateWithTimeIntervalSinceNow:10];
    
        if (notification != nil) {
            // 设置推送时间
            notification.fireDate = nowDate;
            // 设置时区
            notification.timeZone = [NSTimeZone defaultTimeZone];
            // 设置重复间隔
            notification.repeatInterval = kCFCalendarUnitDay;
            // 推送声音
            notification.soundName =UILocalNotificationDefaultSoundName;// @"跳跃.wav"; // UILocalNotificationDefaultSoundName 默认声音
            // 推送内容
            notification.alertBody = @"提醒更新(用于测试阶段)";
            //显示在icon上的红色圈中的数子
            notification.applicationIconBadgeNumber = 1;
            //设置userinfo 方便在之后需要撤销的时候使用
            NSDictionary *info = [NSDictionary dictionaryWithObject:@"name"forKey:@"key"];
            notification.userInfo = info;
            //添加推送到UIApplication
            UIApplication *app = [UIApplication sharedApplication];
            [app scheduleLocalNotification:notification];
        }
}


- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification*)notification
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒更新(用于测试阶段)"message:@"下载前请检查网站更新时间" delegate:self cancelButtonTitle:@"取消"otherButtonTitles:@"去更新",nil];
    [alert show];
    // 图标上的数字减1
    application.applicationIconBadgeNumber -= 1;
    NSLog(@"didReceiveLocalNotification");
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://fir.im/XXXX"]];
    }
}




///本地移除
-(void)removeLocalPushNotification{
    NSLog(@"%s",__FUNCTION__);
    UIApplication* app=[UIApplication sharedApplication];
    //获取当前应用所有的通知
    NSArray* localNotifications=[app scheduledLocalNotifications];
    
    if (localNotifications) {
        
        for (UILocalNotification* notification in localNotifications) {
            
            NSDictionary* dic=notification.userInfo;
            
            if (dic) {
                NSString* key=[dic objectForKey:@"key"];
                if ([key isEqualToString:@"name"]) {
                    //取消推送 （指定一个取消）
                    [app cancelLocalNotification:notification];
                    
                    break;
                }
            }
            
        }
    }
    //取消当前应用所有的推送
    //[app cancelAllLocalNotifications];
}







@end
