//
//  NetWorkingPopManager.h
//  JZLLeaseApp
//
//  Created by zhangshuai on 2017/2/27.
//  Copyright © 2017年 zhangshuai. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CN_TEXT_FONT_KEY @"CN_TEXT_FONT_KEY"

#define CN_TEXT_COLOR_KEY @"CN_TEXT_COLOR_KEY"

#define CN_DELAY_SECOND_KEY @"CN_DELAY_SECOND_KEY"

#define CN_BACKGROUND_COLOR_KEY @"CN_BACKGROUND_COLOR_KEY"

typedef void(^CNCompleteBlock)();

@interface NetWorkingPopManager : NSObject

@property (nonatomic) CGFloat delaySeconds; //延迟几秒消失
@property (nonatomic,strong) UIFont *textFont;
@property (nonatomic,strong) UIColor *textColor;
@property (nonatomic,strong) UIColor *backgroundColor;
@property (nonatomic,copy) CNCompleteBlock completeBlock;

+ (instancetype)shareManager;
+ (void)setOptions:(NSDictionary *)options;
+ (void)showMessage:(NSString *)message;
+ (void)showMessage:(NSString *)message withOptions:(NSDictionary *)options;
+ (void)showMessage:(NSString *)message withOptions:(NSDictionary *)options completeBlock:(void(^)())completeBlock;

@end
