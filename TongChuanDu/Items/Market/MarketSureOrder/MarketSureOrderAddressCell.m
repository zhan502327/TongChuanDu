//
//  MarketSureOrderAddressCell.m
//  TongChuanDu
//
//  Created by zhandb on 2018/7/28.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "MarketSureOrderAddressCell.h"

@implementation MarketSureOrderAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setSelectAddressModel:(AddressListModel *)selectAddressModel{
    _selectAddressModel = selectAddressModel;
}


- (void)setModel:(MarketSureOrderAddress *)model{
    _model = model;
    
    if (model) {
        
        if (self.selectAddressModel) {
            
            _haveAddressView.hidden = NO;
            _noAddressView.hidden = YES;
            
            _personNameLabel.text = self.selectAddressModel.name;
            
            _mobileLabel.text = self.selectAddressModel.phone;
            
            _addressLabel.text = [NSString stringWithFormat:@"%@%@%@%@",self.selectAddressModel.province, self.selectAddressModel.city, self.selectAddressModel.area, self.selectAddressModel.address];
            
        }else{
            _haveAddressView.hidden = NO;
            _noAddressView.hidden = YES;
            
            _personNameLabel.text = model.name;
            
            _mobileLabel.text = model.phone;
            
            _addressLabel.text = [NSString stringWithFormat:@"%@%@%@%@",model.province, model.city ,model.area, model.address];
        }
        

        
    }else{
        _haveAddressView.hidden = YES;
        _noAddressView.hidden = NO;
    }
}


@end
