//
//  MarketCatSelectModel.h
//  TongChuanDu
//
//  Created by zhandb on 2018/7/29.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "MarketCatModel.h"



@interface MarketCatSelectModel : JSONModel

@property (nonatomic, strong) MarketCatModel *carModel;


@property (nonatomic, assign) BOOL isSelect;


/**
 规格id字符串
 */
@property (nonatomic, copy) NSString *attrvalueid;

/**
 购买数量
 */
@property (nonatomic, copy) NSString *buynum;

/**
 运费
 */
@property (nonatomic, copy) NSString  *express_fee;

@property (nonatomic, copy) NSString  *good_store_id;

@property (nonatomic, strong) NSMutableArray  *guige;

/**
 图片
 */
@property (nonatomic, copy) NSString *path;

/**
 单价
 */
@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *product_sn;

/**
 商品名称
 */
@property (nonatomic, copy) NSString *title;


@end
