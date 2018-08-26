//
//  MarketSureOrderResponse.h
//  TongChuanDu
//
//  Created by zhandb on 2018/8/5.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "BaseResponse.h"
#import "MarketSureOrderResult.h"

@interface MarketSureOrderResponse : BaseResponse

@property (nonatomic, strong) MarketSureOrderResult <Optional> *result;

@end
