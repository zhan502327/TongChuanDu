//
//  ExtentionResponse.h
//  TongChuanDu
//
//  Created by zhandb on 2018/8/7.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "BaseResponse.h"
#import "ExtentionResult.h"

@interface ExtentionResponse : BaseResponse

@property (nonatomic, strong) ExtentionResult <Optional> *result;

@end
