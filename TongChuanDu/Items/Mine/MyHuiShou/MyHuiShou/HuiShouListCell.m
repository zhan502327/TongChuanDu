//
//  HuiShouListCell.m
//  TongChuanDu
//
//  Created by zhandb on 2018/7/30.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "HuiShouListCell.h"

@implementation HuiShouListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)lookWuliuButton:(id)sender {
    if (_lookWuLiuBlock) {
        _lookWuLiuBlock();
    }
}

- (void)setModel:(HuiShouListModel *)model{
    _model = model;
    
    _createOrderTimeLabel.text = model.create_time;
    
    [_productImageView sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:UseImage(@"Public_Image_Zheng_PlaceHolder")];
    
    _typeLabel.text = model.spec;
    
    _buyTimeLabel.text = model.buytime;
    
    _useTimeLabel.text = [NSString stringWithFormat:@"%@ 月",model.usingtime];
    
    _oldLabel.text = [NSString stringWithFormat:@"%@",model.hownew];

    if ([model.isrepair isEqualToString:@"1"]) {
        _isServiceLabel.text = @"是";
    }
    
    
    if ([model.isrepair isEqualToString:@"0"]) {
        _isServiceLabel.text = @"否";
    }
    


    
}

@end
