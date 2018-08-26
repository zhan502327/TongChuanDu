//
//  MarketProductModel.h
//  TongChuanDu
//
//  Created by zhandb on 2018/8/5.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface MarketProductModel : JSONModel

@property (nonatomic, copy) NSString <Optional> *good_id;
@property (nonatomic, copy) NSString <Optional> *path;
@property (nonatomic, copy) NSString <Optional> *price;
@property (nonatomic, copy) NSString <Optional> *sell_num;
@property (nonatomic, copy) NSString <Optional> *title;


@end
