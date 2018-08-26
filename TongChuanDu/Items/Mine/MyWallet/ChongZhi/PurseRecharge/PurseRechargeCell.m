//
//  PurseRechargeCell.m
//  JianZuLianApp
//
//  Created by 张帅 on 2017/10/24.
//  Copyright © 2017年 JianZuLian. All rights reserved.
//

#import "PurseRechargeCell.h"

@implementation PurseRechargeCell

@synthesize beSelected = _beSelected;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (BOOL)isBeSelected
{
    return _beSelected;
}

- (void)setBeSelected:(BOOL)beSelected
{
    _beSelected = beSelected;
    if (_beSelected) {
        [self.chooseButton setImage:[UIImage imageNamed:@"App_Select_Icon"] forState:UIControlStateNormal];
    }else{
        [self.chooseButton setImage:[UIImage imageNamed:@"App_unSelect_Icon"] forState:UIControlStateNormal];
    }
    
}

- (void)setPurseRechargeCellDictionary:(NSDictionary *)dict {
    
    self.payImageView.image = UseImage(dict[@"image"]);
    self.payTitleLabel.text = dict[@"title"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (IBAction)chooseButtonClicked:(id)sender {
    
    if (_chooseButtonClickBlock) {
        _chooseButtonClickBlock();
    }
    
}
@end
