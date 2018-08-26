//
//  HuishouPublishButtonCell.m
//  TongChuanDu
//
//  Created by zhandb on 2018/7/30.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "HuishouPublishButtonCell.h"

@implementation HuishouPublishButtonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)yesButtonClicked:(id)sender {
    UIButton *btn = (UIButton *)sender;
    
    
    if (btn.selected == NO) {
        btn.selected = !btn.selected;
        self.noButton.selected = NO;
        
        
        if (_yesButtonBlock) {
            _yesButtonBlock();
        }
    }else{
    }
    

}
- (IBAction)noButtonClicekd:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    
    if (btn.selected == NO) {
        btn.selected = !btn.selected;
        self.yesButton.selected = NO;
        
        
        if (_noButtonBlock) {
            _noButtonBlock();
        }
    }else{
    }

}

@end
