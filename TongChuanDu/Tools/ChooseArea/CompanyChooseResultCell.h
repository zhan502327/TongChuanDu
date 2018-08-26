//
//  CompanyChooseResultCell.h
//  JianZuLianApp
//
//  Created by zhang shuai on 2017/11/2.
//  Copyright © 2017年 JianZuLian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityModel.h"


@interface CompanyChooseResultCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;


//选择城市model
@property (nonatomic, strong) CityModel *cityModel;


@end
