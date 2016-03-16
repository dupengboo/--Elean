//
//  Factory.m
//  LimiteFree
//
//  Created by Elean on 16/1/19.
//  Copyright (c) 2016年 Elean. All rights reserved.
//

#import "Factory.h"

@implementation Factory
#pragma mark -- 创建普通控制器
+ (UIViewController *)createControllerWithName:(NSString *)name{

    Class class = NSClassFromString(name);
    
    
    return [[class alloc]init];
    
#if 0
    
    Class class = NSClassFromString(name);
    
    UIViewController *ctrView = [[class alloc]init];
    return ctrView;
#endif
    
#if 0
   return  [[NSClassFromString(name) alloc]init];
#endif
    
}

#pragma mark -- 创建控制器并设置背景颜色
+ (UIViewController *)createControllerWithName:(NSString *)name andBackgroundColor:(UIColor *)backgroundColor{

    UIViewController *ctrView = [self createControllerWithName:name];
    
    ctrView.view.backgroundColor = backgroundColor;
    
    return ctrView;
    
}

#pragma mark -- 创建分栏控制器管理的导航控制器
+ (UINavigationController *)createNavigationWithRootViewController:(NSString *)name andTitle:(NSString *)title andNormalImage:(NSString *)normalImage andSeletedImage:(NSString *)selectedImage{
//name: 导航控制器的根控制器名
    
//title:分栏控制器对应的item的title 根控制器navigationItem的title
    
//normalImage: 非选中状态下的图片名
    
//selectedImage:选中状态下的图片名
    
    //1.创建根控制器
    UIViewController *rootView = [self createControllerWithName:name];
    
    //2.设置根控制器navigationItem的title
    rootView.navigationItem.title = title;
    
    //3.创建导航控制器
    UINavigationController *nac = [[UINavigationController alloc]initWithRootViewController:rootView];
    
    //4.设置tabBarItem
    UIImage *selectImage = [UIImage imageNamed:selectedImage];
     selectImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //在UIControl （button等可以可以点击的控件） 显示该图片时 不使用镂空色
    
    nac.tabBarItem = [[UITabBarItem alloc]initWithTitle:title image:[UIImage imageNamed:normalImage] selectedImage:selectImage];
    
    
    return nac;
    
}



@end
