//
//  AppDelegate+Share.m
//  TongChuanDu
//
//  Created by zhandb on 2018/7/14.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "AppDelegate+Share.h"
#import <UMShare/UMShare.h>
#import <UMCommon/UMCommon.h>



#define kUMShareAppKey @"5b49585db27b0a4c570000dd"

#define kUMShare_WX_AppKey @"wx435e259054eac5c5"
#define kUMShare_WX_AppSecret @"8623899ed3570b8018b2f2a36404b1db"
#define kUMShare_QQ_AppKey @"1107681358"
#define kUMShare_Sina_AppKey @"2059290522"
#define kUMShare_Sina_AppSecret @"b110ceb1ea21930c08a0d8f7b7835715"



@implementation AppDelegate (Share)


#pragma mark -- 注册友盟分享
- (void)register_umengService{
    //    中的”Your AppKey”替换为您在【友盟+】后台申请的应用Appkey（Appkey可在统计后台的 “统计分析->设置->应用信息” 页面查看）。
    
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    
    [UMConfigure initWithAppkey:kUMShareAppKey channel:@"App Store"];

    
    // U-Share 平台设置
    [self configUSharePlatforms];
    [self confitUShareSettings];
    
}


- (void)confitUShareSettings
{
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
    //[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
}

- (void)configUSharePlatforms
{
    
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:kUMShare_WX_AppKey appSecret:kUMShare_WX_AppSecret redirectURL:@"http://mobile.umeng.com/social"];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:kUMShare_QQ_AppKey/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    
    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:kUMShare_Sina_AppKey  appSecret:kUMShare_Sina_AppSecret redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
    
}

// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

@end
