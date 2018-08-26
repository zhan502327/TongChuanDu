//
//  TabBarViewController.m
//  JianZuLianApp
//
//  Created by 张帅 on 2017/9/7.
//  Copyright © 2017年 JianZuLian. All rights reserved.
//

#import "TabBarViewController.h"
#import "HomeViewController.h"
#import "MarketListViewController.h"
#import "WelfareViewController.h"
#import "ExtentionViewController.h"
#import "MineViewController.h"
#import "BaseNavViewController.h"
#import "LoginViewController.h"

@interface TabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [UITabBar appearance].barTintColor = [UIColor whiteColor];

    self.delegate = self;
    

    HomeViewController *homeVC = [[HomeViewController alloc] init];
    [self setRootNavBarViewController:homeVC withBarTitle:@"首页" unselectImage:@"Tabbar_Home_unselected" andSelectImage:@"Tabbar_Home_selected"];
    
    MarketListViewController *orderVC = [[MarketListViewController alloc] init];
    [self setRootNavBarViewController:orderVC withBarTitle:@"商城" unselectImage:@"Tabbar_Market_unselected" andSelectImage:@"Tabbar_Market_selected"];

    WelfareViewController *productListVC = [[WelfareViewController alloc] init];
    [self setRootNavBarViewController:productListVC withBarTitle:@"福利" unselectImage:@"Tabbar_Fuli_unselected" andSelectImage:@"Tabbar_Fuli_selected"];
    
    ExtentionViewController *chatVC = [[ExtentionViewController alloc] init];
    [self setRootNavBarViewController:chatVC withBarTitle:@"推广" unselectImage:@"Tabbar_Extention_unselected" andSelectImage:@"Tabbar_Extention_selected"];
    
    
    MineViewController *chatListVC = [[MineViewController alloc] init];
     [self setRootNavBarViewController:chatListVC withBarTitle:@"我的" unselectImage:@"Tabbar_Mine_unselected" andSelectImage:@"Tabbar_Mine_selected"];
    


}

- (void)setRootNavBarViewController:(UIViewController *)childVC withBarTitle:(NSString *)title unselectImage:(NSString *)unselectImage andSelectImage:(NSString *)selectImage  {

    
    BaseNavViewController *childController = [[BaseNavViewController alloc] initWithRootViewController:childVC];
    
    childController.title = title;
    
    // ------全局设置TabBar图标显示原图
    [childController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:HexColor(0X333333), NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    [childController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:HexColor(0XE7481E), NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
    
    childController.tabBarItem.image = [[UIImage imageNamed:unselectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [self addChildViewController:childController];
}

#pragma mark - **************** UITabBarControllerDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    if (tabBarController.selectedIndex == 1) {

//        if (![App_UserManager isLogin]) {
//            DBLoginViewController *loginVC = [[DBLoginViewController alloc] init];
//            BaseNavViewController *loginNav = [[BaseNavViewController alloc] initWithRootViewController:loginVC];
//            loginNav.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18.0f]};
//            [self presentViewController:loginNav animated:YES completion:nil];
//        }
    }
}



@end
