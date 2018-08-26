//
//  HomeImageModel.h
//  TongChuanDu
//
//  Created by zhandb on 2018/8/3.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface HomeImageModel : JSONModel

//backimg = "http://mayjoy.ezuan.cc/uploads/2018-07-29/11da220051ee3eff8c2339c32b39a833.jpg";
//leftimg = "http://mayjoy.ezuan.cc/uploads/comment-attachment/551d0efac287f79a22a417bee9946319.jpg";
//rightimg = "http://mayjoy.ezuan.cc/uploads/comment-attachment/ce47c69f16eb888adbee10ab9ebc42c3.jpg";

@property (nonatomic, copy) NSString <Optional> *backimg;
@property (nonatomic, copy) NSString <Optional> *leftimg;
@property (nonatomic, copy) NSString <Optional> *rightimg;

@end
