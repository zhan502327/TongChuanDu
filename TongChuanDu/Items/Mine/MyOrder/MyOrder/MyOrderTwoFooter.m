//
//  MyOrderTwoFooter.m
//  TongChuanDu
//
//  Created by zhandb on 2018/8/4.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "MyOrderTwoFooter.h"

@implementation MyOrderTwoFooter

// ----- 待发货

- (IBAction)lookWuLiuButtonClicked:(id)sender {
    if (_lookWuLiuBlock) {
        _lookWuLiuBlock();
    }
}

@end
