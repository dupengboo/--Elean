//
//  AppDelegate.m
//  LoveLimiteFree
//
//  Created by Elean on 16/3/15.
//  Copyright (c) 2016年 Elean. All rights reserved.
//

#import "AppDelegate.h"
//自己的引导图
#import "NewFeatureViewController.h"
#import "TabBarController.h"
//老师封装的引导图
#import "GuidanceController.h"

@interface AppDelegate ()
@property (nonatomic,strong) UIImageView * niceView;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    [_window makeKeyAndVisible];
    
    [self chooseRootController];
    [self createStartAnimation];

    return YES;
    
}
#pragma mark-----添加启动动画
- (void)createStartAnimation {
    //圖片擴大淡出的效果开始;
    
    //设置一个图片;
    _niceView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _niceView.tag=11;
    _niceView.image = [UIImage imageNamed:@"Default1.png"];
    
    //添加到场景
    [self.window addSubview:_niceView];
    
    //放到最顶层;
    [self.window bringSubviewToFront:_niceView];
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    _niceView.layer.anchorPoint = CGPointMake(0.5,0.5);
    animation.fromValue = @1.0f;
    animation.toValue = @1.3f;
    animation.fillMode=kCAFillModeForwards;
    
    
    animation.removedOnCompletion = NO;
    
    [animation setAutoreverses:NO];
    
    //动画时间
    animation.duration=5;
    animation.delegate=self;
    
    [_niceView.layer addAnimation:animation forKey:@"scale"];
    //结束;
}
#pragma mark---移除动画
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [_niceView removeFromSuperview];
    
}
#pragma mark -- 创建tabBarController
- (TabBarController *)createTabBarController{
    NSArray *titles = @[@"限免", @"降价", @"免费", @"专题", @"热榜"];
    
    NSArray *normalImages = @[@"tabbar_limitfree.png", @"tabbar_reduceprice.png", @"tabbar_appfree.png", @"tabbar_subject.png", @"tabbar_rank.png"];
    
    NSArray *selectImages = @[@"tabbar_limitfree_press.png", @"tabbar_reduceprice_press.png", @"tabbar_appfree_press.png", @"tabbar_subject_press.png", @"tabbar_rank_press.png"];
    
    UIColor *normalColor = [UIColor lightGrayColor];
    
    UIColor *selectColor = [UIColor colorWithRed:87/255.0 green:152/255.0 blue:225/255.0 alpha:1.0];
    //87 152 225
    
    
    NSArray *controllers = @[@"LimiteFreeController", @"ReducePriceController", @"FreeViewController", @"SubjectController", @"HotViewController"];
    
    
    
    TabBarController *tabBar = [[TabBarController alloc]initWithTitles:titles andNormalImages:normalImages andSelectImages:selectImages andNormalColor:normalColor andSelectColor:selectColor andControllers:controllers];
    
    [tabBar setTabBar];
    //设置tabBar的效果
    
    [tabBar setControllers];
    //创建管理的控制器
    
    tabBar.selectedIndex = 0;
    //设置默认选中的控制器
    
    [tabBar setTabBarBackground:@"tabbar_bg.png"];
    //设置tabBar背景
    
    return tabBar;
}

#pragma mark -- create guidance 引导页面（老师）
- (GuidanceController *)createGuidance{
    
    
    NSArray *images = @[@"helpphoto_one.png", @"helpphoto_two.png", @"helpphoto_three.png", @"helpphoto_four.png",@"helpphoto_five.png"];
    
    MyBlock block = ^(void){
        
        //回调的之后  修改根控制器为tabBarController
        self.window.rootViewController = [self createTabBarController];
        
        [self.window makeKeyAndVisible];
    };
    
    GuidanceController *guidance = [[GuidanceController alloc]initWithImages:images andBlock:block];
    
    return guidance;
    
    
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

        [UIApplication sharedApplication].keyWindow.rootViewController = [self createTabBarController];
    }else  {
//        //     显示新版本特性（自己的页面）
//        [UIApplication sharedApplication].keyWindow.rootViewController = [[NewFeatureViewController alloc]init];
        [UIApplication sharedApplication].keyWindow.rootViewController = [self createGuidance];
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
