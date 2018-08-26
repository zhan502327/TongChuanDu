//
//  MarketImageViewCell.m
//  TongChuanDu
//
//  Created by zhandb on 2018/7/9.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "MarketImageViewCell.h"

@implementation MarketImageViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setModel:(MarketListNewModel *)model{
    _model = model;
    [_productImageView sd_setImageWithURL:[NSURL URLWithString:model.path] placeholderImage:UseImage(@"Public_Image_Long_PlaceHolder")];
}

@end
