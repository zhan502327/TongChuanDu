//
//  HomeInfoViewController.m
//  TongChuanDu
//
//  Created by zhandb on 2018/8/12.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "HomeInfoViewController.h"
#import "HomeInfoCell.h"

static NSString *cellID = @"HomeInfoCell";

@interface HomeInfoViewController ()<UITableViewDataSource, UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *titleArray;


@end

@implementation HomeInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setNavgiationBarTitle:@"信息"];
    
    [self configTableView];
}

- (void)configTableView{
    
    [self.tableView registerNib:[UINib nibWithNibName:cellID bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellID];
    
}


#pragma mark - tableView delegate and tableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 7 || indexPath.row == 8) {
        return 200;
    }else{
        return 50;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.titleLabel.text = self.titleArray[indexPath.row];
    if (indexPath.row == 7 || indexPath.row == 8) {
        cell.contentTextView.scrollEnabled = YES;
    }else{
        cell.contentTextView.scrollEnabled = NO;
    }
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
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor clearColor];
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
    return 10;
}

- (NSArray *)titleArray{
    if (_titleArray == nil) {
        NSArray *array = @[@"姓  名",@"性  别",@"年  龄",@"学  校",@"专  业",@"年  级",@"联系方式",@"创业方案",@"运行项目经验"];
        _titleArray = array;
    }
    return _titleArray;
}



@end
