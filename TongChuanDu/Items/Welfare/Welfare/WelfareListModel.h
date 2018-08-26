//
//  WelfareListModel.h
//  TongChuanDu
//
//  Created by zhandb on 2018/7/30.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "WelfareListBannerModel.h"
#import "WelfareListPointGoodsModel.h"
#import "WelfareListVipsModel.h"
#import "WelfareListYouhuiModel.h"


@protocol WelfareListBannerModel
@end

@protocol WelfareListPointGoodsModel
@end

@protocol WelfareListVipsModel
@end

@protocol WelfareListYouhuiModel
@end

@interface WelfareListModel : JSONModel

@property (nonatomic, strong) NSArray <WelfareListBannerModel> *banner;
@property (nonatomic, strong) NSArray <WelfareListPointGoodsModel> *pointgoods;
@property (nonatomic, strong) NSArray <WelfareListVipsModel> *vips;
@property (nonatomic, strong) NSArray <WelfareListYouhuiModel> *youhuiquan;

@end
