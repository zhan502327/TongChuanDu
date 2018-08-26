//
//  MyJifenListResponse.h
//  TongChuanDu
//
//  Created by zhandb on 2018/8/3.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "BaseResponse.h"
#import "MyJifenListResult.h"

@interface MyJifenListResponse : BaseResponse

@property (nonatomic, strong) MyJifenListResult <Optional> *result;

@end
