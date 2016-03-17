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

//网络监测以及提示框
#import "AJNotificationView.h"
#import "SVProgressHUD.h"

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
#pragma mark - 循环检测网络连接状态

-(void)monitorNetworkStatus
{
    //1. 创建对象 通过不断的去请求百度的地址来检测网络状态
    Reachability * reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    
    //2. 注册通知 监听网络状态
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    
    //3. 开始监听 如果网络状态发生变化 则触发通知方法
    [reach startNotifier];
    
    
}

#pragma mark -- 网络状态改变触发的通知方法
-(void)reachabilityChanged:(NSNotification*)note
{
    Reachability * reach = [note object];
    
    if([reach isReachable])
    {
        NSLog(@"Notification Says Reachable");
    }
    else
    {
        NSLog(@"Notification Says Unreachable");
        [self showNoticeMsg:@"无网络连接，请检查网络" WithInterval:2.0f];
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
#pragma mark - 全局提示信息

//提示网络状态（不带block）
-(void)showNoticeMsg:(NSString *)msg WithInterval:(float)timer
{
    [AJNotificationView showNoticeInView:self.window
                                    type:AJNotificationTypeBlue
                                   title:msg
                         linedBackground:AJLinedBackgroundTypeAnimated
                               hideAfter:timer
                                response:^{
                                    // NSLog(@"Response block");
                                }];
}
//提示网络状态（带block）
-(void)showNoticeMsg:(NSString *)msg WithInterval:(float)timer Block:(void (^)(void))response
{
    [AJNotificationView showNoticeInView:self.window
                                    type:AJNotificationTypeBlue
                                   title:msg
                         linedBackground:AJLinedBackgroundTypeAnimated
                               hideAfter:timer offset:0.0f delay:0.0f detailDisclosure:YES
                                response:response];
}

//提示正在提交
-(void)showLoading:(NSString *)msg
{
    NSString *content;
    
    if (msg==nil) {
        content=@"正在提交数据，请稍后…"; //正在提交数据，请稍后…
    }
    else
    {
        content=msg;
    }
    
    [SVProgressHUD showWithStatus:content maskType:SVProgressHUDMaskTypeClear];
}

//关闭提示
-(void)hideLoading
{
    [SVProgressHUD dismiss];
}

//提示成功信息 并在几秒后自动关闭
-(void)hideLoadingWithSuc:(NSString *)msg WithInterval:(float)timer
{
    [SVProgressHUD dismissWithSuccess:msg afterDelay:timer];
}

//提示错误信息 并在几秒后自动关闭
-(void)hideLoadingWithErr:(NSString *)msg WithInterval:(float)timer
{
    [SVProgressHUD dismissWithError:msg afterDelay:timer];
}

//提示成功
-(void)showSucMsg:(NSString *)msg WithInterval:(float)timer
{
    NSString *content;
    
    if (msg==nil) {
        content=@"成功"; //成功
    }
    else
    {
        content=msg;
    }
    
    [SVProgressHUD show];
    [SVProgressHUD dismissWithSuccess:content afterDelay:timer];
}

//提示失败
-(void)showErrMsg:(NSString *)msg WithInterval:(float)timer
{
    NSString *content = nil;
    
    if (msg==nil) {
        content = @"失败";  //失败
    }
    else
    {
        content = msg;
    }
    
    [SVProgressHUD show];
    [SVProgressHUD dismissWithError:content afterDelay:timer];
}

//提示网络错误
- (void)showNetworkError
{
    [SVProgressHUD show];
    [SVProgressHUD dismissWithError:@"网络错误" afterDelay:1.5];

}
@end
