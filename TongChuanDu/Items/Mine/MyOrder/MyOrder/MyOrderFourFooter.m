//
//  MyOrderFourFooter.m
//  TongChuanDu
//
//  Created by zhandb on 2018/8/4.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "MyOrderFourFooter.h"

@implementation MyOrderFourFooter



// ----- 交易完成


- (IBAction)lookOrderButtonClicekd:(id)sender {
    if (_lookOrderBlock) {
        _lookOrderBlock();
    }
}

@end
