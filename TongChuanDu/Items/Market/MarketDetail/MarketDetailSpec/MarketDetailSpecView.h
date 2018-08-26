//
//  MarketDetailSpecView.h
//  TongChuanDu
//
//  Created by zhandb on 2018/7/15.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MarketDetailModel.h"

@interface MarketDetailSpecView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *specLable;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *saveLabel;

@property (nonatomic, strong) MarketDetailModel *productModel;

@property (nonatomic, strong) NSArray *specArray;

@property (nonatomic, copy) NSString *goods_id;
@property (weak, nonatomic) IBOutlet UIView *bottomViewTwo;

@property (weak, nonatomic) IBOutlet UIView *bottomViewOne;
@property (weak, nonatomic) IBOutlet UIButton *finishButton;
@property (weak, nonatomic) IBOutlet UIButton *addCarButton;
@property (weak, nonatomic) IBOutlet UIButton *nowBuyButton;

/**
 底部按钮点击事件
 finishButtonNowBuy -- //立即购买

 finishButtonAddCar -- //加入购物车

 twoButton -- //选择规格

 */
@property (nonatomic, copy) NSString *bottomButtonClickedType;


/**
 
 */
@property (nonatomic, copy) void(^nowBuyButtonBlock)(NSString *goods_attr_store_id, NSString *attrvalue_id, NSString *selectNumStr, NSString *price);

@end
