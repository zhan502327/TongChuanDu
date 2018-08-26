//
//  MyOrderListGoods.h
//  TongChuanDu
//
//  Created by zhandb on 2018/8/4.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface MyOrderListGoods : JSONModel


/**
 规格型号
 */
@property (nonatomic, copy) NSString <Optional> *attrvalueid;

/**
 数量
 */
@property (nonatomic, copy) NSString <Optional> *count;

/**
 头像
 */
@property (nonatomic, copy) NSString <Optional> *path;

/**
 价钱
 */
@property (nonatomic, copy) NSString <Optional> *price;

/**
 名称
 */
@property (nonatomic, copy) NSString <Optional> *title;



@end
