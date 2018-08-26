//
//  HuiShouPublishPhotoCell.h
//  TongChuanDu
//
//  Created by zhandb on 2018/8/5.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HuiShouPublishPhotoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;


@property (nonatomic, copy) void(^commitButtonBlock)();

@end
