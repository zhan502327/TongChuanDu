//
//  BankListViewController.m
//  TongChuanDu
//
//  Created by zhandb on 2018/7/18.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "BankListViewController.h"
#import "BankListCell.h"
#import "AddBankViewController.h"
#import "BankListResponse.h"


static NSString *banklistCell = @"BankListCell";

@interface BankListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation BankListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavgiationBarTitle:@"我的银行卡"];
    
    [self configTableView];
    
    [self configNav];
    
    [self loadData];
    
}

- (void)loadData{
    
    [App_HttpsRequestTool bankListwithSuccess:^(id responseObject) {
        
        BankListResponse *response = [[BankListResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response isSuccess]) {
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:response.result];
            [self.tableView reloadData];
            
        }
        [self.tableView setEmptyViewWithArray:self.dataSource withMargin:0 withTitle:@"请添加银行卡"];
        
    } failure:^(NSError *error) {
        [SVProgressHUDManager popTostErrorWithString:netError];
    }];
    
}

- (void)configNav{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addBUttonClicked)];
    item.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)addBUttonClicked{
    
    
    AddBankViewController *vc = [[AddBankViewController alloc] init];
    [vc setRefreshDataBlock:^{
        [self loadData];
    }];
    [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
    
}

- (void)configTableView{
    [self.tableView registerNib:[UINib nibWithNibName:banklistCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:banklistCell];
    
}



#pragma mark - tableView delegate and tableView dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BnakListModel *model = self.dataSource[indexPath.row];
    BankListCell *cell = [tableView dequeueReusableCellWithIdentifier:banklistCell];
    cell.index = indexPath;
    cell.model = model;
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //消除cell选择痕迹
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.2];
    BnakListModel *model = self.dataSource[indexPath.row];

    if (self.formTixianVC == YES) {
        if (_chooseBankBlock) {
            _chooseBankBlock(model);
        }
        
        [self.rt_navigationController popViewControllerAnimated:YES complete:nil];
    }
    
 
    
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
