//
//  MarketProductTableViewCell.h
//  TongChuanDu
//
//  Created by zhandb on 2018/7/9.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarketProductTableViewCell : UITableViewCell

@property (nonatomic, strong) NSArray *hotArray;


@property (nonatomic, copy) void(^itemClickedBlock)(NSIndexPath *index);

@end
