//
//  MarketCarCell.h
//  TongChuanDu
//
//  Created by zhandb on 2018/7/14.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MarketCatSelectModel.h"

@interface MarketCarCell : UITableViewCell

@property (nonatomic, strong) MarketCatSelectModel *model;

@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (weak, nonatomic) IBOutlet UIImageView *logImageView;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLaebl;

@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;



@property (nonatomic, copy) void(^selectButtonBlock)(BOOL isSelect);
@property (nonatomic, copy) void(^deleteButtonBlock)(void);
@property (nonatomic, copy) void(^addButtonBlock)(NSInteger count);
@property (nonatomic, copy) void(^reduceButtonBlock)(NSInteger count);



@end
