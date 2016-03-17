//
//  LimiteFreeController.m
//  LoveLimiteFree
//
//  Created by Elean on 16/3/15.
//  Copyright (c) 2016年 Elean. All rights reserved.
//

#import "LimiteFreeController.h"
#import "BaseHttpClient.h"
@interface LimiteFreeController ()

@end

@implementation LimiteFreeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"限免";
    self.view.backgroundColor = [UIColor redColor];
    // Do any additional setup after loading the view.
    
  NSURL *url =  [BaseHttpClient httpType:GET andURL:[NSString stringWithFormat:API_LIMITEFREE, 1]andParam:nil andSuccessBlock:^(NSURL *URL, id data) {
        
        
    } andFailBlock:^(NSURL *URL, NSError *error) {
        
    }];
    
    NSLog(@"url :%@",url);
    
    
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
