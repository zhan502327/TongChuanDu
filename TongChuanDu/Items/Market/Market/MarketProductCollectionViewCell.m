//
//  MarketProductCollectionViewCell.m
//  TongChuanDu
//
//  Created by zhandb on 2018/7/9.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "MarketProductCollectionViewCell.h"

@implementation MarketProductCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(MarketListHotModel *)model{
    _model = model;
    
    [_productImageView sd_setImageWithURL:[NSURL URLWithString:model.path] placeholderImage:UseImage(@"Public_Image_Zheng_PlaceHolder")];
    
    _productNameLabel.text = model.title;
    
    _priceLabel.text = [NSString stringWithFormat:@"¥%@",model.price];
    
    _sellLabel.text = [NSString stringWithFormat:@"%@人付款",model.sell_num];
    
}

@end
