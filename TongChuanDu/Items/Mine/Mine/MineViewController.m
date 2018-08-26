//
//  MineViewController.m
//  TongChuanDu
//
//  Created by zhandb on 2018/7/9.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "MineViewController.h"
#import "MineNormallCell.h"
#import "SettingViewController.h"
#import "MyWalletViewController.h"
#import "MyIUploadViewController.h"
#import "LoginViewController.h"
#import "BaseNavViewController.h"
#import "SettingViewController.h"
#import "MyHuiShouViewController.h"
#import "MyJifenViewController.h"
#import "MyOrderViewController.h"
#import "UserHelpViewController.h"

static NSString *normallCell = @"MineNormallCell";


@interface MineViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *imageArray;

@end

@implementation MineViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if ([UserInfoManager isLogined]) {
        [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[UserInfoManager avatar]] placeholderImage:[UIImage imageNamed:@"Mine_NoLogin"]];
        self.nameLabel.text = [UserInfoManager userName];
    }

}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationController.navigationBar.hidden = YES;
    
    
    [self setNavgiationBarTitle:@""];
    
    [self configTableView];
}

- (void)configTableView{
    
    [self.tableView registerNib:[UINib nibWithNibName:normallCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:normallCell];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerImageClicked:)];
    [self.headerImageView addGestureRecognizer:tap];
    
    
}

- (void)headerImageClicked:(UIGestureRecognizer *)tap {
    if ([UserInfoManager isLogined]) {
        
        
        SettingViewController *vc = [[SettingViewController alloc] init];
        [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
    
    }else{

        LoginViewController *login = [[LoginViewController alloc] init];
        BaseNavViewController *nav = [[BaseNavViewController alloc] initWithRootViewController:login];
        [self presentViewController:nav animated:YES completion:nil];
        
    }
}

#pragma mark - tableView delegate and tableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.titleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.titleArray[section] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MineNormallCell *cell = [tableView dequeueReusableCellWithIdentifier:normallCell];
    cell.logImageView.image = [UIImage imageNamed:self.imageArray[indexPath.section][indexPath.row]];
    cell.titleNameLabel.text = self.titleArray[indexPath.section][indexPath.row];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //消除cell选择痕迹
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.2];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {//我的余额
            MyWalletViewController *vc =[[MyWalletViewController alloc] init];
            [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
        }
        
        if (indexPath.row == 1) {//我的积分
            MyJifenViewController *VC = [[MyJifenViewController alloc] init];
            [self.rt_navigationController pushViewController:VC animated:YES complete:nil];
            
        }
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {//我的订单
            MyOrderViewController *vc = [[MyOrderViewController alloc] init];
            [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
        }
        
        
        if (indexPath.row == 1) {//我的回收
            MyHuiShouViewController *vc = [[MyHuiShouViewController alloc] init];
            [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
        }
        
        if (indexPath.row == 3) {//我的上传
            MyIUploadViewController *VC = [[MyIUploadViewController alloc] init];
            [self.rt_navigationController pushViewController:VC animated:YES complete:nil];
        }
        
     
    }
    
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {//使用协议
            UserHelpViewController *vc = [[UserHelpViewController alloc] init];
            [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
        }
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
    backView.backgroundColor = HexColor(0XF5F5F5);
    return backView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor clearColor];
    return backView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.00000001;
}

#pragma mark -- 设置
- (IBAction)settingButtonClicked:(id)sender {
    
//    SettingViewController *vc = [[SettingViewController alloc] init];
//    [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
}


#pragma mark -- 懒加载
- (NSArray *)titleArray{
    if (_titleArray == nil) {
        NSArray *array = @[@[@"我的余额",@"我的积分"],@[@"我的订单",@"我的回收",@"我的福利",@"我的上传"],@[@"使用协议"]];
        _titleArray = array;
    }
    return _titleArray;
}

- (NSArray *)imageArray{
    if (_imageArray == nil) {
        NSArray *array = @[@[@"Mine_YuE",@"Mine_JiFen"],@[@"Mine_Dingdan",@"Mine_WeiXiu",@"Mine_Fuli",@"Mine_Fuli"],@[@"Mine_XieYi"]];
        _imageArray = array;
    }
    return _imageArray;
}

@end
