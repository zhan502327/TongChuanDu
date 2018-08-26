//
//  SettingHeaderCell.h
//  TongChuanDu
//
//  Created by zhandb on 2018/7/12.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingHeaderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;

@property (nonatomic, copy) void(^headerImageBlock)();

@end

