//
//  ChooseCityViewController.h
//  TongChuanDu
//
//  Created by zhandb on 2018/7/18.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "BaseViewController.h"
#import "CityModel.h"

@interface ChooseCityViewController : BaseViewController

//1 - 省  2 - 市  3 - 区
@property (nonatomic, copy) NSString *type;


//省市区model  下个页面传值
@property (nonatomic, strong) CityModel *provinceModel;
@property (nonatomic, strong) CityModel *cityModel;
@property (nonatomic, strong) CityModel *areaModel;


@end
