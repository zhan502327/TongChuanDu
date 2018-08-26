//
//  MarketCarCell.m
//  TongChuanDu
//
//  Created by zhandb on 2018/7/14.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "MarketCarCell.h"
#import "MarketCarSpecModel.h"

@implementation MarketCarCell

- (void)setModel:(MarketCatSelectModel *)model{
    _model = model;
    
    
    _selectButton.selected = model.isSelect;
    
    _productNameLabel.text = model.title;
    
    [_logImageView sd_setImageWithURL:[NSURL URLWithString:model.path] placeholderImage:UseImage(@"Public_Image_Zheng_PlaceHolder")];
    
    
    NSString *specStr = @"";
    for (MarketCarSpecModel *specModel in _model.guige) {
        specStr = [specStr stringByAppendingString:[NSString stringWithFormat:@"%@:%@ ",specModel.name, specModel.attrvalue]];
    }
    
    _categoryLabel.text = specStr;
    
    _priceLabel.text = [NSString stringWithFormat:@"¥ %@",model.price];
    
    _numLaebl.text = model.buynum;
    
    
}


- (IBAction)selectButtonClicked:(id)sender {
    UIButton *button = (UIButton *)sender;
    button.selected = !button.selected;
    
    if (_selectButtonBlock) {
        _selectButtonBlock(button.selected);
    }
}
- (IBAction)deleteButtonClicked:(id)sender {
    if (_deleteButtonBlock) {
        _deleteButtonBlock();
    }
}
- (IBAction)reduceBUttonClicked:(id)sender {
    NSInteger count = [self.numLaebl.text integerValue];
    count --;
    
    if(count <= 0){
        return ;
    }
    
    if (_reduceButtonBlock) {
        _reduceButtonBlock(count);
    }
}
- (IBAction)addButtonClicked:(id)sender {
    NSInteger count = [self.numLaebl.text integerValue];
    count ++;
    
    if (_addButtonBlock) {
        _addButtonBlock(count);
    }
}

@end
