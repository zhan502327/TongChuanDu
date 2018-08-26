//
//  MyOrderNormalCell.m
//  TongChuanDu
//
//  Created by zhandb on 2018/8/4.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "MyOrderNormalCell.h"

@implementation MyOrderNormalCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setOrderModel:(MyOrderListModel *)orderModel{
    _orderModel = orderModel;
    
    _statusLabel.text = orderModel.order_status_name;
    
    _timeLabel.text = orderModel.create_time;
    
    
}

- (void)setGoodsModel:(MyOrderListGoods *)goodsModel{
    _goodsModel = goodsModel;
    
    [_productImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",goodsModel.path]] placeholderImage:UseImage(@"Public_Image_Zheng_PlaceHolder")];
    
    
    _productNameLabel.text = goodsModel.title;
    
    _priceLabel.text = [NSString stringWithFormat:@"¥ %@",goodsModel.price];
    
    
}

@end
