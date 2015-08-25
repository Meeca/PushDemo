//
//  AppDelegate+JPush.m
//  PushDemo
//
//  Created by 冯洪建 on 15/8/25.
//  Copyright (c) 2015年 冯洪建. All rights reserved.
//

#import "AppDelegate+JPush.h"
#import "APService.h"


@implementation AppDelegate (JPush)

- (void)initJPushWithApplication:(UIApplication *)application withOptions:(NSDictionary *)launchOptions{


    //app关闭状态下，点击推送进来，通过下面的方法才能触发didReceiveRemoteNotification
    NSDictionary *apsDict = [launchOptions objectForKey:@"UIApplicationLaunchOptionsRemoteNotificationKey"];
    if (apsDict) {
        [self application:application didReceiveRemoteNotification:apsDict fetchCompletionHandler:^(UIBackgroundFetchResult result) {
            
            //
        }];
    }
    
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert)];
    
    
    // IOS8 新系统需要使用新的代码咯
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings
                                                                             settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge)
                                                                             categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        //这里还是原来的代码
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }

    
    [APService setupWithOption:launchOptions];
    
}

#pragma mark - Jpush
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{

    // Required
    [APService registerDeviceToken:deviceToken];

    //用于极光单推的方式1 registrationID：[APService registrationID]
    [APService setAlias:[APService registrationID] callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];

}


- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias {
   // NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);

    //用于极光单推的方式2 别名： alias
    [[NSUserDefaults standardUserDefaults] setObject:alias forKey:@"alias"];
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{

    // Required
    [APService handleRemoteNotification:userInfo];
    

}


#pragma mark - 收到消息
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {

    // IOS 7 Support Required
    [APService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    
    NSLog(@"--- 推送---  %@------",userInfo);

    //根据userInfo里的参数，执行相关跳转逻辑
    //.....

    UIApplicationState applicationState = [UIApplication sharedApplication].applicationState;
    //    UIApplicationStateActive,
    //    UIApplicationStateInactive,
    //    UIApplicationStateBackground
    
    
    //  只有再程序 处于不活跃状态才跳转到制定页面
    if(applicationState != UIApplicationStateActive){
        // 跳转
        [self push];
        //  把程序 数字 设置为 0
        application.applicationIconBadgeNumber = 0;

    }
    
}

- (void)push{
    
    
    UIViewController * vv ;
    
    
    // 获取导航控制器
    UITabBarController *tabVC = (UITabBarController *)self.window.rootViewController;
    UINavigationController *pushClassStance = (UINavigationController *)tabVC.viewControllers[tabVC.selectedIndex];
    // 跳转到对应的控制器

    UIViewController * vc = (UIViewController *)vv;
    vc.hidesBottomBarWhenPushed = YES;
    [pushClassStance pushViewController:vc animated:YES];
    
}








@end
