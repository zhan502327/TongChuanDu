//
//  MarketListResponse.h
//  TongChuanDu
//
//  Created by zhandb on 2018/7/20.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "BaseResponse.h"
#import "MarketListResult.h"




@interface MarketListResponse : BaseResponse


@property (nonatomic, strong) MarketListResult <Optional> *result;


@end
