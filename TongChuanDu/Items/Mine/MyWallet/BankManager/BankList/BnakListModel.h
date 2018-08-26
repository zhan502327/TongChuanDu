//
//  BnakListModel.h
//  TongChuanDu
//
//  Created by zhandb on 2018/7/23.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface BnakListModel : JSONModel



@property (nonatomic, copy) NSString <Optional> *account;
@property (nonatomic, copy) NSString <Optional> *bank;
@property (nonatomic, copy) NSString <Optional> *card_id;

@end
