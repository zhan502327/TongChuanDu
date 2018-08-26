//
//  HuiShouListCell.h
//  TongChuanDu
//
//  Created by zhandb on 2018/7/30.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HuiShouListModel.h"

@interface HuiShouListCell : UITableViewCell
@property (nonatomic, strong) HuiShouListModel *model;

@property (nonatomic, copy) void(^lookWuLiuBlock)();

/**
 订单生成时间
 */
@property (weak, nonatomic) IBOutlet UILabel *createOrderTimeLabel;


@property (weak, nonatomic) IBOutlet UIImageView *productImageView;

/**
 手机型号
 */
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

/**
 购买时间
 */
@property (weak, nonatomic) IBOutlet UILabel *buyTimeLabel;

/**
 使用时间
 */
@property (weak, nonatomic) IBOutlet UILabel *useTimeLabel;

/**
 几成新
 */
@property (weak, nonatomic) IBOutlet UILabel *oldLabel;

/**
 是否维修过
 */
@property (weak, nonatomic) IBOutlet UILabel *isServiceLabel;

@end
