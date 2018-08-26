//
//  MarketProductResponse.h
//  TongChuanDu
//
//  Created by zhandb on 2018/8/5.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "BaseResponse.h"
#import "MarketProductPageModel.h"

@interface MarketProductResponse : BaseResponse

@property (nonatomic, strong) MarketProductPageModel <Optional> *result;

@end
