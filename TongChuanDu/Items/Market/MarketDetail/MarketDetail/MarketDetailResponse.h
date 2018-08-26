//
//  MarketDetailResponse.h
//  TongChuanDu
//
//  Created by zhandb on 2018/7/20.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "BaseResponse.h"
#import "MarketDetailModel.h"

@interface MarketDetailResponse : BaseResponse


@property (nonatomic, strong) MarketDetailModel <Optional> *result;
@end
