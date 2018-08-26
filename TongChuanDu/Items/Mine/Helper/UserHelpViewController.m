//
//  UserHelpViewController.m
//  TongChuanDu
//
//  Created by zhandb on 2018/8/25.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "UserHelpViewController.h"
#import <WebKit/WebKit.h>

@interface UserHelpViewController ()<WKUIDelegate, WKNavigationDelegate>

@property (nonatomic, weak) WKWebView *webView;

@end

@implementation UserHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavgiationBarTitle:@"使用协议"];
    
    NSString *urlStr = [@"http://mayjoy.ezuan.cc/index.php?s=/mobile/member/xieyi.html" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
    
}


#pragma mark -- 懒加载
- (WKWebView *)webView{
    if (_webView == nil) {
        WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, Current_Width, Current_Height)];
        webView.backgroundColor = [UIColor whiteColor];
        webView.navigationDelegate = self;
        webView.UIDelegate = self;
        //开了支持滑动返回
        webView.allowsBackForwardNavigationGestures = YES;
        [self.view addSubview:webView];
        _webView = webView;
    }
    return _webView;
}


@end
