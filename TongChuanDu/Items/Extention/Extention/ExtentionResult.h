//
//  ExtentionResult.h
//  TongChuanDu
//
//  Created by zhandb on 2018/8/7.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "ExtentionMyinfoModel.h"

@interface ExtentionResult : JSONModel

@property (nonatomic, strong) ExtentionMyinfoModel <Optional> *myinfo;

@property (nonatomic, copy) NSString <Optional> *linkurl;


@end
