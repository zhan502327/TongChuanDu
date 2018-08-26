//
//  MyJifenViewController.m
//  TongChuanDu
//
//  Created by zhandb on 2018/8/3.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "MyJifenViewController.h"
#import "WellfareFirstTableViewCell.h"
#import "WelfatreHeader.h"
#import "MyJifenFooter.h"
#import "MyJifenListResponse.h"
#import "MyJifenListMyPointModel.h"
#import "WelfareDetailViewController.h"

#define kGAP (10)
#define kItemWidth ((Current_Width - 3*kGAP)/2)
#define kItemHeight (100)

static NSString *firstTableViewCell = @"WellfareFirstTableViewCell";


@interface MyJifenViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *jiFenLbabel;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) MyJifenListMyPointModel *myPointModel;

@end

@implementation MyJifenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavgiationBarTitle:@"我的积分"];
    
    [self configTableView];
    
    [self loadData];
    
}

-(void)loadData{
    
    [App_HttpsRequestTool myJiFenListSuccess:^(id responseObject) {
        [self endRefresh];
        
        MyJifenListResponse *respinse = [[MyJifenListResponse alloc] initWithDictionary:responseObject error:nil];
        if ([respinse isSuccess]) {
            self.myPointModel = respinse.result.mypoint;
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:respinse.result.pointgoods];
            [self.tableView reloadData];
        }else{
            
            PopInfo(respinse.reason);
            
        }
        
    } failure:^(NSError *error) {
        [self endRefresh];

        PopError(netError);
    }];
    
    
}

- (void)endRefresh{
    [self.tableView.mj_header endRefreshing];
}

- (void)configTableView{
    
    [self.tableView registerNib:[UINib nibWithNibName:firstTableViewCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:firstTableViewCell];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       
        [self loadData];
    }];
}

#pragma mark - tableView delegate and tableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger itemCount = [self.dataSource count];
    
    CGFloat tem = (itemCount / 2);
    
    NSInteger row = ceilf(tem);
    
    if (row == 0) {
        return 0;
    }else{
        return (row * kItemHeight + (row + 1)*kGAP);
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    WellfareFirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:firstTableViewCell];
    
    cell.jifenArray = self.dataSource;
    
    [cell setItemClickedBlock:^(NSIndexPath *index) {
       
        MyJifenListPointGoodsModel *model = self.dataSource[index.row];
        
        WelfareDetailViewController *vc = [[WelfareDetailViewController alloc] init];
        vc.goods_id = model.good_id;
        [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
        
        
    }];
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //消除cell选择痕迹
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.2];
}

- (void)deselect
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}
//HeaderInSection  &&  FooterInSection

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    WelfatreHeader *header = [[[NSBundle mainBundle] loadNibNamed:@"WelfatreHeader" owner:nil options:nil] lastObject];
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    MyJifenFooter *header = [[[NSBundle mainBundle] loadNibNamed:@"MyJifenFooter" owner:nil options:nil] lastObject];
    
    [header setQiandaoButtonBlock:^{
        
        [self confirmQianDao];
        
    }];
    return header;
}

#pragma mark -- 签到
- (void)confirmQianDao{
    
    PopLoading(nil);
    [App_HttpsRequestTool qiandaoSuccess:^(id responseObject) {
        PopDismiss;
        BaseResponse *response = [[BaseResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response isSuccess]) {
            
            PopSuccess(@"签到成功");
            
            [self.tableView.mj_header beginRefreshing];
            
        }else{
            PopInfo(response.reason);
        }
        
        
        
        
    } failure:^(NSError *error) {
        PopDismiss;
        PopError(netError);
    }];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 50;
}

- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        _dataSource = array;
    }
    return _dataSource;
}


@end
