//
//  WellfareFirstTableViewCell.h
//  TongChuanDu
//
//  Created by zhandb on 2018/7/29.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WellfareFirstTableViewCell : UITableViewCell

@property (nonatomic, strong) NSArray *hotArray;
@property (nonatomic, strong) NSArray *jifenArray;



@property (nonatomic, copy) void(^itemClickedBlock)(NSIndexPath *index);


@end
