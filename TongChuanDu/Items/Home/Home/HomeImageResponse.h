//
//  HomeImageResponse.h
//  TongChuanDu
//
//  Created by zhandb on 2018/8/3.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "BaseResponse.h"
#import "HomeImageModel.h"

@interface HomeImageResponse : BaseResponse

@property (nonatomic, strong) HomeImageModel <Optional> *result;

@end
