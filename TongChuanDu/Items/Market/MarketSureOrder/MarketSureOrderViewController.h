//
//  MarketSureOrderViewController.h
//  TongChuanDu
//
//  Created by zhandb on 2018/8/5.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "BaseViewController.h"

@interface MarketSureOrderViewController : BaseViewController

@property (nonatomic, copy) NSString *price_num;//价格_数量 | 价格_数量

@property (nonatomic, strong) NSArray *selectedArray;//从购物车过来 支付


// --------- 从商品详情过来  单件商品
//商品ids    商品id例如id=”3,4”
@property (nonatomic, copy) NSString *ids;


//buynum   购买数量，例如：buynum=”3,2”
@property (nonatomic, copy) NSString *buynum;

//attrvalueid    商品规格
@property (nonatomic, copy) NSString *attrvalueid;



@end
