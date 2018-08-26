//
//  TixianMoneyCell.m
//  TongChuanDu
//
//  Created by zhandb on 2018/8/3.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "TixianMoneyCell.h"

@implementation TixianMoneyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)allTixianButtonCLicked:(id)sender {
    if (_allTixianButtonBlock) {
        _allTixianButtonBlock();
    }
}

@end
