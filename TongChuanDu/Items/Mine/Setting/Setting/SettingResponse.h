//
//  SettingResponse.h
//  TongChuanDu
//
//  Created by zhandb on 2018/7/17.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "BaseResponse.h"
#import "SettingInfoModel.h"

@interface SettingResponse : BaseResponse

@property (nonatomic, strong) SettingInfoModel <Optional> *result;


@end
