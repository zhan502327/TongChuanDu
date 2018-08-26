//
//  MarketDetailParameter.h
//  TongChuanDu
//
//  Created by zhandb on 2018/7/21.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarketDetailParameter : UIView

@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (nonatomic, copy) void(^parameterBttonBlock)();

@end
