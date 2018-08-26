//
//  MarketDetailSpecNormalCell.h
//  TongChuanDu
//
//  Created by zhandb on 2018/7/15.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMJIETagView.h"


@interface MarketDetailSpecNormalCell : UITableViewCell<IMJIETagViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *categoryView;

@property (nonatomic, strong) IMJIETagFrame *tagsFrame;

@property (nonatomic, copy) void(^selectIndexBlock)(NSInteger selectTag);

@end
