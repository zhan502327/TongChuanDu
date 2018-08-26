//
//  MarketDetaildataattrbute.h
//  TongChuanDu
//
//  Created by zhandb on 2018/7/20.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "MarketDetailattrvalue.h"

@protocol MarketDetailattrvalue
@end

@interface MarketDetaildataattrbute : JSONModel

//(
// {
//     "attr_id" = 1;
//     attrvalue =                 (
//                                  {
//                                      attrvalue = "5.5";
//                                      "attrvalue_id" = 60;
//                                  },
//                                  {
//                                      attrvalue = "4.2";
//                                      "attrvalue_id" = 59;
//                                  }
//                                  );
//     name = "\U5185\U5b58";
// },
// {
//     "attr_id" = 2;
//     attrvalue =                 (
//                                  {
//                                      attrvalue = yy;
//                                      "attrvalue_id" = 61;
//                                  }
//                                  );
//     name = "\U8d39\U7387";
// },
// {
//     "attr_id" = 3;
//     attrvalue =                 (
//                                  {
//                                      attrvalue = "\U767d";
//                                      "attrvalue_id" = 63;
//                                  },
//                                  {
//                                      attrvalue = "\U9ed1";
//                                      "attrvalue_id" = 62;
//                                  },
//                                  {
//                                      attrvalue = "\U91d1";
//                                      "attrvalue_id" = 64;
//                                  }
//                                  );
//     name = "\U989c\U8272";
// }
// );


/**
 属性id
 */
@property (nonatomic, copy) NSString <Optional> *attr_id;

@property (nonatomic, strong) NSArray <MarketDetailattrvalue> *attrvalue;

@property (nonatomic, copy) NSString <Optional> *name;


@end
