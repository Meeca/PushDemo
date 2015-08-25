# PushDemo
第一次发
可以快速的集成极光推送和本地推送，只要把类文件拖入到项目中就完成了极光推送和本地推送的集成
1>

#import "AppDelegate+JPush.h"
#import "AppDelegate+LocalNotifiction.h"


2>


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    // 初始化 极光推送
    [self initJPushWithApplication:application withOptions:launchOptions];
    
    // 添加本地推送
    [self addLocalPushNotification];
    
    
    
    return YES;
}


好了，完成 
