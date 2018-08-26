//
//  ChongzhiViewController.h
//  TongChuanDu
//
//  Created by zhandb on 2018/8/3.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "BaseViewController.h"

@interface ChongzhiViewController : BaseViewController

/** 充值类型 money:钱包充值 deposit:保证金充值 */
@property (strong, nonatomic) NSString *rechargeType;

@end
