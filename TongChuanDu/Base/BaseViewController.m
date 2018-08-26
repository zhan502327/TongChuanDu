//
//  BaseViewController.m
//  JianZuLianApp
//
//  Created by 张帅 on 2017/9/7.
//  Copyright © 2017年 JianZuLian. All rights reserved.
//

#import "BaseViewController.h"
#import "NetWorkingTool.h"
#import "NoNetWorkView.h"

@interface BaseViewController ()<NoNetWorkViewDelegate>



@end

@implementation BaseViewController


//视图将要显示时隐藏
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //顶部视图被遮挡解决办法
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    // 显示无网络占位图
    [self checkNewWorkingRuning];

//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

//视图将要消失时取消隐藏
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];

//    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (@available(iOS 11.0, *)){//避免滚动视图顶部出现20的空白以及push或者pop的时候页面有一个上移或者下移的异常动画的问题
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
}

// ------NavgiationBar标题
- (void)setNavgiationBarTitle:(NSString *)string {
    
    //主色调
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
//
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBar_BG"] forBarMetrics:UIBarMetricsDefault];
    
    self.title = string;
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:HexColor(0XFFFFFF),NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Semibold" size:16]};
    
}

- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action {
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:UseImage(@"App_NavBar_backImg_Icon") style:UIBarButtonItemStyleDone target:target action:action];
    item.tintColor = [UIColor whiteColor];
    return item;
}

#pragma mark - **************** 显示无网络占位图
// ------每次切换 controller 时 在viewWillAppear 里调用
- (void)checkNewWorkingRuning {
    
    // 如果没网,加载无网占位图
    if (![CHECKNETWORKING isNetWorkRunning]) {
        // 无网加载无网站位图
        [self showNoNetworkView];
    }else{
        // 有网移除所有无网展位图
        for (NoNetWorkView *view in self.view.subviews) {
            if ([view isMemberOfClass:[NoNetWorkView class]]) {
                [view removeFromSuperview];
            }
        }
    }
}

// ------显示无网络视图
- (void)showNoNetworkView {
    // 将导航栏和tabbar留出来
    NoNetWorkView *noNetworkView = [[NoNetWorkView alloc] initWithFrame:CGRectMake(0, 0, Current_Width, Current_Height)];
    noNetworkView.delegate = self;
    [self.view addSubview:noNetworkView];
}



@end
