//
//  MarketCarSpecModel.h
//  TongChuanDu
//
//  Created by zhandb on 2018/7/28.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface MarketCarSpecModel : JSONModel



/**
 规格值
 */
@property (nonatomic, copy) NSString <Optional> *attrvalue;

/**
 类别
 */
@property (nonatomic, copy) NSString <Optional> *name;
@end
