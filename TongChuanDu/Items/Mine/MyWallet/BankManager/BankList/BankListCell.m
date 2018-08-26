//
//  BankListCell.m
//  TongChuanDu
//
//  Created by zhandb on 2018/7/18.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "BankListCell.h"

@implementation BankListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(BnakListModel *)model{
    _model = model;
    
    _bankNameLabel.text = model.bank;
    if (model.account.length > 4) {
        _bankNumLabel.text = [Utility bankCardToAsterisk:model.account];

    }else{
        _bankNumLabel.text = model.account;
    }
    
    
    _backImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"My_Wallet_List_BG_%ld",(self.index.row % 3)]];
}

@end
