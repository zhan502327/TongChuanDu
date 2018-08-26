//
//  CustomImagePickerViewController.m
//  TongChuanDu
//
//  Created by zhandb on 2018/7/21.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "CustomImagePickerViewController.h"

@interface CustomImagePickerViewController ()

@end

@implementation CustomImagePickerViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (@available(iOS 11.0, *)){//避免滚动视图顶部出现20的空白以及push或者pop的时候页面有一个上移或者下移的异常动画的问题
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    

    [self setNavgiationBarTitle:@"相册"];

    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];

    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
}


// ------NavgiationBar标题
- (void)setNavgiationBarTitle:(NSString *)string {
    
    //主色调
    self.navigationBar.barTintColor = [UIColor clearColor];
    //
    
    self.navigationItem.title = string;
    
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:HexColor(0XFFFFFF),NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Semibold" size:16]};
    
}


@end
