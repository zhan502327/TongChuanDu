//
//  AddressManagerViewController.m
//  TongChuanDu
//
//  Created by zhandb on 2018/7/13.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "AddressManagerViewController.h"
#import "AddressManagerCell.h"
#import "AddressListResponse.h"
#import "AddAddressViewController.h"
static NSString *addressCell = @"AddressManagerCell";

@interface AddressManagerViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation AddressManagerViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [self loadData];

    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavgiationBarTitle:@"地址管理"];
    
    [self configTableView];
    
    
}

- (void)loadData{
    
    [self.dataSource removeAllObjects];
    [App_HttpsRequestTool  addressListWithSuccess:^(id responseObject) {
        
        AddressListResponse *response = [[AddressListResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response isSuccess]) {
            
            [self.dataSource addObjectsFromArray:response.result];
            [self.tableView reloadData];
        }
        
        [self.tableView setEmptyViewWithArray:self.dataSource withMargin:0 withTitle:@"请添加收货地址"];
        
    } failure:^(NSError *error) {
        
        [SVProgressHUDManager popTostErrorWithString:netError];
    }];
}

- (void)configTableView{
    
    
    [self.tableView registerNib:[UINib nibWithNibName:addressCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:addressCell];
    
    
}

#pragma mark - tableView delegate and tableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddressManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:addressCell];
    AddressListModel *model = self.dataSource[indexPath.section];
    cell.model = model;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //消除cell选择痕迹
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.2];

    if (self.fromSureOrderVC == YES) {
        AddressListModel *model = self.dataSource[indexPath.section];

        if (_selectAddressModelBlock) {
            _selectAddressModelBlock(model);
        }
        [self.rt_navigationController popViewControllerAnimated:YES complete:nil];
    }
    
}

- (void)deselect
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}
//HeaderInSection  &&  FooterInSection

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor clearColor];
    return backView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0000001;
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

- (IBAction)addAddressButtonClicked:(id)sender {
    
    AddAddressViewController *vc = [[AddAddressViewController alloc] init];
    [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
    
}

- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        _dataSource = array;
    }
    return _dataSource;
}

@end
