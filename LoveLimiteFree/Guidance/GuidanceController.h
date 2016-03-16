//
//  GuidanceController.h
//  LoveLimiteFree
//
//  Created by Elean on 16/3/16.
//  Copyright (c) 2016年 Elean. All rights reserved.
//
/*
 该界面实现app第一次启动时 显示的引导页（app功能介绍与使用说明）
 原理：
 第一次启动 检查本地标记是否已经启动过 no 没有启动过 window根控制器设置为引导页 
 引导页展示结束 进入应用
 可以使用blokc or 通知 or 代理 回调到appDelegate中 将window的根控制器修改为应用正常的控制器（TabBarController）
 
 修改本地标记为yes
 
 下一次 再启动app 检查到标记已经为yes 跳过引导页 直接显示正常界面
 
 */

#import <UIKit/UIKit.h>
typedef void(^MyBlock)(void);
//用于回调 修改根控制器的block类型

@interface GuidanceController : UIViewController

@property (nonatomic,copy)MyBlock block;
//block 用于回调

- (instancetype)initWithImages:(NSArray *)images andBlock:(MyBlock)block;
//创建控制器时 从外部传入显示的图片 以及回调的block地址

@end







