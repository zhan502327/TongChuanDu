//
//  MyMalletResponse.h
//  TongChuanDu
//
//  Created by zhandb on 2018/8/3.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "BaseResponse.h"
#import "MyWalletModel.h"

@interface MyMalletResponse : BaseResponse

@property (nonatomic, strong) MyWalletModel <Optional> *result;

@end
