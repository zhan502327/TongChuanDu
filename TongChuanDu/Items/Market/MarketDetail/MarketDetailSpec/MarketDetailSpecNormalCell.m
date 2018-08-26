//
//  MarketDetailSpecNormalCell.m
//  TongChuanDu
//
//  Created by zhandb on 2018/7/15.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "MarketDetailSpecNormalCell.h"
#import "MarketDetailattrvalue.h"

@interface MarketDetailSpecNormalCell ()

@property (nonatomic, weak) IMJIETagView *tagView;


@end

@implementation MarketDetailSpecNormalCell


- (void)setTagsFrame:(IMJIETagFrame *)tagsFrame{
    _tagsFrame = tagsFrame;
    [self tagView];

}




- (IMJIETagView *)tagView{
    if (_tagView == nil) {
        
//        NSArray *array = @[@"code4app",@"轻音少女",@"花季少女",@"我们仍未知道那天所看见的花的名字",@"华语",@"花有重开日",@"空之境界"];
//        IMJIETagFrame *frame = [[IMJIETagFrame alloc] init];
//        frame.tagsMinPadding = 4;
//        frame.tagsMargin = 10;
//        frame.tagsLineSpacing = 10;
//        frame.tagsArray = array;

    
        IMJIETagView *tagView = [[IMJIETagView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.tagsFrame.tagsHeight)];
        tagView.clickbool = YES;
        tagView.borderSize = 0.5;
        tagView.clickborderSize = 0.5;
        tagView.tagsFrame = self.tagsFrame;
        
        tagView.clickBackgroundColor = HexColor(0XF3C4B7);
        tagView.clickTitleColor = HexColor(0X333333);
        tagView.clickStart = 0;
        //    tagView.clickString = @"华语";//单选  tagView.clickStart 为0
        //        tagView.clickArray = @[@"误解向",@"我们仍未知道那天所看见的花的名字"];//多选 tagView.clickStart 为1
        tagView.delegate = self;
        [self.categoryView addSubview:tagView];
        
        
        _tagView = tagView;
        
    }
    return _tagView;
}

-(void)IMJIETagView:(NSArray *)tagArray{
    
    if (tagArray.count > 0) {
        
        //index  选中第index类别
        NSInteger selectTag = [tagArray[0] integerValue];
        
        if (_selectIndexBlock) {
            _selectIndexBlock(selectTag);
        }
        
    }
}



@end
