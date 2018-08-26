//
//  MyOrderListResponse.h
//  TongChuanDu
//
//  Created by zhandb on 2018/8/4.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "BaseResponse.h"
#import "MyOrderListPageModel.h"

@interface MyOrderListResponse : BaseResponse

@property (nonatomic, strong) MyOrderListPageModel <Optional> *result;

@end
