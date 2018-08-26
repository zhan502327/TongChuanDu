//
//  WelfareItemCell.m
//  TongChuanDu
//
//  Created by zhandb on 2018/7/29.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "WelfareItemCell.h"

@implementation WelfareItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(WelfareListPointGoodsModel *)model{
    _model = model;
//    @property (weak, nonatomic) IBOutlet UIImageView *logImageView;
//    @property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//    @property (weak, nonatomic) IBOutlet UILabel *priceLabel;
//    _
    
    
    [_logImageView sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:UseImage(@"Public_Image_Zheng_PlaceHolder")];
    
    _titleLabel.text = model.title;
    
    _priceLabel.text = model.needpoint;
}

- (void)setJifenModel:(MyJifenListPointGoodsModel *)jifenModel{
    _jifenModel = jifenModel;
    
    [_logImageView sd_setImageWithURL:[NSURL URLWithString:jifenModel.cover] placeholderImage:UseImage(@"Public_Image_Zheng_PlaceHolder")];
    
    _titleLabel.text = jifenModel.title;
    
    _priceLabel.text = jifenModel.needpoint;

}

@end
