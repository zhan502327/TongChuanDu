//
//  BankListResponse.h
//  TongChuanDu
//
//  Created by zhandb on 2018/7/23.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "BaseResponse.h"
#import "BnakListModel.h"

@protocol BnakListModel
@end


@interface BankListResponse : BaseResponse

@property (nonatomic, strong) NSArray <BnakListModel> *result;

@end
