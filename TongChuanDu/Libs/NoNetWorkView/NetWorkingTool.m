//
//  NetWorkingTool.m
//  JZLLeaseApp
//
//  Created by zhangshuai on 2017/2/24.
//  Copyright © 2017年 zhangshuai. All rights reserved.
//

#import "NetWorkingTool.h"
#import "Reachability.h"

@implementation NetWorkingTool

+ (NetWorkingTool *)shareNetWorkingTool {
    
    static NetWorkingTool *shareNetWorkingToolManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareNetWorkingToolManager = [[self alloc] init];
    });
    return shareNetWorkingToolManager;
}

//监测网络状态
- (BOOL)isNetWorkRunning {
    
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            break;
    }
    
    return isExistenceNetwork;
}

@end
