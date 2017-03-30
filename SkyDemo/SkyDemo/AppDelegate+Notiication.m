//
//  AppDelegate+Notiication.m
//  SkyDemo
//
//  Created by 何亚慧 on 2017/3/30.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import "AppDelegate+Notiication.h"
#import "AppDelegateHeader.h"
#import <UserNotifications/UserNotifications.h>


@implementation AppDelegate (Notiication)


#pragma mark 注册推送

- (void)initWithApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
}
-(void)registerPushServer {
    
    if (IOS10) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            
            if (granted) {
                //点击允许
                NSLog(@"注册通知成功");
                [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                    NSLog(@"%@", settings);
                }];
            } else {
                //点击不允许
                NSLog(@"注册通知失败");
            }
        }];
        //注册推送（同iOS8）
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        
    }else if （IOS8_TO_10）{//iOS8到iOS10
        
        //1.创建消息上面要添加的动作(按钮的形式显示出来)
        UIMutableUserNotificationAction *action = [[UIMutableUserNotificationAction alloc] init];
        action.identifier = @"action";//按钮的标示
        action.title=@"Accept";//按钮的标题
        action.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
        //    action.authenticationRequired = YES;
        //    action.destructive = YES;
        
        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];
        action2.identifier = @"action2";
        action2.title=@"Reject";
        action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
        action.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
        action.destructive = YES;
        
        //2.创建动作(按钮)的类别集合
        UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
        categorys.identifier = @"alert";//这组动作的唯一标示,推送通知的时候也是根据这个来区分
        [categorys setActions:@[action,action2] forContext:(UIUserNotificationActionContextMinimal)];
        
        //3.创建UIUserNotificationSettings，并设置消息的显示类类型
        UIUserNotificationSettings *notiSettings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIRemoteNotificationTypeSound) categories:[NSSet setWithObjects:categorys, nil nil]];//categories设置为nil则推送无动作
        
        //会执行代理函数- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
        // 获取type
        // UIUserNotificationSettings *settings = [application currentUserNotificationSettings];
        // UIUserNotificationType types = [settings types];
        
        [application registerForRemoteNotifications];
        
    } else {//iOS8以下
        
        [application registerForRemoteNotificationTypes: UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound];
    }
}


@end
