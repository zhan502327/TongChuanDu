//
//  WelfareItemCell.h
//  TongChuanDu
//
//  Created by zhandb on 2018/7/29.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WelfareListPointGoodsModel.h"
#import "MyJifenListPointGoodsModel.h"

@interface WelfareItemCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *logImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (nonatomic, strong) WelfareListPointGoodsModel *model;
@property (nonatomic, strong) MyJifenListPointGoodsModel *jifenModel;

@end
