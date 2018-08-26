//
//  MarketImageViewCell.h
//  TongChuanDu
//
//  Created by zhandb on 2018/7/9.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MarketListNewModel.h"

@interface MarketImageViewCell : UITableViewCell

@property (nonatomic, strong) MarketListNewModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;



@end
