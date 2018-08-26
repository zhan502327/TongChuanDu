//
//  AddAddressDefaultCell.h
//  TongChuanDu
//
//  Created by zhandb on 2018/7/18.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddAddressDefaultCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UISwitch *defaultSwitch;

@property (nonatomic, copy) void(^isDefaultSwitchBlock)(BOOL isOn);


@end
