//
//  DBMarketDetailSpecSelectModel.h
//  JianZuLianApp
//
//  Created by zhandb on 2018/7/23.
//  Copyright © 2018年 JianZuLian. All rights reserved.
//

#import "JSONModel.h"

@interface DBMarketDetailSpecSelectModel : JSONModel

//attrvalue = "\U767d";
//cover = "http://www.jianzulian.com.cn0";
//"goods_attr_store_id" = 490;
//price = "0.00";
//stock = 0;



@property (nonatomic, copy) NSString <Optional> *attrvalue;
@property (nonatomic, copy) NSString <Optional> *cover;
@property (nonatomic, copy) NSString <Optional> *goods_attr_store_id;
@property (nonatomic, copy) NSString <Optional> *price;
@property (nonatomic, copy) NSString <Optional> *stock;


@end
