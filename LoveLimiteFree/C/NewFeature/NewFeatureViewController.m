//
//  NewFeatureViewController.m
//  LoveLimiteFree
//
//  Created by MS on 16/3/15.
//  Copyright © 2016年 Elean. All rights reserved.
//

#import "NewFeatureViewController.h"
#import "LimiteFreeController.h"

#define DPBNewfeatureImageCount 5
#define SCREEN_WIDTH  self.view.frame.size.width
#define SCREEN_HEIGHT  self.view.frame.size.height

@interface NewFeatureViewController ()<UIScrollViewDelegate>

@end

@implementation NewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray * phototarray = @[@"helpphoto_one.png",@"helpphoto_two.png",@"helpphoto_three.png",@"helpphoto_four.png",@"helpphoto_five.png"];
    
    //    添加scrollview
    CGFloat scrollW = self.view.frame.size.width;
    CGFloat scrollH = self.view.frame.size.height;
    UIScrollView * scrollView = [[UIScrollView alloc]init];
    scrollView.frame = self.view.bounds;
    [self.view addSubview:scrollView];
    
    for (int i= 0; i < DPBNewfeatureImageCount; i++) {
        UIImageView * imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:phototarray[i]];
        CGFloat imageX = i*scrollW;
        imageView.frame = CGRectMake(imageX, 0, scrollW, scrollH);
        [scrollView addSubview:imageView];
    }
    
    scrollView.contentSize = CGSizeMake(DPBNewfeatureImageCount*scrollW, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.delegate = self;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat count = scrollView.contentOffset.x;
    NSLog(@"%f",count);
    if (count > 1125) {
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, SCREEN_HEIGHT-100, 100, 40)];
        button.backgroundColor = [UIColor orangeColor];
        [button setTitle:@"立即体验" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(OnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}

- (void)OnClick {
    
    [UIApplication sharedApplication].keyWindow.rootViewController = [[LimiteFreeController alloc]init];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
