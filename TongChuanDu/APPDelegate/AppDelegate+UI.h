//
//  AppDelegate+UI.h
//  TongChuanDu
//
//  Created by zhandb on 2018/7/9.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (UI)


/**
 注册tabbar和nav
 */
- (void)registerRootVC;

//注册根视图
- (void)relinkToRootVC;



/**
 更新app
 */
- (void)updateAppVersion;


@end
