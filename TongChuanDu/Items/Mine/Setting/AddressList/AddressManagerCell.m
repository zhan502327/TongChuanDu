//
//  AddressManagerCell.m
//  TongChuanDu
//
//  Created by zhandb on 2018/7/13.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "AddressManagerCell.h"

@implementation AddressManagerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)defaultButtonClicked:(id)sender {
}
- (IBAction)editButtonClicked:(id)sender {
}
- (IBAction)deleteButtonClicked:(id)sender {
}

- (void)setModel:(AddressListModel *)model{
    _model = model;
    
    
    _nameLabel.text = model.name;
    
    _mobileLabel.text = model.phone;
    
    _addressLabel.text = [NSString stringWithFormat:@"%@%@%@%@",model.province, model.city, model.area, model.address];
}

@end
