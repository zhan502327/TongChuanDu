//
//  MarketListResult.h
//  TongChuanDu
//
//  Created by zhandb on 2018/7/20.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "MarketListHotModel.h"
#import "MarketListNewModel.h"
#import "MarketListCategoryModel.h"

@protocol MarketListHotModel
@end
@protocol MarketListNewModel
@end
@protocol MarketListCategoryModel
@end



@interface MarketListResult : JSONModel

@property (nonatomic, strong) NSArray <MarketListCategoryModel> *category;
@property (nonatomic, strong) NSArray <MarketListHotModel> *hotlist;
@property (nonatomic, strong) NSArray <MarketListNewModel> *newlist;

@end
