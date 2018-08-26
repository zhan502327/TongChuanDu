//
//  WelfareViewController.m
//  TongChuanDu
//
//  Created by zhandb on 2018/7/9.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "WelfareViewController.h"
#import "SDCycleScrollView.h"
#import "WelfatreHeader.h"
#import "WelfareMoreHeader.h"
#import "WelfareImageViewCell.h"
#import "WellfareFirstTableViewCell.h"
#import "WelfareListResponse.h"
#import "WelfareDetailViewController.h"
#import "WelfareWebViewViewController.h"

#define kGAP (10)
#define kItemWidth ((Current_Width - 3*kGAP)/2)
#define kItemHeight (100)


#define kCycleViewHeight 124


static NSString *firstTableViewCell = @"WellfareFirstTableViewCell";
static NSString *imageViewCell = @"WelfareImageViewCell";

@interface WelfareViewController ()<SDCycleScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *bannerView;
@property (weak, nonatomic) IBOutlet UIImageView *firstImageView;
@property (weak, nonatomic) IBOutlet UIImageView *secondImageView;
@property (weak, nonatomic) IBOutlet UIImageView *thirdImaegeView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) NSMutableArray *bannerArray;
@property (nonatomic, strong) NSMutableArray *typeArray;


@property (nonatomic, weak) SDCycleScrollView *cycleView;


@end

@implementation WelfareViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.cycleView adjustWhenControllerViewWillAppera];
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavgiationBarTitle:@"福利"];
    
    [self configTbaleView];
    
    [self loadData];
}

- (void)loadData{
    
    [App_HttpsRequestTool welfareListwithSuccess:^(id responseObject) {
        [self endRefresh];

        WelfareListResponse *respinse = [[WelfareListResponse alloc] initWithDictionary:responseObject error:nil];
        if ([respinse isSuccess]) {
            [self.bannerArray removeAllObjects];
            [self.typeArray removeAllObjects];
            [self.dataSource removeAllObjects];
        
            [self.bannerArray addObjectsFromArray:respinse.result.banner];
            NSMutableArray *bannerImageUrlArray = [NSMutableArray arrayWithCapacity:0];
            for (WelfareListBannerModel *bannerModel in self.bannerArray) {
                
                [bannerImageUrlArray addObject:bannerModel.cover];
                
            }
            
            self.cycleView.imageURLStringsGroup = bannerImageUrlArray;
            
            
            [self.typeArray addObjectsFromArray:respinse.result.youhuiquan];
            for (int i = 0; i<self.typeArray.count; i++) {
                if (i == 0) {
                    WelfareListYouhuiModel *model = self.typeArray[i];
                    [self.firstImageView sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:UseImage(@"Public_Image_Zheng_PlaceHolder")];
                    
                }
                
                if (i == 1) {
                    WelfareListYouhuiModel *model = self.typeArray[i];
                    [self.secondImageView sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:UseImage(@"Public_Image_Zheng_PlaceHolder")];
                    
                }
                
                if (i == 2) {
                    WelfareListYouhuiModel *model = self.typeArray[i];
                    [self.thirdImaegeView sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:UseImage(@"Public_Image_Zheng_PlaceHolder")];
                    
                }
            }
            [self.dataSource addObject:respinse.result.pointgoods];
            [self.dataSource addObject:respinse.result.vips];
            
            [self.tableView reloadData];
            
        }else{
            PopError(respinse.reason);
        }
        
        [self.tableView setEmptyViewWithArray:self.dataSource withMargin:50 withTitle:@""];
        
        
    } failure:^(NSError *error) {
        PopError(netError);
        [self endRefresh];
    }];
    
}

- (void)endRefresh{
    [self.tableView.mj_header endRefreshing];
}

- (void)configTbaleView{
    
    [self.tableView registerNib:[UINib nibWithNibName:firstTableViewCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:firstTableViewCell];
    
    [self.tableView registerNib:[UINib nibWithNibName:imageViewCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:imageViewCell];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];

}


#pragma mark - tableView delegate and tableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else{
        return [self.dataSource[section] count];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NSUInteger itemCount = [self.dataSource[indexPath.section] count];
        
        CGFloat tem = (itemCount / 2);
        
        NSInteger row = ceilf(tem);
        
        if (row == 0) {
            return 0;
        }else{
            return (row * kItemHeight + (row + 1)*kGAP);
        }
    }else{
        return 150;
        
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NSArray *hotArray = self.dataSource[indexPath.section];
        WellfareFirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:firstTableViewCell];
        cell.hotArray = hotArray;
        
        [cell setItemClickedBlock:^(NSIndexPath *index) {
            
            WelfareListPointGoodsModel *model = self.dataSource[indexPath.section][index.row];
            
            WelfareDetailViewController *vc = [[WelfareDetailViewController alloc] init];
            vc.goods_id = model.good_id;
            [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
            
        }];
        return cell;
    }else{
        WelfareListVipsModel *model = self.dataSource[indexPath.section][indexPath.row];
        WelfareImageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:imageViewCell];
        cell.model = model;
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //消除cell选择痕迹
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.2];
    
    
    
    if (indexPath.section == 1) {
        WelfareListVipsModel *model = self.dataSource[indexPath.section][indexPath.row];

        WelfareWebViewViewController *vc = [[WelfareWebViewViewController alloc] init];
        vc.model = model;
        [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
        
        
    }
 
}

- (void)deselect
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}
//HeaderInSection  &&  FooterInSection

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        WelfatreHeader *header = [[[NSBundle mainBundle] loadNibNamed:@"WelfatreHeader" owner:nil options:nil] lastObject];
        return header;
        
    }else{
        WelfareMoreHeader *header = [[[NSBundle mainBundle] loadNibNamed:@"WelfareMoreHeader" owner:nil options:nil] lastObject];
        return header;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = HexColor(0XF5F5F5);
    return backView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        _dataSource = array;
    }
    return _dataSource;
}

- (NSMutableArray *)bannerArray{
    if (_bannerArray == nil) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        _bannerArray = array;
    }
    return _bannerArray;
}

- (NSMutableArray *)typeArray{
    if (_typeArray == nil) {
        NSMutableArray *arrau = [NSMutableArray arrayWithCapacity:0];
        _typeArray = arrau;
    }
    return _typeArray;
}

- (SDCycleScrollView *)cycleView{
    if (_cycleView == nil) {
        SDCycleScrollView *view = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, Current_Width, kCycleViewHeight) delegate:self placeholderImage:[UIImage imageNamed:@"Public_Image_Long_PlaceHolder"]];
        view.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        [self.bannerView addSubview:view];
        _cycleView = view;
        
    }
    return _cycleView;
}

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    
}

@end
