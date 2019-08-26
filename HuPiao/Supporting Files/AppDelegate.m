//
//  AppDelegate.m
//  HuPiao
//
//  Created by 栾金鑫 on 2019/5/19.
//  Copyright © 2019年 栾金鑫. All rights reserved.
//

#import "AppDelegate.h"
#import "HP_LoginViewController.h"
#import "HP_UpdatePwdViewController.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate () <JMessageDelegate,JPUSHRegisterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [JPUSHService setDebugMode]; //在 application 里面调用，设置开启 JPush 日志
    [JMessage setDebugMode]; //在
    // 定位
    [self getlocation];
    // 注册极光
    [self registJG:launchOptions];
    // 监听
    [self onDBMigrateStart];
    // 设置极光IM
    [self setupJMessage:launchOptions appKey:JGAppKey channel:@"app store" apsForProduction:NO category:nil messageRoaming:NO];
    
    [self initAPNS];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.backgroundColor = [UIColor whiteColor];

    HP_NavigationViewController * loginNav = [[HP_NavigationViewController alloc] initWithRootViewController:[HP_LoginViewController new]];
    
    self.window.rootViewController = [HP_TabbarViewController new];   // loginNav; //
    
    [self.window makeKeyAndVisible];
    
    // 给单例赋值属性
    HP_UserTool * configs = [HP_UserTool sharedUserHelper];
    [configs saveUser];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [JPUSHService setBadge:0];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
// 注册极光
- (void) registJG:(NSDictionary *) launchOptions {
    // 统计
    JANALYTICSLaunchConfig * config = [[JANALYTICSLaunchConfig alloc] init];
    config.appKey = JGAppKey;
    config.channel = @"channel";
    [JANALYTICSService setupWithConfig:config];
    // 推送
    [JPUSHService setupWithOption:launchOptions appKey:JGAppKey
                          channel:@"App Store"
                 apsForProduction:NO
            advertisingIdentifier:nil];
    //获取注册id
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        NSLog(@"registrationID ----- %@",registrationID);
    }];
    // 推送别名
    [JPUSHService setAlias:[HP_UserTool sharedUserHelper].strDisplayName completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        NSLog(@"%@",iAlias);
       
        if (iResCode == 0) {
            NSLog(@"添加别名成功");
        }
    } seq:0];
    // 分享
    JSHARELaunchConfig *shareConfig = [[JSHARELaunchConfig alloc] init];
    shareConfig.appKey = JGAppKey;
    // 微博
    shareConfig.SinaWeiboAppKey = @"313189981";
    shareConfig.SinaWeiboAppSecret = @"4238935de59351f8abde2fe72cc57882";
    shareConfig.SinaRedirectUri = @"http://wap.camgou.com/common/Receive/Weibo/oauthlogin.aspx";
    // QQ
    shareConfig.QQAppId = @"101417766";
    shareConfig.QQAppKey = @"8fbab3b01c37c3ce036d2805c7d3fdbe";
    // 微信
    shareConfig.WeChatAppId = @"wx7197abfb087c1e3d";
    shareConfig.WeChatAppSecret = @"019747ada948686d406aef9c5dd64835";
    // 极光认证
//    shareConfig.JChatProAuth = @"";
    [JSHAREService setupWithConfig:shareConfig];
    [JSHAREService setDebug:YES];
}

-(void)initAPNS {
    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

// iOS 12 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification API_AVAILABLE(ios(10.0)) API_AVAILABLE(ios(10.0)){
    if (@available(iOS 10.0, *)) {
        if (notification && [notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            //从通知界面直接进入应用
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
            [JPUSHService setBadge:0];
        }else{
            //从通知设置界面进入应用
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
            [JPUSHService setBadge:0];
        }
    } else {
        // Fallback on earlier versions
    }
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler  API_AVAILABLE(ios(10.0)){
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if (@available(iOS 10.0, *)) {
        if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            [JPUSHService handleRemoteNotification:userInfo];
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
            [JPUSHService setBadge:0];
        }
    } else {
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        [JPUSHService setBadge:0];
        // Fallback on earlier versions
    }
    if (@available(iOS 10.0, *)) {
        completionHandler(UNNotificationPresentationOptionAlert);
    } else {
        // Fallback on earlier versions
    } // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler  API_AVAILABLE(ios(10.0)){
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if (@available(iOS 10.0, *)) {
        if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            [JPUSHService handleRemoteNotification:userInfo];
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
            [JPUSHService setBadge:0];
        }
    } else {
        // Fallback on earlier versions
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        [JPUSHService setBadge:0];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [JPUSHService setBadge:0];
    
    completionHandler(UIBackgroundFetchResultNewData);
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
//    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
//    [JPUSHService setBadge:0];
    // Required, For systems with less than or equal to iOS 6
//    [JPUSHService handleRemoteNotification:userInfo];
}

// 分享
//仅支持 iOS9 以上系统，iOS8 及以下系统不会回调
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    [JSHAREService handleOpenUrl:url];
    return YES;
}

// IM
- (void)setupJMessage:(NSDictionary *)launchOptions
               appKey:(NSString *)appKey
              channel:(NSString *)channel
     apsForProduction:(BOOL)isProduction
             category:(NSSet *)category
       messageRoaming:(BOOL)isRoaming {
    
    [JMessage setupJMessage:launchOptions appKey:appKey channel:channel apsForProduction:isProduction category:category messageRoaming:isRoaming];
    
    // Required - 注册 APNs 通知
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JMessage registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                      UIUserNotificationTypeSound |
                                                      UIUserNotificationTypeAlert)
                                          categories:nil];
    }
}

// 监听
- (void)onDBMigrateStart {
    NSLog(@"onDBmigrateStart in appdelegate");
//    _isDBMigrating = YES;
}

// 获取定位
- (void) getlocation {
    [[CLocationManager shareLocation] getLocationCoordinate:^(CLLocationCoordinate2D locationCorrrdinate) {
        NSLog(@"latitude = %f --- %f",locationCorrrdinate.latitude,locationCorrrdinate.longitude);
        // 极光统计位置信息
        [JANALYTICSService setLatitude:locationCorrrdinate.latitude longitude:locationCorrrdinate.longitude];
    } withAddress:^(NSString *addressString) {
        NSLog(@"addressString = %@",addressString);
    } FirstTime:^{
        NSLog(@"first");
    }];
}

@end
