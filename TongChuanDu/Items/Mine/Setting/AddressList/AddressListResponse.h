//
//  AddressListResponse.h
//  TongChuanDu
//
//  Created by zhandb on 2018/7/17.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "BaseResponse.h"
#import "AddressListModel.h"
@protocol AddressListModel
@end

@interface AddressListResponse : BaseResponse

@property (nonatomic, strong) NSArray <AddressListModel> *result;

@end
