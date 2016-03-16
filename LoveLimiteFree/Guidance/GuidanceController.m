//
//  GuidanceController.m
//  LoveLimiteFree
//
//  Created by Elean on 16/3/16.
//  Copyright (c) 2016年 Elean. All rights reserved.
//

#import "GuidanceController.h"

@interface GuidanceController ()<UIScrollViewDelegate>
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)NSMutableArray *images;

@end

@implementation GuidanceController
#pragma mark -- init方法的实现
- (instancetype)initWithImages:(NSArray *)images andBlock:(MyBlock)block{

    if ((self = [super init])) {
        
        //接收从外部传入的参数
        _images = [NSMutableArray arrayWithArray:images];
        
        _block = block;
        
        
    }
    
    return self;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createScrollView];
    
}

#pragma mark -- create scrollView
- (void)createScrollView{

    //1.创建
    
    _scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    
    //2.设置可滚动的范围
    
    _scrollView.contentSize = CGSizeMake(SCREEN_SIZE.size.width * _images.count, SCREEN_SIZE.size.height);
    
    //3.添加图片
    
    for(int i = 0; i < _images.count; i++){
    
    
        UIImage *image = [UIImage imageNamed:_images[i]];
        
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        
        imageView.frame = CGRectMake(SCREEN_SIZE.size.width * i, 0, SCREEN_SIZE.size.width, SCREEN_SIZE.size.height);
        
        
        [_scrollView addSubview:imageView];
        
    
    }
    
    
    //4.关闭弹簧
    _scrollView.bounces = NO;
    
    //5.关闭滑动条
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    //6.开启翻页模式
    _scrollView.pagingEnabled = YES;
    
    //7.设置代理
    
    _scrollView.delegate = self;
    
    
    //8.在最后一页添加一个button 点击进入app
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(_images.count * SCREEN_SIZE.size.width - 100 - 20, SCREEN_SIZE.size.height - 70 - 20, 100, 70)];
    btn.layer.borderWidth = 2;
    btn.layer.borderColor = [UIColor whiteColor].CGColor;
    btn.layer.cornerRadius = 5;
    
    [btn setTitle:@"开始体验" forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_scrollView addSubview:btn];
    
    
    [self.view addSubview:_scrollView];
    
    
    
    
}

#pragma mark -- button点击事件
- (void)btnClick:(UIButton *)btn{

//    点击button时 通过block 回调到AppDelegate 修改根控制器
    
//    修改本地关于是否已经展示过引导页的标记
    
//    使用用户偏好设置 记录标记
    
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    
    [userDef setInteger:1 forKey:@"IS_SHOW_GUIDANCE"];
    
    [userDef synchronize];
    
//    block回调
    self.block();
    
    
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
