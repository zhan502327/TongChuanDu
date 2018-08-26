//
//  HuiShouListModel.h
//  TongChuanDu
//
//  Created by zhandb on 2018/7/30.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface HuiShouListModel : JSONModel

//buytime = "2018-7-2";
//cover = "/Uploads/2018-07-29/5b5db9d484838.jpg";
//"create_time" = "2018-07-29 20:57:56";
//hownew = 0;
//isrepair = 1;
//storage = 255;
//usingtime = 127;


@property (nonatomic, copy) NSString <Optional> *buytime;
@property (nonatomic, copy) NSString <Optional> *cover;
@property (nonatomic, copy) NSString <Optional> *create_time;
@property (nonatomic, copy) NSString <Optional> *hownew;
@property (nonatomic, copy) NSString <Optional> *isrepair;
@property (nonatomic, copy) NSString <Optional> *storage;
@property (nonatomic, copy) NSString <Optional> *usingtime;
@property (nonatomic, copy) NSString <Optional> *spec;



@end
