//
//  MarketProductCell.m
//  TongChuanDu
//
//  Created by zhandb on 2018/8/5.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "MarketProductCell.h"

@implementation MarketProductCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(MarketProductModel *)model{
    _model = model;
    
    [_productImageView sd_setImageWithURL:[NSURL URLWithString:model.path] placeholderImage:UseImage(@"Public_Image_Zheng_PlaceHolder")];
    
    
    _productNameLabel.text = model.title;
    
    _priceLabel.text = [NSString stringWithFormat:@"¥ %@",model.price];
    
    _sellLabel.text = [NSString stringWithFormat:@"%@人付款",model.sell_num];
    
    
    
}

@end
