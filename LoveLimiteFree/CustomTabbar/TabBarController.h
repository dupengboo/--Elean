//
//  TabBarController.h
//  CustomTabbarController
//
//  Created by Elean on 16/3/16.
//  Copyright (c) 2016年 Elean. All rights reserved.
//
/*
 隐藏自带的tabBar 用xib的View替换掉（显示在相同的位置）
 实现tabBar的定制
 */

#import <UIKit/UIKit.h>
#define CTR_COUNT 5
//表示有几个item
#define ITEM_W 40

@interface TabBarController : UITabBarController

@property (nonatomic,strong)NSMutableArray *titles;
//item的title

@property (nonatomic,strong)NSMutableArray *normalImages;
//非选中图片

@property (nonatomic,strong)NSMutableArray *selectImages;
//选中图片

@property (nonatomic,strong)UIColor *normalColor;
//非选中title颜色

@property (nonatomic,strong)UIColor *selectColor;
//选中title颜色

@property (nonatomic,strong)NSMutableArray *controllers;
//管理的所有控制器名


//自定义构造方法 items需要的所有数据传递进来
- (instancetype)initWithTitles:(NSArray *)titels andNormalImages:(NSArray *)normalImages andSelectImages:(NSArray *)selectImages andNormalColor:(UIColor *)normalColor andSelectColor:(UIColor *)selectColor andControllers:(NSArray *)controllers;

//设置"tabBar"上的"item"
- (void)setTabBar;

//设置管理的控制器
- (void)setControllers;

//设置是否隐藏"TabBar"
- (void)setTabBarHidden:(BOOL)hidden;

//获取"TabBar"
- (CGFloat)tabBatHeight;

//设置TabBar背景
- (void)setTabBarBackground:(NSString *)imageName;

@end






