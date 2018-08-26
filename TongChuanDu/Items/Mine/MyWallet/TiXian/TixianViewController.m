//
//  TixianViewController.m
//  TongChuanDu
//
//  Created by zhandb on 2018/8/3.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "TixianViewController.h"
#import "TixianCommitCell.h"
#import "TixianMoneyCell.h"
#import "TxianChooseBankCell.h"
#import "BankListViewController.h"
#import "BnakListModel.h"




static NSString *bankCell = @"TxianChooseBankCell";
static NSString *moneyCell = @"TixianMoneyCell";
static NSString *commitCell = @"TixianCommitCell";

@interface TixianViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) BnakListModel *chooseBankModel;


/**
 提现金额
 */
@property (nonatomic, copy) NSString *tixianMoneyStr;
@end

@implementation TixianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavgiationBarTitle:@"提现"];
    
    [self configTableview];
}

- (void)configTableview{
    
    [self.tableView registerNib:[UINib nibWithNibName:bankCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:bankCell];
    [self.tableView registerNib:[UINib nibWithNibName:moneyCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:moneyCell];
    [self.tableView registerNib:[UINib nibWithNibName:commitCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:commitCell];

}


#pragma mark - tableView delegate and tableView dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 100;        
    }else if (indexPath.row == 1){
        return 190;
    }else{
        return 90;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        
        TxianChooseBankCell *cell = [tableView dequeueReusableCellWithIdentifier:bankCell];
        if (self.chooseBankModel) {
            cell.resultLabel.text = [NSString stringWithFormat:@"%@ (%@)",self.chooseBankModel.bank, self.chooseBankModel.account];
        }else{
            cell.resultLabel.text = @"请选择银行卡";

        }
        
        return cell;
        
    }else if (indexPath.row == 1){
        TixianMoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:moneyCell];
        cell.myMoneyLabel.text = [NSString stringWithFormat:@"我的余额%.2f",[(self.money.length == 0 ? @"0" : self.money) doubleValue]];
        
        [cell.moneyTextField addTarget:self action:@selector(moneyTextFieldClicked:) forControlEvents:UIControlEventEditingChanged];
        
        return cell;
        
    }else{
        TixianCommitCell *cell = [tableView dequeueReusableCellWithIdentifier:commitCell];
        
        [cell setCommitButtonBlock:^{
            [self tixianApply];

            
        }];
        
        return cell;
    }
}

- (void)moneyTextFieldClicked:(UITextField *)textField{
    
    self.tixianMoneyStr = textField.text;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //消除cell选择痕迹
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.2];
    
    if (indexPath.row == 0) {//选择银行卡
        BankListViewController *vc = [[BankListViewController alloc] init];
        vc.formTixianVC = YES;
        [vc setChooseBankBlock:^(BnakListModel *model) {
            self.chooseBankModel= model;
            
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
            
        }];
        
        [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
    }
    

    
}

#pragma mark -- 提现 点击事件
- (void)tixianApply{
    
    if (self.chooseBankModel.account.length == 0) {
        PopInfo(@"请选择银行卡");
        return;
    }
    
    if (self.tixianMoneyStr.length == 0) {
        PopInfo(@"请填写提现金额");
        return;
        
    }
    
    [App_HttpsRequestTool tixianApplytotal:self.tixianMoneyStr balance:self.money bank_id:self.chooseBankModel.card_id Success:^(id responseObject) {
        
        BaseResponse *respinse =[[BaseResponse alloc] initWithDictionary:responseObject error:nil];
        if ([respinse isSuccess]) {
            PopSuccess(@"提现成功");
            
            [self.rt_navigationController popViewControllerAnimated:YES complete:nil];
        }else{
            
            PopInfo(respinse.reason);
            
        }
        
    } failure:^(NSError *error) {
        PopError(netError);
    }];
    
}

- (void)deselect
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}





@end
