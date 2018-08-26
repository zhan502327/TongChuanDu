//
//  WellfareFirstTableViewCell.m
//  TongChuanDu
//
//  Created by zhandb on 2018/7/29.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "WellfareFirstTableViewCell.h"
#import "WelfareItemCell.h"
#import "WelfareListPointGoodsModel.h"
#import "MyJifenListPointGoodsModel.h"

#define kGAP (10)
#define kItemWidth ((Current_Width - 3*kGAP)/2)
#define kItemHeight (100)

static NSString *itemCell = @"WelfareItemCell";

@interface WellfareFirstTableViewCell() <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak) UICollectionView *collcetionView;
@end

@implementation WellfareFirstTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.collcetionView registerNib:[UINib nibWithNibName:itemCell bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:itemCell];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

- (void)setHotArray:(NSArray *)hotArray{
    _hotArray = hotArray;
    
    CGFloat tem = (hotArray.count / 2);
    
    NSInteger row = ceilf(tem);
    
    CGFloat height = row == 0 ? 0 : ((row * kItemHeight + (row + 1)*kGAP));
    
    self.collcetionView.frame = CGRectMake(0, 0, Current_Width, height);
    
    [self.collcetionView reloadData];

}
//MyJifenListMyPointModel

- (void)setJifenArray:(NSArray *)jifenArray{
    _jifenArray = jifenArray;
    
    
    CGFloat tem = (jifenArray.count / 2);
    
    NSInteger row = ceilf(tem);
    
    CGFloat height = row == 0 ? 0 : ((row * kItemHeight + (row + 1)*kGAP));
    
    self.collcetionView.frame = CGRectMake(0, 0, Current_Width, height);
    
    [self.collcetionView reloadData];
}


-(UICollectionView *)collcetionView{
    if (_collcetionView == nil) {
        UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc] init];
        layOut.scrollDirection = UICollectionViewScrollDirectionVertical;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Current_Width, 0) collectionViewLayout:layOut];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.scrollEnabled  = NO;
        collectionView.backgroundColor = [UIColor redColor];
        layOut.minimumInteritemSpacing = 0;
        layOut.minimumLineSpacing = kGAP;//这个控制每个item的间隔
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.showsHorizontalScrollIndicator = NO;
        [self.contentView addSubview:collectionView];
        _collcetionView = collectionView;
    }
    return _collcetionView;
}

#pragma mark - collectionView delegate and collectionView dataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.hotArray.count > 0) {
        return self.hotArray.count;
    }
    
    if (self.jifenArray.count > 0) {
        return self.jifenArray.count;
    }
    return 0;
}

//告知每个块item应该有多大
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake( kItemWidth, kItemHeight);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    WelfareItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:itemCell forIndexPath:indexPath];
    
    if (self.hotArray.count > 0) {
        WelfareListPointGoodsModel *model = self.hotArray[indexPath.row];
        cell.model = model;
    }
    
    if (self.jifenArray.count > 0) {
        MyJifenListPointGoodsModel *jifenModel = self.jifenArray[indexPath.row];
        cell.jifenModel = jifenModel;
    }
    

    return cell;
    
    
}

//设置偏移
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(kGAP, kGAP, kGAP, kGAP);//这个控制collectionView距离其父类的上、左、下、右边距
}
//点击调用
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"第%lu组 第%lu个", (long)indexPath.section, (long)indexPath.row);
    if (_itemClickedBlock) {
        _itemClickedBlock(indexPath);
    }
}


@end
