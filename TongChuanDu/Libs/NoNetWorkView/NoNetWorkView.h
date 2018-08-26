//
//  NoNetWorkView.h
//  NoNerWorkDemo
//
//  Created by zhangshuai on 2017/4/15.
//  Copyright © 2017年 zhangshuai. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NoNetWorkViewDelegate <NSObject>

@optional
/** 重新加载数据 */
- (void)reloadData;

@end

/** 无网络时展示的view */
@interface NoNetWorkView : UIView

@property (strong, nonatomic) UIImageView *noNetWorkImageView;        //404 网络错误显示
@property (strong, nonatomic) UILabel *noNetWorkPromptTitleLabel;     //404 网络错误文本框
@property (strong, nonatomic) UIButton *noNetWorkPromptTitleButton;   //404 网络错误按钮

@property (nonatomic,weak) id<NoNetWorkViewDelegate> delegate;

@end
