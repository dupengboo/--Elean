//
//  AppDelegate.m
//  LoveLimiteFree
//
//  Created by Elean on 16/3/15.
//  Copyright (c) 2016年 Elean. All rights reserved.
//

#import "AppDelegate.h"
#import "NewFeatureViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    [_window makeKeyAndVisible];
    
    [self chooseRootController];
    
    return YES;
}
#pragma mark------判断是否是新版本
- (void)chooseRootController {
    //判断是否是最新版本
    NSString * versionKey = @"versonCode";
    
    //    取出沙盒中存储的版本号
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * lastVersion = [defaults stringForKey:versionKey];
    //    获得当前软件的版本号（从plist里面取）
    NSString * currentVerison = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    
    if ([lastVersion isEqualToString:currentVerison]) {
        [UIApplication sharedApplication].statusBarHidden = NO;
        UIViewController *ctr =  [Factory createControllerWithName:@"LimiteFreeController"];

        [UIApplication sharedApplication].keyWindow.rootViewController = ctr;
    }else  {
        //     显示新版本特性
        [UIApplication sharedApplication].keyWindow.rootViewController = [[NewFeatureViewController alloc]init];
        //        存储新版本
        [defaults setObject:currentVerison forKey:versionKey];
        [defaults synchronize];
    }
    
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