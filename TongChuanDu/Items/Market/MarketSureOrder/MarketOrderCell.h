//
//  MarketOrderCell.h
//  JianZuLianApp
//
//  Created by 张帅 on 2017/10/1.
//  Copyright © 2017年 JianZuLian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarketOrderCell : UITableViewCell

/** 支付图标 */
@property (weak, nonatomic) IBOutlet UIImageView *payImageView;
/** 支付方式 */
@property (weak, nonatomic) IBOutlet UILabel *payTitleLabel;
/** 支付内容 */
@property (weak, nonatomic) IBOutlet UILabel *payContentLabel;
/** 选择框 */
@property (weak, nonatomic) IBOutlet UIButton *choosePayButton;


@property (assign,nonatomic) BOOL beSelected;

@end
