//
//  WalletDetailViewController.m
//  TongChuanDu
//
//  Created by zhandb on 2018/7/13.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "WalletDetailViewController.h"
#import "WalletDetailCell.h"

static NSString *detailCell = @"WalletDetailCell";

@interface WalletDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation WalletDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setNavgiationBarTitle:@"零钱明细"];
    [self configTableView];
    
}

- (void)configTableView{
    [self.tableView registerNib:[UINib nibWithNibName:detailCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:detailCell];
    
}


#pragma mark - tableView delegate and tableView dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WalletDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:detailCell];
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

-(NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        _dataSource = array;
    }
    return _dataSource;
}



@end
