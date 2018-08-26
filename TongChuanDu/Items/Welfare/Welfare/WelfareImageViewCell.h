//
//  WelfareImageViewCell.h
//  TongChuanDu
//
//  Created by zhandb on 2018/7/30.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WelfareListVipsModel.h"

@interface WelfareImageViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *welfareImageView;

@property (nonatomic, strong) WelfareListVipsModel *model;

@end
