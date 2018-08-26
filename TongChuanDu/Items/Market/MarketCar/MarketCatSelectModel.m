//
//  MarketCatSelectModel.m
//  TongChuanDu
//
//  Created by zhandb on 2018/7/29.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "MarketCatSelectModel.h"

@implementation MarketCatSelectModel

- (void)setCarModel:(MarketCatModel *)carModel{
    _carModel = carModel;
    
    
    _attrvalueid = carModel.attrvalueid;
    
    _buynum = carModel.buynum;
    
    _express_fee = carModel.express_fee;
    
    _good_store_id = carModel.good_store_id;
    
    _guige = [NSMutableArray arrayWithCapacity:0];
    
    _path = carModel.path;
    
    _price = carModel.price;
    
    _product_sn = carModel.product_sn;
    
    _title = carModel.title;

    
    
}

@end
