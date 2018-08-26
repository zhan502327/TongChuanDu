//
//  HuiShouPublishPhotoCell.m
//  TongChuanDu
//
//  Created by zhandb on 2018/8/5.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "HuiShouPublishPhotoCell.h"

@implementation HuiShouPublishPhotoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)commitButtonCLicekd:(id)sender {
    if (_commitButtonBlock) {
        _commitButtonBlock();
    }
}

@end
