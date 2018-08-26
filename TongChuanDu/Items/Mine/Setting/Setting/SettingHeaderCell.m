//
//  SettingHeaderCell.m
//  TongChuanDu
//
//  Created by zhandb on 2018/7/12.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "SettingHeaderCell.h"

@implementation SettingHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClicked)];
    [_headerImageView addGestureRecognizer:tap];
    
}

- (void)imageViewClicked{
    if (_headerImageBlock) {
        _headerImageBlock();
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
