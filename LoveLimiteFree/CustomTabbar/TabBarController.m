//
//  TabBarController.m
//  CustomTabbarController
//
//  Created by Elean on 16/3/16.
//  Copyright (c) 2016年 Elean. All rights reserved.
//

#import "TabBarController.h"
#import "TabBarItem.h"

@interface TabBarController ()
@property (nonatomic,strong)UIView *tbView;
//属性不能写view 控制器自带一个view属性 不建议去修改self.view
@end

@implementation TabBarController

#pragma mark -- 自定义构造方法
- (instancetype)initWithTitles:(NSArray *)titels andNormalImages:(NSArray *)normalImages andSelectImages:(NSArray *)selectImages andNormalColor:(UIColor *)normalColor andSelectColor:(UIColor *)selectColor andControllers:(NSArray *)controllers{

    if (self = [super init]) {
        
        _titles  = [NSMutableArray arrayWithArray:titels];
        //【注意】数组或者字典 赋值之前一定要先开辟没空间
        
        _normalImages = [NSMutableArray arrayWithArray:normalImages];
        
        _selectImages = [NSMutableArray arrayWithArray:selectImages];
        
        
        _normalColor = normalColor;
        
        _selectColor = selectColor;
        
        
        _controllers = [NSMutableArray arrayWithArray:controllers];
        
        
        
        
    }
    
    
    return self;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //隐藏自带的tabBar 显示xib 定制的
    
    self.tabBar.hidden = YES;
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    //设置状态栏前景颜色 白色的 还需要在plist文件中设置
    
    //info.plist --> information property list -->添加最后一项 值 no（默认值）
    
    
    
}

#pragma mark -- 设置tabBar
- (void)setTabBar{
//获取xib文件 显示在tabBarController上
    
    
    //1.获取xib
    _tbView = [[[NSBundle mainBundle] loadNibNamed:@"TabBar" owner:self options:nil] firstObject];
    
    //2.设置frame
    CGRect rect = _tbView.frame;
    
    rect.origin.y = [UIScreen mainScreen].bounds.size.height - rect.size.height;
    
    rect.size.width = [UIScreen mainScreen].bounds.size.width;
    
    
    _tbView.frame = rect;
    
    
    //3.添加到self.view上
    [self.view addSubview:_tbView];
    
    
    //4.设置item的显示效果
    
    //通过遍历tbView的子视图 通过tag值定位到不同的button
    
    //(1)整合所有数据 封装出模型
    NSMutableArray *models = [NSMutableArray array];
    for(int i = 0; i < CTR_COUNT; i++){
        
        NSDictionary *dic = @{@"title":_titles[i], @"normalImage":_normalImages[i],@"selectImage":_selectImages[i],@"normalColor":_normalColor,@"selectColor":_selectColor};
        
        TabBarModel *model = [TabBarModel createModelWithDic:dic];
        
        
        [models addObject:model];
    
    }
    
    //(2)遍历tbView子视图 找到button 设置显示的效果
    
    for (UIView *subView in _tbView.subviews) {
        
        if ([subView isKindOfClass:[TabBarItem class]]) {
            
            TabBarItem *item = (TabBarItem *)subView;
            
            [item setTabBarItemWithModel:models[item.tag - 100]];
            //如果子视图是TabBarItem 强制类型转换 通过tag值找到对应的model 调用方法设置
            
            [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
            //添加点击事件 目的是点击某个item时 修改selectedIndex 进行控制器切换
        }
        
        
    }
    
 
}

#pragma mark -- 设置管理控制器
- (void)setControllers{
//通过controllers数组中的控制器名 创建出控制器 将控制器放入导航中 再把导航放到tabBarController中管理
    
    
    NSMutableArray *ctrs = [NSMutableArray array];
    
    for (NSString *ctrName in _controllers) {
        
        Class cls = NSClassFromString(ctrName);
        
        UIViewController *viewCtr = [[cls alloc]init];
        
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:viewCtr];
        
        [ctrs addObject:nav];
        
        
    }
    
    self.viewControllers = ctrs;
   
}

#pragma mark -- 设置是否隐藏

- (void)setTabBarHidden:(BOOL)hidden{

    CGRect rect = _tbView.frame;
    
    if (hidden) {
        
        rect.origin.y = [UIScreen mainScreen].bounds.size.height;
    }else{
    
        rect.origin.y = [UIScreen mainScreen].bounds.size.height - rect.size.height;
    }
    
    [UIView animateWithDuration:0.8 animations:^{
        
        _tbView.frame = rect;
        
    }];
    
    
    
}

#pragma mark -- 获取"tabBar"高度

- (CGFloat)tabBatHeight{

    return _tbView.frame.size.height;
}


#pragma mark -- 设置tabBar背景
- (void)setTabBarBackground:(NSString *)imageName{

    
    _tbView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:imageName]];
    //通过图片设置背景
    
}



#pragma mark -- 重写setSelectedIndex方法

- (void)setSelectedIndex:(NSUInteger)selectedIndex{

    [super setSelectedIndex:selectedIndex];
    //表示调用父类的方法 该方法必须写 否则无法进行控制器切换
    
    //TabBarController被创建 默认选中0 所以需要设置xib第一个item选中
    
    //手动触发代理方法 （定制下 代理方法不会主动触发）
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabBarController:didSelectViewController:)]) {
        
        
        [self.delegate tabBarController:self didSelectViewController:self.viewControllers[selectedIndex]];
        //参数1 哪一个tabBarController
        //参数2 当前选中的控制器
        
    }
    
    for(UIView * tempView in _tbView.subviews ){
        
        //遍历加载在_tabBarView上的子视图
        
        if ([tempView isMemberOfClass:[TabBarItem class]]) {
            
            
            TabBarItem * btn1 = (TabBarItem *)tempView;
            
            
            if(  btn1.tag - 100 == selectedIndex){
                
                btn1.selected = YES;
                btn1.userInteractionEnabled = NO;
                
            }else{
                
                btn1.selected = NO;
                btn1.userInteractionEnabled = YES;
            }
            
            
        }
        
    }
    
    

    
}


#pragma mark -- item点击事件
- (void)itemClick:(TabBarItem *)item{

   
    
    //点中item 通过tag-100 设置选中的selectIndex
    
    if(item.tag - 100 == self.selectedIndex){
    
        //选中已经选中的item 不做处理
        return;
    }
    
    
    
  
    
    //设置tabBarController的selectedIndex 切换控制器
    
    self.selectedIndex = item.tag - 100;
    
    //【注意】在自定义的TabBarController中 代理方法不能主动触发 因此 需要重写setSelectedIndex方法 添加触发代理方法的代码
    
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
