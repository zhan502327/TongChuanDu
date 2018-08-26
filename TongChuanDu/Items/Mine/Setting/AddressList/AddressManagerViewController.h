//
//  AddressManagerViewController.h
//  TongChuanDu
//
//  Created by zhandb on 2018/7/13.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "BaseViewController.h"
#import "AddressListModel.h"

@interface AddressManagerViewController : BaseViewController


@property (nonatomic, assign) BOOL fromSureOrderVC;

@property (nonatomic, copy) void(^selectAddressModelBlock)(AddressListModel *addressModel);

@end
