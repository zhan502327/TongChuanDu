//
//  OrderDetailViewController.m
//  TongChuanDu
//
//  Created by zhandb on 2018/8/4.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "MyOrderDetailNormalCell.h"
#import "MyOrderDetailAddressCell.h"
#import "MyOrderDetailProductCell.h"
#import "OrderDetailWuliuCell.h"

#import "MyOrderOneFooter.h"// ----- 待付款

#import "MyOrderTwoFooter.h"// ----- 待发货

#import "MyOrderThreeFooter.h"// ----- 待收货

#import "MyOrderFourFooter.h"// ----- 交易完成

static NSString *wuliuCell = @"OrderDetailWuliuCell";
static NSString *addressCell = @"MyOrderDetailAddressCell";
static NSString *productCell = @"MyOrderDetailProductCell";
static NSString *normallCell = @"MyOrderDetailNormalCell";

@interface OrderDetailViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) NSArray *haveWuliuArray;
@property (nonatomic, strong) NSArray *noWuLiuArray;

@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavgiationBarTitle:@"订单详情"];
    
    [self configTableView];
    
    [self loadData];
}

- (void)loadData{
    
    [self.dataSource addObjectsFromArray:self.haveWuliuArray];
    
    [self.tableView reloadData];
    
}

- (void)configTableView{

    
    [self.tableView registerNib:[UINib nibWithNibName:wuliuCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:wuliuCell];

    [self.tableView registerNib:[UINib nibWithNibName:addressCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:addressCell];

    [self.tableView registerNib:[UINib nibWithNibName:productCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:productCell];

    [self.tableView registerNib:[UINib nibWithNibName:normallCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:normallCell];

}


#pragma mark - tableView delegate and tableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource[section] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if ([self.dataSource[indexPath.section] count] == 2) {//显示 物流和地址
            if (indexPath.row == 0) {//物流
                return 80;
            }
            if (indexPath.row == 1) {//地址
                return 110;
            }
            
            return 0;
        }else{//只显示地址 没物流
            if (indexPath.row == 1) {//地址
                return 110;
            }
            return 0;
        }
    } else if (indexPath.section == 1) {//商品
        return 120;
    }else {//
        return 40;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if ([self.dataSource[indexPath.section] count] == 2) {//显示 物流和地址
            if (indexPath.row == 0) {//物流
                OrderDetailWuliuCell *cell = [tableView dequeueReusableCellWithIdentifier:wuliuCell];
                return cell;
                
            }
            if (indexPath.row == 1) {//地址
                MyOrderDetailAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:addressCell];
                return cell;
                
            }
            return nil;
        }else{//只显示地址 没物流
            if (indexPath.row == 1) {//地址
                MyOrderDetailAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:addressCell];
                return cell;
            }
            return nil;
        }
    }else if(indexPath.section == 1) {//商品
        MyOrderDetailProductCell *cell = [tableView dequeueReusableCellWithIdentifier:productCell];
        return cell;
    }else {//
        
        MyOrderDetailNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:normallCell];
        return cell;
        
    }
    
    
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
    return 0.0000001;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 2) {//显示按钮
        
        MyOrderOneFooter *footer = [[[NSBundle mainBundle] loadNibNamed:@"MyOrderOneFooter" owner:nil options:nil] lastObject];
        return footer;
        
    }else{
        UIView *backView = [[UIView alloc]init];
        backView.backgroundColor = [UIColor clearColor];
        return backView;
        
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 2) {//显示按钮
        return 50;
    }else{
        return 10;
    }
}


-(NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        _dataSource = array;
    }
    return _dataSource;
}

- (NSArray *)haveWuliuArray{
    if (_haveWuliuArray == nil) {
        NSArray *array = @[@[@"物流",@"地址"],@[@"product"],@[@"商品总价",@"快递运费",@"订单总价",@"优惠券",@"实付款"]];
        _haveWuliuArray = array;
    }
    return _haveWuliuArray;
}

- (NSArray *)noWuLiuArray{
    if (_noWuLiuArray == nil) {
        NSArray *array = @[@[@"地址"],@[@"product"],@[@"商品总价",@"快递运费",@"订单总价",@"优惠券",@"实付款"]];
        _noWuLiuArray = array;
    }
    return _noWuLiuArray;
}


@end
