//
//  DBMarketDetailSpecResponse.h
//  JianZuLianApp
//
//  Created by zhandb on 2018/7/22.
//  Copyright © 2018年 JianZuLian. All rights reserved.
//

#import "BaseResponse.h"
#import "DBMarketDetailModel.h"

@interface DBMarketDetailSpecResponse : BaseResponse

@property (nonatomic, strong) DBMarketDetailModel <Optional> *result;

@end
