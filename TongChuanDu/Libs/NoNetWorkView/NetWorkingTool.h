//
//  NetWorkingTool.h
//  JZLLeaseApp
//
//  Created by zhangshuai on 2017/2/24.
//  Copyright © 2017年 zhangshuai. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CHECKNETWORKING [NetWorkingTool shareNetWorkingTool]

@interface NetWorkingTool : NSObject

+ (NetWorkingTool *)shareNetWorkingTool;

- (BOOL)isNetWorkRunning;  //监测网络状态

@end
