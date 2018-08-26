//
//  MyOrderOneFooter.h
//  TongChuanDu
//
//  Created by zhandb on 2018/8/4.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrderOneFooter : UIView

// ----- 待付款
@property (nonatomic, copy) void(^goPayBlock)();

@end
