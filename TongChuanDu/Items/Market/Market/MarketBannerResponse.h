//
//  MarketBannerResponse.h
//  TongChuanDu
//
//  Created by zhandb on 2018/7/15.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "BaseResponse.h"
#import "MarketBannerModel.h"

@protocol MarketBannerModel
@end

@interface MarketBannerResponse : BaseResponse

@property (nonatomic, strong) NSArray <MarketBannerModel> *result;


@end
