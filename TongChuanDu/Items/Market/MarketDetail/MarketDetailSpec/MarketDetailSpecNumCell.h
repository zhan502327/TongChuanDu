//
//  MarketDetailSpecNumCell.h
//  TongChuanDu
//
//  Created by zhandb on 2018/7/15.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarketDetailSpecNumCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;


@property (nonatomic, copy) void(^ProductNumAddBlock)(NSInteger count);
@property (nonatomic, copy) void(^ProductNumDeleteBlock)(NSInteger count);


@end
