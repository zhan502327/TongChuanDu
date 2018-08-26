//
//  WelfareListResponse.h
//  TongChuanDu
//
//  Created by zhandb on 2018/7/30.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "BaseResponse.h"
#import "WelfareListModel.h"

@interface WelfareListResponse : BaseResponse

@property (nonatomic, strong) WelfareListModel <Optional> *result;

@end
