//
//  BankListViewController.h
//  TongChuanDu
//
//  Created by zhandb on 2018/7/18.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "BaseViewController.h"
#import "BnakListModel.h"

@interface BankListViewController : BaseViewController

@property (nonatomic, copy) void(^chooseBankBlock)(BnakListModel *model);

@property (nonatomic, assign) BOOL formTixianVC;

@end
