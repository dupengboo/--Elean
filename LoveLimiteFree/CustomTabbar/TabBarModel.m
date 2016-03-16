//
//  TabBarModel.m
//  CustomTabbarController
//
//  Created by Elean on 16/3/16.
//  Copyright (c) 2016年 Elean. All rights reserved.
//

#import "TabBarModel.h"

@implementation TabBarModel

#if 0
@synthesize title = _title;
//属性set get方法的实现 等号后 相当于给属性在.m中取别名 别名调用属性时 没有调动set get方法 不会影响引用计数

//如果直接缺省@synthesize 系统会自动添加 添加的形式如上

@synthesize normalColor;
//也是set get方法的实现 但是别名不是加下划线 而是属性名本身
//例如 normalColor这么写 .m中 可以直接使用“normalColor”调用属性
#endif
#pragma mark -- 类工厂方法的实现
+ (TabBarModel *)createModelWithDic:(NSDictionary *)dic{

    TabBarModel *model = [[TabBarModel alloc]init];
    [model setValuesForKeysWithDictionary:dic];
    
    return model;
    
}




@end








