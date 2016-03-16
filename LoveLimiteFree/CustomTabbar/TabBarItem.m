//
//  TabBarItem.m
//  CustomTabbarController
//
//  Created by Elean on 16/3/16.
//  Copyright (c) 2016年 Elean. All rights reserved.
//

#import "TabBarItem.h"

@implementation TabBarItem
//1.实现声明方法

#pragma mark -- 设置显示的效果
- (void)setTabBarItemWithModel:(TabBarModel *)model{

    //(1)title
    [self  setTitle:model.title forState:UIControlStateNormal];
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    //title是显示在button.titleLabel
    self.titleLabel.font = [UIFont systemFontOfSize:13];
    
    
    //(2)titleColor
    [self setTitleColor:model.normalColor forState:UIControlStateNormal];
    //注意：由于高亮状态下 button有一个默认的颜色 为了效果 将高亮下的颜色设置为normalColor
    [self setTitleColor:model.normalColor forState:UIControlStateHighlighted];
    
    [self setTitleColor:model.selectColor forState:UIControlStateSelected];
    
    //(3)image
    //由于选中之后 会将图片有颜色的部分显示为tinColor 处理的方式 设置图片还原 只显示原来的颜色
    
    UIImage *image1 = [UIImage imageNamed:model.normalImage];
    
    UIImage *image10 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //总是显示原来的颜色
    
    [self setImage:image10 forState:UIControlStateNormal];
    [self setImage:image10 forState:UIControlStateHighlighted];
    
    
    
    UIImage *image2 = [UIImage imageNamed:model.selectImage];
    
    UIImage *image20 = [image2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //总是显示原来的颜色
    
    [self setImage:image20 forState:UIControlStateSelected];
    
   //去掉选中时title上出现的蓝色的色块
    self.tintColor = [UIColor clearColor];

   
    
}


//2.重写UIbutton相关的方法  设置title 以及image显示的位置

#pragma mark -- 自定义title显示的位置
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
//如果想自己设置title的位置 重写该方法 返回值是title的坐标
// contentRect就是button自身的大小
    
    return CGRectMake(0, contentRect.size.height - 21, contentRect.size.width, 21);
    
}

#pragma mark -- 自定义image显示的位置
- (CGRect)imageRectForContentRect:(CGRect)contentRect{

    
    return CGRectMake(0, 0, contentRect.size.width, contentRect.size.height - (21 + 5));
}








@end
