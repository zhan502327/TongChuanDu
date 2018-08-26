//
//  UserInfoResponse.h
//  TongChuanDu
//
//  Created by zhandb on 2018/7/16.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "BaseResponse.h"
#import "UserInfoModel.h"


@interface UserInfoResponse : BaseResponse


@property (nonatomic, strong) UserInfoModel <Optional> *result;

@end
