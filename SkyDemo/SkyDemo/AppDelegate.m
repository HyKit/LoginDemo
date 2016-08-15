//
//  AppDelegate.m
//  SkyDemo
//
//  Created by 何亚慧 on 16/7/18.
//  Copyright © 2016年 Sky. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
  
    [self setNavigationBar];
    [self setAppStatusBar];
    
    return YES;
}
- (void)setNavigationBar {

    [[UINavigationBar appearance] setBarStyle:UIBarStyleDefault];
    [[UINavigationBar appearance] setBarTintColor:[UIColor cyanColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    

    
//    
//    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:20.0],NSFontAttributeName, nil]];
//    if ([nav.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
// 
    
    
}

- (void)setAppStatusBar {
    //通过sharedApplication获取该程序的UIApplication对象
    UIApplication *app=[UIApplication sharedApplication];
    //设置状态栏的样式
    //app.statusBarStyle=UIStatusBarStyleDefault;//默认（黑色）
    //设置为白色+动画效果
    [app setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    //设置状态栏是否隐藏
    app.statusBarHidden=YES;
    //设置状态栏是否隐藏+动画效果
    [app setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
}
- (void)openUrl {
    /**
     *     
     - (BOOL)openURL:(NSURL*)url;
     openURL:方法的部分功能有
     
     UIApplication *app = [UIApplicationsharedApplication];
     打电话  [app openURL:[NSURLURLWithString:@"tel://110"]];
     发短信  [app openURL:[NSURLURLWithString:@"sms://10086"]];
     发邮件  [app openURL:[NSURLURLWithString:@"mailto://xxcc@fox.com"]];
     打开一个网页资源 [app openURL:[NSURL URLWithString:@"http://www.baidu.com"]];
     打开其他app程序   openURL方法，可以打开其他APP。
     系统内部根据不同的头标示来做出不同的相应。
     
     *
     */

    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
