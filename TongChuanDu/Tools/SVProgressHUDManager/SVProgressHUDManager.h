//
//  SVProgressHUDManager.h
//  JianZuLianApp
//
//  Created by 张帅 on 2017/9/15.
//  Copyright © 2017年 JianZuLian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SVProgressHUDManager : NSObject

#pragma mark - **************** 手动消失
/** Tost 加载中 */
+ (void)popTostLoadingWithString:(NSString *)string;

/** Tost 改变文字内容 */
+ (void)popTostChangeWithString:(NSString *)string;

/** Tost 隐藏 */
+ (void)popTostDismiss;

/** Tost 信息显示 */
+ (void)popTostInfoWithString:(NSString *)string;

#pragma mark - **************** 自动消失 默认不允许用户进行其他用户操作 显示时间为2s
/** Tost 成功 */
+ (void)popTostSuccessWithString:(NSString *)string;

/** Tost 失败 */
+ (void)popTostErrorWithString:(NSString *)string;

@end
