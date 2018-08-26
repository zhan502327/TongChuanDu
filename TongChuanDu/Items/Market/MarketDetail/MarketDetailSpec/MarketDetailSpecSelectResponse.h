//
//  MarketDetailSpecSelectResponse.h
//  JianZuLianApp
//
//  Created by zhandb on 2018/7/23.
//  Copyright © 2018年 JianZuLian. All rights reserved.
//

#import "BaseResponse.h"
#import "DBMarketDetailSpecSelectModel.h"

@interface MarketDetailSpecSelectResponse : BaseResponse

@property (nonatomic, strong) DBMarketDetailSpecSelectModel <Optional> *result;

@end
