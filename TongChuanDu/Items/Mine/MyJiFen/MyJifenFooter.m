//
//  MyJifenFooter.m
//  TongChuanDu
//
//  Created by zhandb on 2018/8/3.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "MyJifenFooter.h"

@implementation MyJifenFooter

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)qiandaoButtonClicekd:(id)sender {
    if (_qiandaoButtonBlock) {
        _qiandaoButtonBlock();
    }
}

@end
