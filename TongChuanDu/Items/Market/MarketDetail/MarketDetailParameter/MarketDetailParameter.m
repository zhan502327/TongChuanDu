//
//  MarketDetailParameter.m
//  TongChuanDu
//
//  Created by zhandb on 2018/7/21.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "MarketDetailParameter.h"



@interface MarketDetailParameter ()




@property (nonatomic, strong) NSMutableArray *dataSource;


@end


@implementation MarketDetailParameter


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self = [[[NSBundle mainBundle] loadNibNamed:@"MarketDetailParameter" owner:self options:nil] lastObject];
        
        self.frame = frame;
    
        
    }
    return self;
}





- (IBAction)sureButtonCLicked:(id)sender {
    if (_parameterBttonBlock) {
        _parameterBttonBlock();
    }
}

@end
