//
//  DBMarketDetailModel.h
//  JianZuLianApp
//
//  Created by zhandb on 2018/7/22.
//  Copyright © 2018年 JianZuLian. All rights reserved.
//

#import "JSONModel.h"
#import "MarketDetaildataattrbute.h"
#import "MarketDetailDataimg.h"

@protocol MarketDetaildataattrbute
@end

@interface DBMarketDetailModel : JSONModel


@property (nonatomic, copy) NSString <Optional> *cover_multi;
@property (nonatomic, strong) NSArray <MarketDetaildataattrbute> *dataattrbute;
@property (nonatomic, strong) NSArray <MarketDetailDataimg *> *dataimg;
@property (nonatomic, copy) NSString <Optional> *good_id;
@property (nonatomic, copy) NSString <Optional> *path;
@property (nonatomic, copy) NSString <Optional> *price;
@property (nonatomic, copy) NSString <Optional> *sell_num;
@property (nonatomic, copy) NSString <Optional> *title;

@end
