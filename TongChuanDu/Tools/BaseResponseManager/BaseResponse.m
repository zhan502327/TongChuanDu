//
//  BaseResponse.m
//  JianZuLianApp
//
//  Created by 张帅 on 2017/9/12.
//  Copyright © 2017年 JianZuLian. All rights reserved.
//

#import "BaseResponse.h"

@implementation BaseResponse

- (BOOL)isSuccess {
    return _error_code == 0;
}

@end
