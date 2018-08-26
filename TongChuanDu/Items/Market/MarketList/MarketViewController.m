//
//  MarketViewController.m
//  TongChuanDu
//
//  Created by zhandb on 2018/8/5.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "MarketViewController.h"
#import "MarketProductCell.h"
#import "MarketProductResponse.h"
#import "MarketDetailViewController.h"


static NSString *productCellID = @"MarketProductCell";

@interface MarketViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    int _page;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation MarketViewController

- (void)setCategoryModel:(MarketListCategoryModel *)categoryModel{
    _categoryModel = categoryModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavgiationBarTitle:self.categoryModel.title];
    
    [self configTableView];
    
    [self loadData];
}
- (void)loadData{
    
    [self.tableView.mj_footer resetNoMoreData];
    [App_HttpsRequestTool marketProductListWithpage:_page pagesize:10 category:self.categoryModel.category_id WithSuccess:^(id responseObject) {
        [self endRefresh];

        MarketProductResponse *response = [[MarketProductResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response isSuccess]) {
            if (self->_page == 1) {
                [self.dataSource removeAllObjects];
                
            }
            
            if ([response.result hasMore] == YES) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            
            [self.dataSource addObjectsFromArray:response.result.items];
            [self.tableView reloadData];
            
            
            
        }else{
            
        }
        [self.tableView setEmptyViewWithArray:self.dataSource withMargin:0 withTitle:nil];
        
    } failure:^(NSError *error) {
        PopError(netError);
        [self endRefresh];
    }];
    
}

- (void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

- (void)configTableView{
    
    _page = 1;
    
    [self.tableView registerNib:[UINib nibWithNibName:productCellID bundle:[NSBundle mainBundle]] forCellReuseIdentifier:productCellID];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self->_page = 1;
        [self loadData];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self->_page ++;
        [self loadData];
    }];
    
    self.tableView.mj_footer.automaticallyChangeAlpha = YES;
    
}

#pragma mark - tableView delegate and tableView dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MarketProductModel *model = self.dataSource[indexPath.row];
    
    MarketProductCell *cell = [tableView dequeueReusableCellWithIdentifier:productCellID];
    cell.model = model;
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //消除cell选择痕迹
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.2];
    
    
    MarketProductModel *model = self.dataSource[indexPath.row];

    MarketDetailViewController *vc = [[MarketDetailViewController alloc] init];
    vc.goods_id = model.good_id;
    [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
}

- (void)deselect
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}


-(NSMutableArray *)dataSource{
    if (_dataSource== nil) {
        NSMutableArray *array =[NSMutableArray arrayWithCapacity:0];
        _dataSource = array;
    }
    return _dataSource;
}



@end
