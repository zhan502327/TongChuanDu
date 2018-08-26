//
//  PageModel.m
//  JianZuLianApp
//
//  Created by 张帅 on 2017/9/12.
//  Copyright © 2017年 JianZuLian. All rights reserved.
//

#import "PageModel.h"

@implementation PageModel

- (BOOL)hasMore {
    
    if (_pageCount == _pageTotal) {
        return YES;
    }else{
        return NO;
    }
}

@end
