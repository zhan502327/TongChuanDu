//
//  BaseNavViewController.m
//  JianZuLianApp
//
//  Created by 张帅 on 2017/9/12.
//  Copyright © 2017年 JianZuLian. All rights reserved.
//

#import "BaseNavViewController.h"

@interface BaseNavViewController ()

@end

@implementation BaseNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

#pragma mark - 重载父类进行改写 类与类之间的 跳转
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}


@end
