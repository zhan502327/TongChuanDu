//
//  MyOrderOneFooter.m
//  TongChuanDu
//
//  Created by zhandb on 2018/8/4.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "MyOrderOneFooter.h"

@implementation MyOrderOneFooter

// ----- 待付款

- (IBAction)payButtonClicked:(id)sender {
    if (_goPayBlock) {
        _goPayBlock();
    }
}

@end
