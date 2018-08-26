//
//  MarketCarViewController.m
//  TongChuanDu
//
//  Created by zhandb on 2018/7/14.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "MarketCarViewController.h"
#import "MarketCarCell.h"
#import "MarketCarResponse.h"
#import "MarketCatSelectModel.h"
#import "MarketSureOrderViewController.h"

static NSString *carCell = @"MarketCarCell";

@interface MarketCarViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSString *_priceTotal;   //总金额

}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *selectedArray;

@property (weak, nonatomic) IBOutlet UIButton *allChooseButton;
@property (weak, nonatomic) IBOutlet UILabel *allMoneyLabel;
@property (weak, nonatomic) IBOutlet UIButton *goPayButton;

@end

@implementation MarketCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _allChooseButton.selected = YES;

    
    [self setNavgiationBarTitle:@"购物车"];
    
    [self configTabeleView];
    
    
    [self loadData];
}

- (void)loadData{
    
    [self.dataSource removeAllObjects];
    [self.selectedArray removeAllObjects];


    [App_HttpsRequestTool carListwithSuccess:^(id responseObject) {
        
        MarketCarResponse *response = [[MarketCarResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response isSuccess]) {
     
            NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:0];

            for (MarketCatModel *model in response.result) {
            
                MarketCatSelectModel *selectModel = [[MarketCatSelectModel alloc] init];
                selectModel.carModel = model;
                selectModel.isSelect = YES;
                [selectModel.guige addObjectsFromArray:model.guige];
                
                [resultArray addObject:selectModel];
            }
            
            
            [self.dataSource addObjectsFromArray:resultArray];
            //默认全选
            [self.selectedArray addObjectsFromArray:resultArray];
            
            
            [self.tableView reloadData];
            
            [self countPrice];

            
        }else{
            PopError(response.reason);
        }
        
        [self.tableView setEmptyViewWithArray:self.dataSource withMargin:0 withTitle:nil];
        
    } failure:^(NSError *error) {
        PopError(netError);
    }];
    
}

