//
//  MyWalletViewController.m
//  TongChuanDu
//
//  Created by zhandb on 2018/7/13.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "MyWalletViewController.h"
#import "MyWalletCell.h"
#import "WalletDetailViewController.h"
#import "BankListViewController.h"
#import "ChongzhiViewController.h"
#import "MyMalletResponse.h"
#import "TixianViewController.h"


static NSString *walletCell = @"MyWalletCell";

@interface MyWalletViewController ()<UITableViewDelegate, UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@property (weak, nonatomic) IBOutlet UILabel *myPriceLabel;

@property (nonatomic, strong) MyWalletModel *walletModel;

@end

@implementation MyWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavgiationBarTitle:@"我的余额"];
 
    [self configTableView];
    
    
    [self loadData];
    
}

- (void)configTableView{
    [self.tableView registerNib:[UINib nibWithNibName:walletCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:walletCell];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"明细" style:UIBarButtonItemStyleDone target:self action:@selector(detailButtonClicked)];
    item.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = item;
    
}

- (void)detailButtonClicked{
    WalletDetailViewController *vc = [[WalletDetailViewController alloc] init];
    [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
    
    
}

- (void)loadData{
    [App_HttpsRequestTool myWalletInfoSuccess:^(id responseObject) {
        
        MyMalletResponse *response= [[ MyMalletResponse alloc] initWithDictionary:responseObject error:nil];
        
        if ([response isSuccess]) {
            self.walletModel = response.result;
            
            self.myPriceLabel.text = [NSString stringWithFormat:@"%.2f", [response.result.balance doubleValue]];
            
            
        }else{
            PopInfo(response.reason);
        }
        
    } failure:^(NSError *error) {
        PopError(netError);
    }];
}


#pragma mark - tableView delegate and tableView dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyWalletCell *cell = [tableView dequeueReusableCellWithIdentifier:walletCell];
    cell.contentLabel.text = self.dataSource[indexPath.row];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //消除cell选择痕迹
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.2];
    if (indexPath.row == 0) {//充值
        ChongzhiViewController *vc = [[ChongzhiViewController alloc] init];
        vc.rechargeType = @"1";
        [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
    }
    
    if (indexPath.row == 1) {//提现
        TixianViewController *vc = [[TixianViewController alloc] init];
#warning --- 目前金额是死数据
        vc.money = @"100";
//        vc.money = self.walletModel.balance;

        [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
    }
    
    if (indexPath.row == 2) {//绑定银行卡
        BankListViewController *vc = [[BankListViewController alloc] init];
        [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
        
    }
}

- (void)deselect
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    
}

- (NSArray *)dataSource{
    
    if (_dataSource == nil) {
        NSArray *array = @[@"充值",@"提现",@"绑定银行卡"];
        _dataSource = array;
    }
    return _dataSource;
}

@end
