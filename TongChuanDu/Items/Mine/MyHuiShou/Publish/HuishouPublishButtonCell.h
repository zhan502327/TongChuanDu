//
//  HuishouPublishButtonCell.h
//  TongChuanDu
//
//  Created by zhandb on 2018/7/30.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HuishouPublishButtonCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLaebl;
@property (weak, nonatomic) IBOutlet UIButton *yesButton;
@property (weak, nonatomic) IBOutlet UIButton *noButton;

@property (nonatomic, copy) void(^yesButtonBlock)();
@property (nonatomic, copy) void(^noButtonBlock)();

@end
