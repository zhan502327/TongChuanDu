//
//  MarketSureOrderAddress.h
//  TongChuanDu
//
//  Created by zhandb on 2018/8/5.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface MarketSureOrderAddress : JSONModel

//address = "\U554a\U554a\U554a";
//area = 1118;
//city = 103;
//"create_time" = 1533466924;
//id = 13;
//"is_default" = 1;
//name = "\U5566\U5566\U5566\U5566";
//phone = 555;
//postcode = "";
//province = 8;
//street = "";
//"update_time" = 0;
//userid = 6087;

@property (nonatomic, copy) NSString <Optional>*address;
@property (nonatomic, copy) NSString <Optional>*create_time;
@property (nonatomic, copy) NSString <Optional>*is_default;
@property (nonatomic, copy) NSString <Optional>*name;
@property (nonatomic, copy) NSString <Optional>*phone;
@property (nonatomic, copy) NSString <Optional>*userid;
@property (nonatomic, copy) NSString <Optional>*id;
@property (nonatomic, copy) NSString <Optional>*province;
@property (nonatomic, copy) NSString <Optional>*city;
@property (nonatomic, copy) NSString <Optional>*area;


@end
