//
//  TabBarItem.h
//  CustomTabbarController
//
//  Created by Elean on 16/3/16.
//  Copyright (c) 2016年 Elean. All rights reserved.
//
/*
 继承于UIButton 在tabBar定制中 替换掉UITabBar显示的效果 实现跟UITabBarItem一样的功能
 */
#import <UIKit/UIKit.h>
#import "TabBarModel.h"

@interface TabBarItem : UIButton

//从外部传递一个模型 将模型的数据展示在button上
- (void)setTabBarItemWithModel:(TabBarModel *)model;

@end














