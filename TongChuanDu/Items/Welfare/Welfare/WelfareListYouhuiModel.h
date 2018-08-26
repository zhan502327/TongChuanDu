//
//  WelfareListYouhuiModel.h
//  TongChuanDu
//
//  Created by zhandb on 2018/7/30.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface WelfareListYouhuiModel : JSONModel

//cover = "http://image.huajiao.com/eeb9aeb845c541d8a3c2f06f6580f0b5-100_100.jpg";
//linkurl = "https://www.baidu.com/";


@property (nonatomic, copy) NSString <Optional> *cover;
@property (nonatomic, copy) NSString <Optional> *linkurl;
@end
