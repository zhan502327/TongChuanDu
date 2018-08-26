//
//  MarketOrderCell.m
//  JianZuLianApp
//
//  Created by 张帅 on 2017/10/1.
//  Copyright © 2017年 JianZuLian. All rights reserved.
//

#import "MarketOrderCell.h"

@implementation MarketOrderCell
@synthesize beSelected = _beSelected;
- (BOOL)isBeSelected
{
    return _beSelected;
}

- (void)setBeSelected:(BOOL)beSelected
{
    _beSelected = beSelected;
    if (_beSelected) {
         [self.choosePayButton setImage:[UIImage imageNamed:@"App_Select_Icon"] forState:UIControlStateNormal];
    }else{
    [self.choosePayButton setImage:[UIImage imageNamed:@"App_unSelect_Icon"] forState:UIControlStateNormal];
    }

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
