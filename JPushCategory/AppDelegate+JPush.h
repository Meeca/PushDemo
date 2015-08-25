//
//  AppDelegate+JPush.h
//  PushDemo
//
//  Created by 冯洪建 on 15/8/25.
//  Copyright (c) 2015年 冯洪建. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (JPush)<UIAlertViewDelegate>

/*!
 *  @author fhj, 15-07-31 10:07:50
 *
 *  @brief 初始化 极光推送
 *
 */
- (void)initJPushWithApplication:(UIApplication *)application withOptions:(NSDictionary *)launchOptions;

- (void)push;

@end
