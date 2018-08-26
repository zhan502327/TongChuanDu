//
//  MarketProductPageModel.h
//  TongChuanDu
//
//  Created by zhandb on 2018/8/5.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "MarketProductModel.h"

@protocol MarketProductModel
@end

@interface MarketProductPageModel : PageModel

@property (nonatomic, strong) NSArray <MarketProductModel> *items;

@end
