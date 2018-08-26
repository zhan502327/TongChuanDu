//
//  BaseResponse.h
//  JianZuLianApp
//
//  Created by 张帅 on 2017/9/12.
//  Copyright © 2017年 JianZuLian. All rights reserved.
//

#import "JSONModel/JSONModel.h"

@interface BaseResponse : JSONModel

/** 错误代码*/
@property (nonatomic, assign) int error_code;
/** 错误原因（不准 --mark）*/ 
@property (nonatomic, strong) NSString *reason;

/** 返回成功*/
- (BOOL)isSuccess;

@end
