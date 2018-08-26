//
//  CompanyChooseResultCell.m
//  JianZuLianApp
//
//  Created by zhang shuai on 2017/11/2.
//  Copyright © 2017年 JianZuLian. All rights reserved.
//

#import "CompanyChooseResultCell.h"

@implementation CompanyChooseResultCell

- (void)setCityModel:(CityModel *)cityModel{
    _cityModel = cityModel;
    _resultLabel.text = cityModel.name;
}

@end
