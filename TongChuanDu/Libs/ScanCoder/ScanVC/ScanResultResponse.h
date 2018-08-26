//
//  ScanResultResponse.h
//  TongChuanDu
//
//  Created by zhandb on 2018/7/22.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "BaseResponse.h"
#import "ScanResultModel.h"
@interface ScanResultResponse : BaseResponse

@property (nonatomic, strong) ScanResultModel <Optional> *result;

@end
