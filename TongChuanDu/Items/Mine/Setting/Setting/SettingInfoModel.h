//
//  SettingInfoModel.h
//  TongChuanDu
//
//  Created by zhandb on 2018/7/17.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface SettingInfoModel : JSONModel



@property (nonatomic, copy) NSString <Optional> *avatar;
@property (nonatomic, copy) NSString <Optional> *nickname;
@property (nonatomic, copy) NSString <Optional> *phone;
@property (nonatomic, copy) NSString <Optional> *sex;
@property (nonatomic, copy) NSString <Optional> *uid;



@end
