//
//  MyWalletModel.h
//  TongChuanDu
//
//  Created by zhandb on 2018/8/3.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface MyWalletModel : JSONModel



@property (nonatomic, copy) NSString <Optional> *balance;
@property (nonatomic, copy) NSString <Optional> *bank;
@property (nonatomic, copy) NSString <Optional> *bank_id;

@end