- (void)configTabeleView{
    
    [self.tableView registerNib:[UINib nibWithNibName:carCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:carCell];
}



// ------改变商品数量
- (void)changeProductNumProduct_id:(NSString *)product_id andBuyNum:(NSString *)buyNum withIndexPath:(NSIndexPath *)index  productModel:(MarketCatSelectModel *)productModel {
    
    [SVProgressHUDManager popTostLoadingWithString:nil];
    [App_HttpsRequestTool marketChangeProductNumRequestDataForProduct_id:product_id buyNum:buyNum withSuccess:^(id responseObject) {
        
        [SVProgressHUDManager popTostDismiss];
        BaseResponse *result = [[BaseResponse alloc] initWithDictionary:responseObject error:nil];
        if ([result isSuccess]) {
            
            productModel.buynum = buyNum;
            
            [self.dataSource replaceObjectAtIndex:index.row withObject:productModel];
            
            if ([self.selectedArray containsObject:productModel]) {
                [self.selectedArray removeObject:productModel];
                [self.selectedArray addObject:productModel];
                [self countPrice];
            }
            
            [self.tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
            
        }else{
            
            [SVProgressHUDManager popTostErrorWithString:@"添加商品失败"];
        }
    } failure:^(NSError *error) {
        
        [SVProgressHUDManager popTostDismiss];
        PopError(netError);
    }];
}

// ------ 删除商品
- (void)deleteProductWithproduct_sn:(NSString *)product_sn productModel:(MarketCatSelectModel *)productModel{
    [SVProgressHUDManager popTostLoadingWithString:nil];
    
    [App_HttpsRequestTool marketShoppingCarListDeleteProductWithproduct_sn:product_sn withSuccess:^(id responseObject) {
        [SVProgressHUDManager popTostDismiss];
        BaseResponse *result = [[BaseResponse alloc] initWithDictionary:responseObject error:nil];
        if ([result isSuccess]) {
            
            
            [self.dataSource removeObject:productModel];
            if ([self.selectedArray containsObject:productModel]) {
                [self.selectedArray removeObject:productModel];
                [self countPrice];
            }
            
            
            [self.tableView reloadData];
            
            PopSuccess(@"删除成功");
            
        }else{
            
            [SVProgressHUDManager popTostErrorWithString:@"删除商品失败"];
        }
    } failure:^(NSError *error) {
        [SVProgressHUDManager popTostDismiss];
        
    }];
    
}


// ------计算已选中金额
- (void)countPrice {
    double totlePrice = 0.0;
    for (MarketCatSelectModel *productModel in self.selectedArray) {
        double price = [productModel.price doubleValue];
        totlePrice += price * [productModel.buynum integerValue];
    }
    _priceTotal = [NSString stringWithFormat:@"￥%.2f",totlePrice];
    
    self.allMoneyLabel.text = _priceTotal;
    [self.goPayButton setTitle:[NSString stringWithFormat:@"结算(%ld)",self.selectedArray.count] forState:UIControlStateNormal];
}

//#pragma mark -- 判断sectionheader是否全选
//- (void)verityGroupSelectState:(NSInteger)section {
//    // 判断某个区的商品是否全选
//    MarketShopResultModel *shopModel = self.dataSource[section];
//    // 是否全选标示符
//    BOOL isShopAllSelect = YES;
//    for (MarketProductResultModel *productModel in shopModel.product_list) {
//        // 当有一个为NO的是时候,将标示符置为NO,并跳出循环
//        if (productModel.select == NO) {
//            isShopAllSelect = NO;
//            break;
//        }
//    }
//    shopModel.select = isShopAllSelect;
//    MarketShoppingCarHeaderView *headerView = (MarketShoppingCarHeaderView *)[self.mainTableView headerViewForSection:section];
//    headerView.model = shopModel;
//    NSIndexSet *index = [NSIndexSet indexSetWithIndex:section];
//    [self.mainTableView reloadSections:index withRowAnimation:UITableViewRowAnimationNone];
//}


#pragma mark -- 判断全选按钮选中状态
- (void)verityAllSelectState {

    if (self.selectedArray.count == self.dataSource.count) {
        _allChooseButton.selected = YES;
    } else {
        _allChooseButton.selected = NO;
    }
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
    
    MarketCatSelectModel *productModel = self.dataSource[indexPath.row];
    MarketCarCell *cell = [tableView dequeueReusableCellWithIdentifier:carCell];
    cell.model = productModel;
    
    //选中商品
    [cell setSelectButtonBlock:^(BOOL isSelect) {
        productModel.isSelect = isSelect;
        if (isSelect) {
            [self.selectedArray addObject:productModel];
        }else{
            [self.selectedArray removeObject:productModel];
        }
        
        [self countPrice];
//        [self verityGroupSelectState:indexPath.section];
        [self verityAllSelectState];
    }];
    //删除
    [cell setDeleteButtonBlock:^{
        
        
        [self deleteProductWithproduct_sn:productModel.good_store_id productModel:productModel];
        
        
        
    }];
    //增加商品
    [cell setAddButtonBlock:^(NSInteger count) {
        
        NSString *productNumber = [NSString stringWithFormat:@"%ld",(long)count];
        
        [self changeProductNumProduct_id:productModel.good_store_id andBuyNum:productNumber withIndexPath:indexPath productModel:productModel];
    
        
    }];
    //减少商品
    [cell setReduceButtonBlock:^(NSInteger count) {
        
        NSString *productNumber = [NSString stringWithFormat:@"%ld",(long)count];
        [self changeProductNumProduct_id:productModel.good_store_id andBuyNum:productNumber withIndexPath:indexPath productModel:productModel];
    }];
    
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

- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        
        NSMutableArray *arrray = [NSMutableArray arrayWithCapacity:0];
        _dataSource = arrray;
        
    }
    return _dataSource;
}

- (NSMutableArray *)selectedArray{
    if (_selectedArray == nil) {
        NSMutableArray *array = [NSMutableArray new];
        _selectedArray = array;
    }
    return _selectedArray;
}

- (IBAction)commitButtonClicked:(id)sender {
    
    if (self.selectedArray.count == 0) {
        [SVProgressHUDManager popTostErrorWithString:@"未选择商品"];
    }else{

        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        for (MarketCatSelectModel *model in self.selectedArray) {
            
            NSString *tem = [NSString stringWithFormat:@"%@_%@",model.price, model.buynum];
            
            [array addObject:tem];
            
        }
        
        NSString *price_num = [array componentsJoinedByString:@"|"];
    
        MarketSureOrderViewController *vc = [[MarketSureOrderViewController alloc] init];
        vc.price_num = price_num;
        vc.selectedArray = self.selectedArray;
        
        [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
        
    }
    
    
}
#pragma mark - **************** 点击实现全选
- (IBAction)sellectAllButtonClicked:(id)sender {
    
    
    UIButton *button = (UIButton *)sender;
    button.selected = !button.selected;
    //点击全选时,把之前已选择的全部删除
    for (MarketCatSelectModel *model in self.selectedArray) {
        model.isSelect = NO;
    }
    [self.selectedArray removeAllObjects];
    if (button.selected) {
        for (MarketCatSelectModel *selectModel in self.dataSource) {
            selectModel.isSelect = YES;
            [self.selectedArray addObject:selectModel];
            
        }
    } else {
        for (MarketCatSelectModel *shopModel in self.dataSource) {
            shopModel.isSelect = NO;
        }
    }
    [self.tableView reloadData];
    [self countPrice];
}

@end
