//
//  ExtentionViewController.m
//  TongChuanDu
//
//  Created by zhandb on 2018/7/9.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "ExtentionViewController.h"
#import <WebKit/WebKit.h>
#import "ExtentionResponse.h"


@interface ExtentionViewController ()<WKUIDelegate, WKNavigationDelegate>

@property (nonatomic, weak) WKWebView *webView;

@end

@implementation ExtentionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationController.navigationBar.hidden = YES;
    
    [self setNavgiationBarTitle:@"推广"];
    
    [self loadData];

}

- (void)loadData{
    [App_HttpsRequestTool extentionwithSuccess:^(id responseObject) {
        ExtentionResponse *response = [[ExtentionResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response isSuccess]) {
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:response.result.linkurl]]];
        }else{
            PopInfo(response.reason);
        }
    } failure:^(NSError *error) {
        PopError(netError);
    }];
}


#pragma mark -- 懒加载
- (WKWebView *)webView{
    if (_webView == nil) {
        WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, Current_Width, Current_Height)];
        webView.backgroundColor = HexColor(0XFF7800);
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
