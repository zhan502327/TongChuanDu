//
//  MarketListCategoryModel.h
//  TongChuanDu
//
//  Created by zhandb on 2018/7/20.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface MarketListCategoryModel : JSONModel



@property (nonatomic, copy) NSString <Optional> *category_id;
@property (nonatomic, copy) NSString <Optional> *path;
@property (nonatomic, copy) NSString <Optional> *title;

@end
