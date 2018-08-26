//
//  WeiXinOrderResponse.h
//  JianZuLianApp
//
//  Created by 张帅 on 2017/10/13.
//  Copyright © 2017年 JianZuLian. All rights reserved.
//

#import "BaseResponse.h"
#import "WeiXinOrderModel.h"

@interface WeiXinOrderResponse : BaseResponse

@property (nonatomic, strong) WeiXinOrderModel<Optional> *result;

@end
