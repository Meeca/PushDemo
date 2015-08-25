//
//  AppDelegate+LocalNotifiction.h
//  PushDemo
//
//  Created by 冯洪建 on 15/8/25.
//  Copyright (c) 2015年 冯洪建. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (LocalNotifiction)<UIAlertViewDelegate>


///本地添加
-(void)addLocalPushNotification;

///本地移除
-(void)removeLocalPushNotification;


@end
