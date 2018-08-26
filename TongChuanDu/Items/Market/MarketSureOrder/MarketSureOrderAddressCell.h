//
//  MarketSureOrderAddressCell.h
//  TongChuanDu
//
//  Created by zhandb on 2018/7/28.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MarketSureOrderAddress.h"
#import "AddressListModel.h"

@interface MarketSureOrderAddressCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;
@property (weak, nonatomic) IBOutlet UIView *haveAddressView;
@property (weak, nonatomic) IBOutlet UILabel *personNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *mobileLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIView *noAddressView;

@property (nonatomic, strong) MarketSureOrderAddress *model;

@property (nonatomic, strong) AddressListModel *selectAddressModel;

@end
