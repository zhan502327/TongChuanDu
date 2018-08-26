//
//  MarketListHotModel.h
//  TongChuanDu
//
//  Created by zhandb on 2018/7/20.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface MarketListHotModel : JSONModel



@property (nonatomic, copy) NSString <Optional> *good_id;
@property (nonatomic, copy) NSString <Optional> *path;
@property (nonatomic, copy) NSString <Optional> *price;
@property (nonatomic, copy) NSString <Optional> *sell_num;
@property (nonatomic, copy) NSString <Optional> *title;


@end
