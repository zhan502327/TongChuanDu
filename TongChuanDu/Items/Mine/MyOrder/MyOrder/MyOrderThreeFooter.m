//
//  MyOrderThreeFooter.m
//  TongChuanDu
//
//  Created by zhandb on 2018/8/4.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "MyOrderThreeFooter.h"

@implementation MyOrderThreeFooter

// ----- 待收货


- (IBAction)shouhuoButtonClicked:(id)sender {
    if (_shouhuoBlock) {
        _shouhuoBlock();
    }
}

- (IBAction)lookWuliuButtonClicked:(id)sender {
    if (_lookWuliuBlock) {
        _lookWuliuBlock();
    }
}

@end
