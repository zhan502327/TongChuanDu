//
//  QRCodeResponse.h
//  TongChuanDu
//
//  Created by zhandb on 2018/8/13.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "BaseResponse.h"
#import "QRCodeModel.h"

@interface QRCodeResponse : BaseResponse

@property (nonatomic, strong) QRCodeModel <Optional> *result;

@end
