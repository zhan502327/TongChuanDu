//
//  AppDelegate+PayService.h
//  TongChuanDu
//
//  Created by zhandb on 2018/7/14.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (PayService)


/**
 注册微信支付
 */
- (void)registerWeiXinPay;

/**
 注册支付宝支付
 */
- (void)registerAliPay;
@end
