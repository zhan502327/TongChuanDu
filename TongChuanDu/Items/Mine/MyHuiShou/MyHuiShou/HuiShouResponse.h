//
//  HuiShouResponse.h
//  TongChuanDu
//
//  Created by zhandb on 2018/7/30.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "BaseResponse.h"
#import "HuiShouListModel.h"

@protocol HuiShouListModel
@end

@interface HuiShouResponse : BaseResponse

@property (nonatomic, strong) NSArray <HuiShouListModel> *result;

@end
