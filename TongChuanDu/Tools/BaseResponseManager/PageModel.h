//
//  PageModel.h
//  JianZuLianApp
//
//  Created by 张帅 on 2017/9/12.
//  Copyright © 2017年 JianZuLian. All rights reserved.
//

#import "JSONModel/JSONModel.h"

@interface PageModel : JSONModel

/** 总页数*/
@property (assign, nonatomic) int pageTotal;
/** 当前页*/
@property (assign, nonatomic) int pageCount;
/** 每页返回几条*/
@property (assign, nonatomic) int pageSize;

/** 是否有更多数据*/
- (BOOL)hasMore;

@end
