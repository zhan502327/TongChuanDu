//
//  MyHuiShouViewController.m
//  TongChuanDu
//
//  Created by zhandb on 2018/7/30.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "MyHuiShouViewController.h"
#import "HuiShouListCell.h"
#import "HuiShouResponse.h"
#import "HuiShouPublishViewController.h"

static NSString *huishoucell = @"HuiShouListCell";

@interface MyHuiShouViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation MyHuiShouViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavgiationBarTitle:@"我的回收"];
    
    [self configTableView];
    
    [self configNav];
    
    [self loadData];
}

- (void)configNav{
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(publishButtonClicked)];
    item.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = item;
    
}

- (void)publishButtonClicked{
    
    HuiShouPublishViewController *vc= [[HuiShouPublishViewController alloc] init];
    [vc setRefreshDataAfterPublishBlock:^{
        [self.tableView.mj_header beginRefreshing];
        
    }];
    [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
    
}

- (void)configTableView{
    [self.tableView registerNib:[UINib nibWithNibName:huishoucell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:huishoucell];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       
        [self loadData];
    }];
    
}

- (void)loadData{
    
    [App_HttpsRequestTool myOldPhoneListSuccess:^(id responseObject) {
        
        [self endRefresh];
        HuiShouResponse *respinse = [[HuiShouResponse alloc] initWithDictionary:responseObject error:nil];
        if ([respinse isSuccess]) {
            
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:respinse.result];
            [self.tableView reloadData];
            
        }else{
            
            
        }
        
        [self.tableView setEmptyViewWithArray:self.dataSource withMargin:50 withTitle:nil];
        
    } failure:^(NSError *error) {
        PopError(netError);
        [self endRefresh];

    }];
    
}

- (void)endRefresh{
    [self.tableView.mj_header endRefreshing];
}

#pragma mark - tableView delegate and tableView dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 261;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HuiShouListModel *model = self.dataSource[indexPath.row];
    HuiShouListCell *cell = [tableView dequeueReusableCellWithIdentifier:huishoucell];
    cell.model = model;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //消除cell选择痕迹
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.2];
}

- (void)deselect
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        _dataSource = array;
    }
    return _dataSource;
}




@end
