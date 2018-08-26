//
//  MyOrderListPageModel.h
//  TongChuanDu
//
//  Created by zhandb on 2018/8/4.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "PageModel.h"
#import "MyOrderListModel.h"

@protocol MyOrderListModel
@end

@interface MyOrderListPageModel : PageModel

@property (nonatomic, strong) NSArray <MyOrderListModel> *data;



@end
