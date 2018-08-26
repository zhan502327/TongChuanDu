//
//  MarketCarResponse.h
//  TongChuanDu
//
//  Created by zhandb on 2018/7/28.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "BaseResponse.h"
#import "MarketCatModel.h"

@protocol MarketCatModel
@end



@interface MarketCarResponse : BaseResponse

@property (nonatomic, strong) NSArray <MarketCatModel> *result;

@end
