//
//  CityModel.h
//  JianZuLianApp
//
//  Created by 张帅 on 2017/9/16.
//  Copyright © 2017年 JianZuLian. All rights reserved.
//

#import "JSONModel/JSONModel.h"

@interface CityModel : JSONModel

/** 城市id */
@property (strong, nonatomic) NSString<Optional> *id;
/** 城市名称 */
@property (strong, nonatomic) NSString<Optional> *name;
/** 父名称 */
@property (strong, nonatomic) NSString<Optional> *parent_id;


@end
