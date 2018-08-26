//
//  MyOrderThreeFooter.h
//  TongChuanDu
//
//  Created by zhandb on 2018/8/4.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrderThreeFooter : UIView

// ----- 待收货

@property (nonatomic, copy) void(^shouhuoBlock)();

@property (nonatomic, copy) void(^lookWuliuBlock)();

@end
