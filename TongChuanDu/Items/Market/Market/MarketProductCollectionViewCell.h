//
//  MarketProductCollectionViewCell.h
//  TongChuanDu
//
//  Created by zhandb on 2018/7/9.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MarketListHotModel.h"

@interface MarketProductCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) MarketListHotModel *model;


@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *sellLabel;

@end
