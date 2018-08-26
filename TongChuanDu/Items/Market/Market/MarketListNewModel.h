//
//  MarketListNewModel.h
//  TongChuanDu
//
//  Created by zhandb on 2018/7/20.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface MarketListNewModel : JSONModel

//"" = 6;
// = "http://mayjoy.ezuan.cc//Uploads/2018-07-17/5b4de5294a064.png";

@property (nonatomic, copy) NSString <Optional> *good_id;
@property (nonatomic, copy) NSString <Optional> *path;


@end
