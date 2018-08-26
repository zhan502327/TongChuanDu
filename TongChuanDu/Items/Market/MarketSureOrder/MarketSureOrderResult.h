//
//  MarketSureOrderResult.h
//  TongChuanDu
//
//  Created by zhandb on 2018/8/5.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "MarketSureOrderAddress.h"

@protocol MarketSureOrderAddress
@end

@interface MarketSureOrderResult : JSONModel

@property (nonatomic, strong) NSArray <MarketSureOrderAddress> *address;

@property (nonatomic, copy) NSString <Optional> *sum;


@end
