//
//  TabBarModel.h
//  CustomTabbarController
//
//  Created by Elean on 16/3/16.
//  Copyright (c) 2016年 Elean. All rights reserved.
//
/*
 该类是数据模型类 将tabbarItem显示的所有数据抽象出来的
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TabBarModel : NSObject

@property (nonatomic,copy)NSString *title;
//显示的文字

@property (nonatomic,copy)NSString *normalImage;
//非选中图片名

@property (nonatomic,copy)NSString *selectImage;
//选中图片名

@property (nonatomic,strong)UIColor *normalColor;
//非选中title颜色


@property (nonatomic,strong)UIColor *selectColor;
//选中title颜色


+ (TabBarModel *)createModelWithDic:(NSDictionary *)dic;
//类工厂方法  传入一个字典  返回一个模型


@end






