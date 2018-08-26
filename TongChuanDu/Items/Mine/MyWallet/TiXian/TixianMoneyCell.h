//
//  TixianMoneyCell.h
//  TongChuanDu
//
//  Created by zhandb on 2018/8/3.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TixianMoneyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *moneyTextField;
@property (weak, nonatomic) IBOutlet UILabel *myMoneyLabel;

@property (nonatomic, copy) void(^allTixianButtonBlock)();

@end