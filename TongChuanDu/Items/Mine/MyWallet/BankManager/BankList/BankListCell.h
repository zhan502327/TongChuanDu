//
//  BankListCell.h
//  TongChuanDu
//
//  Created by zhandb on 2018/7/18.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BnakListModel.h"

@interface BankListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UILabel *bankNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bankTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *bankNumLabel;


@property (nonatomic, strong) NSIndexPath *index;
@property (nonatomic, strong) BnakListModel *model;
@end
