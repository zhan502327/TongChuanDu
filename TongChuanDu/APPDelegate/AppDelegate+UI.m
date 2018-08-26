//
//  AppDelegate+UI.m
//  TongChuanDu
//
//  Created by zhandb on 2018/7/9.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "AppDelegate+UI.h"
#import "IQKeyboardManager.h"
#import "TabBarViewController.h"


#define kStoreAppId @"1425551373"

@implementation AppDelegate (UI)

- (void)registerRootVC{
    // ------设置全局键盘位置监听
    [[IQKeyboardManager sharedManager] setToolbarManageBehaviour:IQAutoToolbarByPosition];
    // ------设置点击背景收回键盘
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    // ------设置启动图 显示时间
    [NSThread sleepForTimeInterval:2.0];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    // ------修改状态栏颜色为白色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    // ------配置根视图
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self relinkToRootVC];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
}



- (void)relinkToRootVC{
    
    TabBarViewController *rootTabBarVC = [[TabBarViewController alloc] init];
    self.window.rootViewController = rootTabBarVC;
    
//    if ([App_UserManager isLogin] && [[App_UserManager getIdentifystatus] isEqualToNumber:@(1)] && [[App_UserManager getShopstatus] isEqualToNumber:@(1)]) {
//
//        TabBarViewController *rootTabBarVC = [[TabBarViewController alloc] init];
//        self.window.rootViewController = rootTabBarVC;
//
//    }else{
//        DBLoginViewController *vc = [[DBLoginViewController alloc] init];
//
//        BaseNavViewController *childController = [[BaseNavViewController alloc] initWithRootViewController:vc];
//
//        self.window.rootViewController = childController;
//    }
//
    
    
}


/**
 更新app
 */

- (void)updateAppVersion{

    [self shareAppVersionAlertWithUpdate:YES];
}

- (void)shareAppVersionAlertWithUpdate:(BOOL)update {

    //App内info.plist文件里面版本号
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = infoDict[@"CFBundleShortVersionString"];
    //    NSString *bundleId   = infoDict[@"CFBundleIdentifier"];
    NSString *urlString = [NSString stringWithFormat:@"https://itunes.apple.com/cn/lookup?id=%@", kStoreAppId];
    //两种请求appStore最新版本app信息 通过bundleId与appleId判断
    //[NSString stringWithFormat:@"https://itunes.apple.com/cn/lookup?bundleid=%@", bundleId]
    //[NSString stringWithFormat:@"https://itunes.apple.com/cn/lookup?id=%@", appleid]
    NSURL *urlStr = [NSURL URLWithString:urlString];
    //创建请求体
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:urlStr];
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (connectionError) {
            return ;
        }
        NSError *error;
        NSDictionary *resultsDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        if (error) {
            return;
        }
        NSArray *sourceArray = resultsDict[@"results"];
        if (sourceArray.count >= 1) {
            //AppStore内最新App的版本号
            NSDictionary *sourceDict = sourceArray[0];
            NSString *newVersion = sourceDict[@"version"];
            if ([self judgeNewVersion:newVersion withOldVersion:appVersion])
            {
                NSString *tips;
                if (update == YES) {//强制更新
                    tips = @"退出";
                }else{
                    tips = @"暂不更新";
                }
                
                UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示:\n您的App不是最新版本，请问是否更新" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action1 = [UIAlertAction actionWithTitle:tips style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    if (update == YES) {
                        exit(0);
                    }
                }];
                [alertVc addAction:action1];
                UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"去更新" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                    //跳转到AppStore，该App下载界面
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:sourceDict[@"trackViewUrl"]]];
                }];
                [alertVc addAction:action2];
                [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:alertVc animated:YES completion:nil];
            }
        }
    }];
    
}

// --------版本号必须为三位数
//判断当前app版本和AppStore最新app版本大小//
- (BOOL)judgeNewVersion:(NSString *)newVersion withOldVersion:(NSString *)oldVersion {
    NSArray *newArray = [newVersion componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"."]];
    NSArray *oldArray = [oldVersion componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"."]];
    
    NSUInteger count = (newArray.count > oldArray.count) ? (oldArray.count) : (newArray.count);
    
    for (NSUInteger i = 0; i < count; i++) {
        if ([newArray[i] intValue] > [oldArray[i] intValue]) {
            return YES;
        } else {
            
        }
    }
    return NO;
}



@end
