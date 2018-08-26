//
//  NoNetWorkView.m
//  NoNerWorkDemo
//
//  Created by zhangshuai on 2017/4/15.
//  Copyright © 2017年 zhangshuai. All rights reserved.
//

#import "NoNetWorkView.h"
#import "Reachability.h"

@implementation NoNetWorkView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        //创建无网络占位图
        [self setJzlNoNetWorkViewUI];
    }
    return self;
}

- (void)setJzlNoNetWorkViewUI {
    
    self.backgroundColor = [UIColor whiteColor];
    
    //404 图片放在正中间位置
    self.noNetWorkImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 160, 160)];
    self.noNetWorkImageView.center = CGPointMake(Current_Width / 2, Current_Height / 2 - 100);
    self.noNetWorkImageView.image = UseImage(@"App_NoNetWork_Icon");
    self.noNetWorkImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.noNetWorkImageView];
    
    //无网络状态提示语
    self.noNetWorkPromptTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 20)];
    self.noNetWorkPromptTitleLabel.backgroundColor = [UIColor whiteColor];
    self.noNetWorkPromptTitleLabel.center = CGPointMake(Current_Width / 2, Current_Height / 2);
    self.noNetWorkPromptTitleLabel.text = @"您的网络好像不太给力，请稍后再试";
    self.noNetWorkPromptTitleLabel.font = [UIFont systemFontOfSize:16.0f];
    self.noNetWorkPromptTitleLabel.textAlignment = 1;
    self.noNetWorkPromptTitleLabel.textColor = HexColor(0X999999);
    [self addSubview:self.noNetWorkPromptTitleLabel];

    //重新加载按钮
    self.noNetWorkPromptTitleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.noNetWorkPromptTitleButton.frame = CGRectMake(0, 0, 160, 30);
    self.noNetWorkPromptTitleButton.backgroundColor = HexColor(0X4189F6);
    self.noNetWorkPromptTitleButton.center = CGPointMake(Current_Width / 2, Current_Height / 2 + 50);
    [self.noNetWorkPromptTitleButton setTitle:@"重新加载" forState:UIControlStateNormal];
    [self.noNetWorkPromptTitleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.noNetWorkPromptTitleButton addTarget:self action:@selector(noNetWorkPromptTitleButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.noNetWorkPromptTitleButton.layer.cornerRadius = 5.0f;
    [self addSubview:self.noNetWorkPromptTitleButton];
}

/** 重新查看按钮点击 */
- (void)noNetWorkPromptTitleButtonClick {
    
    if ([self isNetWorkRunning]) {
        
        //如果有网，view消失
        for (NoNetWorkView *view in [self getCurrentViewController:self].view.subviews) {
    
            if ([view isMemberOfClass:[NoNetWorkView class]]) {
                
                [view removeFromSuperview];
            }
            
            //重新加载数据
            if ([self.delegate respondsToSelector:@selector(reloadData)]) {
                [self.delegate reloadData];
            }
        }
    }else{
        
        //如果没网，toast提示
        [SVProgressHUDManager popTostInfoWithString:netError];
    }
}

//获取当前屏幕显示的viewcontroller 的父 view
- (UIViewController *)getCurrentParintViewController {
    
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }else{
            
        }
    }
    return nil;
}

#pragma mark -- 获取当前view的viewcontroller
- (UIViewController *)getCurrentViewController:(UIView *)currentView {
    
    for (UIView *next = [currentView superview]; next; next = next.superview) {
        
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (BOOL)isNetWorkRunning {
    
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            break;
    }
    
    return isExistenceNetwork;
}

@end
