//
//  AddAddressDefaultCell.m
//  TongChuanDu
//
//  Created by zhandb on 2018/7/18.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "AddAddressDefaultCell.h"

@implementation AddAddressDefaultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)defaultSwitchClicked:(id)sender {
    UISwitch *swith = (UISwitch *)sender;
    
    if (_isDefaultSwitchBlock) {
        _isDefaultSwitchBlock(swith.isOn);
    }
}

@end
