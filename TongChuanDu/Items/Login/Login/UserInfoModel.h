//
//  UserInfoModel.h
//  TongChuanDu
//
//  Created by zhandb on 2018/7/16.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface UserInfoModel : JSONModel



@property (nonatomic, copy) NSString <Optional> *avatar;
@property (nonatomic, copy) NSString <Optional> *uid;
@property (nonatomic, copy) NSString <Optional> *pid;
@property (nonatomic, copy) NSString <Optional> *username;
@property (nonatomic, copy) NSString <Optional> *usertype;




@end
