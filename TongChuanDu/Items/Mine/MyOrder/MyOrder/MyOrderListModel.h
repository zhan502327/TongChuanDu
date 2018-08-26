//
//  MyOrderListModel.h
//  TongChuanDu
//
//  Created by zhandb on 2018/8/4.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "MyOrderListGoods.h"

@protocol MyOrderListGoods
@end

@interface MyOrderListModel : JSONModel



@property (nonatomic, copy) NSString <Optional> *add_power_status;
@property (nonatomic, copy) NSString <Optional> *address;
@property (nonatomic, copy) NSString <Optional> *area;
@property (nonatomic, copy) NSString <Optional> *city;

/**
 时间
 */
@property (nonatomic, copy) NSString <Optional> *create_time;
@property (nonatomic, copy) NSString <Optional> *express_name;
@property (nonatomic, copy) NSString <Optional> *express_no;
@property (nonatomic, strong) NSArray <MyOrderListGoods> *goods;
@property (nonatomic, copy) NSString <Optional> *ids;
@property (nonatomic, copy) NSString <Optional> *name;
@property (nonatomic, copy) NSString <Optional> *no;

/**
 订单号
 */
@property (nonatomic, copy) NSString <Optional> *order_no;
@property (nonatomic, copy) NSString <Optional> *pay_no;
@property (nonatomic, copy) NSString <Optional> *pay_result;
@property (nonatomic, copy) NSString <Optional> *pay_status;
@property (nonatomic, copy) NSString <Optional> *pay_type;
@property (nonatomic, copy) NSString <Optional> *phone;
@property (nonatomic, copy) NSString <Optional> *pnum;
@property (nonatomic, copy) NSString <Optional> *postcode;
@property (nonatomic, copy) NSString <Optional> *province;
@property (nonatomic, copy) NSString <Optional> *remark;
@property (nonatomic, copy) NSString <Optional> *send_status;
@property (nonatomic, copy) NSString <Optional> *sort;
@property (nonatomic, copy) NSString <Optional> *status;
@property (nonatomic, copy) NSString <Optional> *street;
@property (nonatomic, copy) NSString <Optional> *total;
@property (nonatomic, copy) NSString <Optional> *update_time;
@property (nonatomic, copy) NSString <Optional> *use_score;
@property (nonatomic, copy) NSString <Optional> *userid;
@property (nonatomic, copy) NSString <Optional> *order_status_name;
@property (nonatomic, copy) NSString <Optional> *order_status;





@end
