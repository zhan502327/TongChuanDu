//
//  MarketDetailSpecNumCell.m
//  TongChuanDu
//
//  Created by zhandb on 2018/7/15.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "MarketDetailSpecNumCell.h"

@implementation MarketDetailSpecNumCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)addButtonClicked:(id)sender {
    
    NSInteger count = [self.numLabel.text integerValue];
    count ++;
    
    if (_ProductNumAddBlock) {
        _ProductNumAddBlock(count);
    }
    
}
- (IBAction)deleteButtonClicked:(id)sender {
    
    
    NSInteger count = [self.numLabel.text integerValue];
    count --;
    
    if(count <= 0){
        return ;
    }
    
    if (_ProductNumDeleteBlock) {
        _ProductNumDeleteBlock(count);
    }
    
}

@end
