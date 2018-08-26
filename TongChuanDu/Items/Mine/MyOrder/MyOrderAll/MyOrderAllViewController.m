//
//  MyOrderAllViewController.m
//  TongChuanDu
//
//  Created by zhandb on 2018/8/4.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "MyOrderAllViewController.h"
#import "MyOrderNormalCell.h"
#import "MyOrderListResponse.h"
#import "OrderDetailViewController.h"
#import "MyOrderOneFooter.h"// ----- 待付款

#import "MyOrderTwoFooter.h"// ----- 待发货

#import "MyOrderThreeFooter.h"// ----- 待收货

#import "MyOrderFourFooter.h"// ----- 交易完成


static NSString *normallCell = @"MyOrderNormalCell";

@interface MyOrderAllViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    int _page;
}

@property (nonatomic, strong) NSMutableArray *dataSource;


@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation MyOrderAllViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.tableView.mj_header beginRefreshing];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self configTable];
    
    
    
}

- (void)configTable{
    
    _page = 1;
    
    [self.tableView registerNib:[UINib nibWithNibName:normallCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:normallCell];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       
        self->_page = 1;
        [self loadData];
        
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
       
        self->_page ++ ;
        [self loadData];
    }];
    
    
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
}

- (void)loadData{
    
    [self.tableView.mj_footer resetNoMoreData];
    
    NSString *type = @"0";//订单状态 1待支付，2待发货,3待收货,0全部
    [App_HttpsRequestTool myOrderListWithtype:type p:_page Success:^(id responseObject) {
        [self endRefresh];
        MyOrderListResponse *response = [[MyOrderListResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response isSuccess]) {
            if ([response.result hasMore] == YES) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            
            if (self->_page == 1) {
                [self.dataSource removeAllObjects];
            }
            
            [self.dataSource addObjectsFromArray:response.result.data];
            [self.tableView reloadData];
            
            
        }else{
            
            PopInfo(response.reason);
        }
        
        [self.tableView setEmptyViewWithArray:self.dataSource withMargin:0 withTitle:nil];
        
    } failure:^(NSError *error) {
        [self endRefresh];
        PopError(netError);
    }];
    
}

- (void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}


#pragma mark - tableView delegate and tableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    MyOrderListModel *model = self.dataSource[section];
    return model.goods.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyOrderListModel *orderModel = self.dataSource[indexPath.section];
    MyOrderListGoods *goodsModel = orderModel.goods[indexPath.row];

    MyOrderNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:normallCell];
    cell.orderModel = orderModel;
    cell.goodsModel = goodsModel;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //消除cell选择痕迹
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.2];
    
    OrderDetailViewController *vc = [[OrderDetailViewController alloc] init];
    [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
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
    return 15;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    MyOrderListModel *model = self.dataSource[section];
    
    if ([model.order_status isEqualToString:@"0"]) {//交易完成
        MyOrderFourFooter *footer = [[[NSBundle mainBundle] loadNibNamed:@"MyOrderFourFooter" owner:nil options:nil] lastObject];
        
        [footer setLookOrderBlock:^{
        
            OrderDetailViewController *vc = [[OrderDetailViewController alloc] init];
            [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
            
        }];
        
        
        return footer;
        
    }
    
    if ([model.order_status isEqualToString:@"1"]) {//待付款
        
        MyOrderOneFooter *footer = [[[NSBundle mainBundle] loadNibNamed:@"MyOrderOneFooter" owner:nil options:nil] lastObject];
        [footer setGoPayBlock:^{
            
        }];
        
        return footer;
        
    }
    
    if ([model.order_status isEqualToString:@"2"]) {//待收货
        
        MyOrderThreeFooter *footer = [[[NSBundle mainBundle] loadNibNamed:@"MyOrderThreeFooter" owner:nil options:nil] lastObject];

        //确认收货
        [footer setShouhuoBlock:^{
            
            [self confirmShouHuoWithModel:model];
            
        }];
        
        //查看物流
        [footer setLookWuliuBlock:^{
            
            
        }];
        return footer;
        
    }
    
    if ([model.order_status isEqualToString:@"3"]) {//待发货
        
        MyOrderTwoFooter *footer = [[[NSBundle mainBundle] loadNibNamed:@"MyOrderTwoFooter" owner:nil options:nil] lastObject];
        [footer setLookWuLiuBlock:^{
            
        }];
        return footer;
        
    }

    return nil;
}

#pragma markk -- 确认收货
- (void)confirmShouHuoWithModel:(MyOrderListModel *)model{
    
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"确认收货？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"收货" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        PopLoading(nil);
        
        [App_HttpsRequestTool confirmShouHuoWithorder_sn:model.order_no Success:^(id responseObject) {
            PopDismiss;
            
            BaseResponse *response = [[BaseResponse alloc] initWithDictionary:responseObject error:nil];
            if ([response isSuccess]) {
                
                PopSuccess(@"已收货成功");
                [self.tableView.mj_header beginRefreshing];
                
            }else{
                PopInfo(response.reason);
            }
            
            
        } failure:^(NSError *error) {
            PopDismiss;

            PopError(netError);
        }];
        
    }];
    [vc addAction:cancel];
    [vc addAction:sure];
    
    [self presentViewController:vc animated:YES completion:nil];
    
    

    
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
