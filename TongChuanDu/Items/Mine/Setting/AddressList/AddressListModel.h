//
//  AddressListModel.h
//  TongChuanDu
//
//  Created by zhandb on 2018/7/17.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface AddressListModel : JSONModel



@property (nonatomic, copy) NSString <Optional> *name;
@property (nonatomic, copy) NSString <Optional> *phone;
@property (nonatomic, copy) NSString <Optional> *province;
@property (nonatomic, copy) NSString <Optional> *city;
@property (nonatomic, copy) NSString <Optional> *area;
@property (nonatomic, copy) NSString <Optional> *address;
@property (nonatomic, copy) NSString <Optional> *is_default;
@property (nonatomic, copy) NSString <Optional> *address_id;




@end
