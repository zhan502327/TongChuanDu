//
//  MyOrderDetailProductCell.h
//  TongChuanDu
//
//  Created by zhandb on 2018/8/4.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrderDetailProductCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *productNameLable;
@property (weak, nonatomic) IBOutlet UILabel *productSpecLabel;
@property (weak, nonatomic) IBOutlet UILabel *productCountLabel;

@end
