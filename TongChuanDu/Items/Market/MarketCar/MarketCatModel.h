//
//  MarketCatModel.h
//  TongChuanDu
//
//  Created by zhandb on 2018/7/28.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "MarketCarSpecModel.h"

@protocol MarketCarSpecModel
@end

@interface MarketCatModel : JSONModel




/**
 规格id字符串
 */
@property (nonatomic, copy) NSString <Optional> *attrvalueid;

/**
 购买数量
 */
@property (nonatomic, copy) NSString <Optional> *buynum;

/**
 运费
 */
@property (nonatomic, copy) NSString <Optional> *express_fee;
@property (nonatomic, copy) NSString <Optional> *good_store_id;
@property (nonatomic, strong) NSArray <MarketCarSpecModel> *guige;

/**
 图片
 */
@property (nonatomic, copy) NSString <Optional> *path;

/**
 单价
 */
@property (nonatomic, copy) NSString <Optional> *price;
@property (nonatomic, copy) NSString <Optional> *product_sn;

/**
 商品名称
 */
@property (nonatomic, copy) NSString <Optional> *title;


@end
