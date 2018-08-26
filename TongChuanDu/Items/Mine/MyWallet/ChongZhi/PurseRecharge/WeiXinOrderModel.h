//
//  WeiXinOrderModel.h
//  JianZuLianApp
//
//  Created by 张帅 on 2017/10/13.
//  Copyright © 2017年 JianZuLian. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface WeiXinOrderModel : JSONModel



/** 微信注册id */
@property (strong, nonatomic) NSString<Optional> *appid;
/** 商家向财付通申请的商家id */
@property (strong, nonatomic) NSString<Optional> *partnerid;
/** 预支付订单 */
@property (strong, nonatomic) NSString<Optional> *prepayid;
/** 随机串，防重发 */
@property (strong, nonatomic) NSString<Optional> *noncestr;
/** 时间戳，防重发 */
@property (strong, nonatomic) NSString<Optional> *timestamp;
/** 商家根据财付通文档填写的数据和签名 */
@property (strong, nonatomic) NSString<Optional> *package;
/** 商家根据微信开放平台文档对数据做的签名 */
@property (strong, nonatomic) NSString<Optional> *sign;

@end
