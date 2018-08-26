//
//  SVProgressHUDManager.m
//  JianZuLianApp
//
//  Created by 张帅 on 2017/9/15.
//  Copyright © 2017年 JianZuLian. All rights reserved.
//

#import "SVProgressHUDManager.h"
#import "SVProgressHUD.h"

@implementation SVProgressHUDManager

#pragma mark - **************** 手动消失
+ (void)popTostLoadingWithString:(NSString *)string {
    
    [SVProgressHUD showWithStatus:string];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
}

+ (void)popTostChangeWithString:(NSString *)string {
    
    [SVProgressHUD setStatus:string];
}

+ (void)popTostDismiss {
    
    [SVProgressHUD dismiss];
}

+ (void)popTostInfoWithString:(NSString *)string {
    
    [SVProgressHUD showInfoWithStatus:string];
    [SVProgressHUD dismissWithDelay:1.0f];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
}

#pragma mark - **************** 自动消失 默认不允许用户进行其他用户操作 显示时间为2s
+ (void)popTostSuccessWithString:(NSString *)string {
    
    [SVProgressHUD showSuccessWithStatus:string];
    [SVProgressHUD dismissWithDelay:2.0f];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
}

+ (void)popTostErrorWithString:(NSString *)string {
    
    [SVProgressHUD showErrorWithStatus:string];
    [SVProgressHUD dismissWithDelay:2.0f];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
}

@end
