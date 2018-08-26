//
//  MarketDetailModel.h
//  TongChuanDu
//
//  Created by zhandb on 2018/7/20.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "MarketDetaildataattrbute.h"
#import "MarketDetailDataimg.h"

@protocol MarketDetaildataattrbute
@end

@protocol MarketDetailDataimg
@end

@interface MarketDetailModel : JSONModel


//"" = 198;
// =         (
//);
// =         (
//                   {
//                       path = "http://mayjoy.ezuan.cc/Uploads/2018-08-07/5b696b934ce75.jpg";
//                   }
//                   );
// = "http://mayjoy.ezuan.cc/index.php?s=/Mobile/fuli/goodcontent/id/6.html";
//"" = 0;
//"" = 6;
// = "http://mayjoy.ezuan.cc/Uploads/2018-08-06/5b67f3a874268.png";
//price = "5000.00";
//"sell_num" = 0;
//shareurl = "http://mayjoy.ezuan.cc/index.php?s=/WeChat/Member/center/ucode/0.html";
//stock = 111;
//title = "IPHONE 8";


@property (nonatomic, copy) NSString <Optional> *cover_multi;

/**
 规格
 */
@property (nonatomic, strong) NSArray <MarketDetaildataattrbute> *dataattrbute;

/**
 轮播图
 */
@property (nonatomic, strong) NSArray <MarketDetailDataimg> *dataimg;

/**
 商品id
 */
@property (nonatomic, copy) NSString <Optional> *good_id;

/**
 图片
 */
@property (nonatomic, copy) NSString <Optional> *path;

/**
 价格
 */
@property (nonatomic, copy) NSString <Optional> *price;

/**
 销量
 */
@property (nonatomic, copy) NSString <Optional> *sell_num;

/**
 商品名称
 */
@property (nonatomic, copy) NSString <Optional> *title;

/**
 库存
 */
@property (nonatomic, copy) NSString <Optional> *stock;

/**
 产品参数
 */
@property (nonatomic, copy) NSString <Optional> *spec;

/**
 产品详情
 */
@property (nonatomic, copy) NSString <Optional> *detail;

/**
 运费
 */
@property (nonatomic, copy) NSString <Optional> *express_fee;


/**
 分享
 */
@property (nonatomic, copy) NSString <Optional> *shareurl;


@end
