//
//  CityResponse.h
//  JianZuLianApp
//
//  Created by 张帅 on 2017/9/16.
//  Copyright © 2017年 JianZuLian. All rights reserved.
//

#import "BaseResponse.h"
#import "CityModel.h"

@protocol CityModel
@end

@interface CityResponse : BaseResponse

@property (strong, nonatomic) NSArray<CityModel> *result;

@end
