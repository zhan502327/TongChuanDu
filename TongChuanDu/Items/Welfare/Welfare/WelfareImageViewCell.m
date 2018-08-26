//
//  WelfareImageViewCell.m
//  TongChuanDu
//
//  Created by zhandb on 2018/7/30.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "WelfareImageViewCell.h"

@implementation WelfareImageViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(WelfareListVipsModel *)model{
    _model = model;
    [_welfareImageView sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:UseImage(@"Public_Image_Zheng_PlaceHolder")];
}

@end
