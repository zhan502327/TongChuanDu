//
//  AddBankFooter.m
//  TongChuanDu
//
//  Created by zhandb on 2018/7/23.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "AddBankFooter.h"

@implementation AddBankFooter

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)nextButtonCLicked:(id)sender {
    
    if (_nextButtonBlock) {
        _nextButtonBlock();
    }
    
}

@end
