//
//  PurseRechargeCell.h
//  JianZuLianApp
//
//  Created by 张帅 on 2017/10/24.
//  Copyright © 2017年 JianZuLian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PurseRechargeCell : UITableViewCell

/** 支付图标 */
@property (weak, nonatomic) IBOutlet UIImageView *payImageView;
/** 支付方式 */
@property (weak, nonatomic) IBOutlet UILabel *payTitleLabel;
/** 是否选中 */
@property (weak, nonatomic) IBOutlet UIButton *chooseButton;
@property (nonatomic, copy) void(^chooseButtonClickBlock)();

- (void)setPurseRechargeCellDictionary:(NSDictionary *)dict;
@property (assign,nonatomic) BOOL beSelected;
@end
