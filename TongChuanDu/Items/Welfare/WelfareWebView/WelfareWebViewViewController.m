//
//  WelfareWebViewViewController.m
//  TongChuanDu
//
//  Created by zhandb on 2018/8/25.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "WelfareWebViewViewController.h"
#import <WebKit/WebKit.h>



@interface WelfareWebViewViewController ()<WKUIDelegate, WKNavigationDelegate>

@property (nonatomic, weak) WKWebView *webView;

@end

@implementation WelfareWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavgiationBarTitle:@"福利详情"];
    
    NSString *urlStr = [self.model.linkurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

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
