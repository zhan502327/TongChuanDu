//
//  MyJifenListResult.h
//  TongChuanDu
//
//  Created by zhandb on 2018/8/3.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "MyJifenListMyPointModel.h"
#import "MyJifenListPointGoodsModel.h"

@protocol MyJifenListPointGoodsModel
@end

@interface MyJifenListResult : JSONModel

@property (nonatomic, strong) MyJifenListMyPointModel <Optional> *mypoint;

@property (nonatomic, strong) NSArray <MyJifenListPointGoodsModel> *pointgoods;

@end
