//
//  QRCodeModel.h
//  TongChuanDu
//
//  Created by zhandb on 2018/8/13.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface QRCodeModel : JSONModel

@property (nonatomic, copy) NSString <Optional> *code_url;

@end
