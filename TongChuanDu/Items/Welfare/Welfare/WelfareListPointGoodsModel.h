//
//  WelfareListPointGoodsModel.h
//  TongChuanDu
//
//  Created by zhandb on 2018/7/30.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface WelfareListPointGoodsModel : JSONModel

//cover = "http://mayjoy.ezuan.cc/Uploads/2018-08-06/5b67f3638c88d.png";
//"good_id" = 1;
//needpoint = 100;
//title = "IPHONE 7";

@property (nonatomic, copy) NSString <Optional> *cover;
@property (nonatomic, copy) NSString <Optional> *needpoint;
@property (nonatomic, copy) NSString <Optional> *title;
@property (nonatomic, copy) NSString <Optional> *good_id;

@end
