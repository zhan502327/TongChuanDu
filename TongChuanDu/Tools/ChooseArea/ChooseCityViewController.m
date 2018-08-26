//
//  ChooseCityViewController.m
//  TongChuanDu
//
//  Created by zhandb on 2018/7/18.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "ChooseCityViewController.h"
#import "CompanyChooseResultCell.h"
#import "CityResponse.h"
#import "CityModel.h"

static NSString *cellIdentifier = @"CompanyChooseResultCell";


@interface ChooseCityViewController ()<UITableViewDelegate, UITableViewDataSource>

//列表页
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//数据源
@property (nonatomic, strong) NSMutableArray *dataSource;



@end

@implementation ChooseCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self configNav];
    
    [self configTableView];
    
    [self loadData];
}
#pragma mark - 配置Nav
- (void)configNav{
    self.view.backgroundColor = [UIColor whiteColor];
    
    if ([self.type integerValue] == 1) {//省
        [self setNavgiationBarTitle:@"省"];
    }
    
    if ([self.type integerValue] == 2) {//市
        [self setNavgiationBarTitle:@"市"];
    }
    
    if ([self.type integerValue] == 3) {//区
        [self setNavgiationBarTitle:@"县"];
    }
    
}

#pragma mark - 配置tableView
- (void)configTableView{
    [self.tableView registerNib:[UINib nibWithNibName:cellIdentifier bundle:[NSBundle mainBundle]] forCellReuseIdentifier: cellIdentifier];
    self.tableView.tableFooterView = [[UIView alloc] init];
}
#pragma mark - 加载数据
- (void)loadData{
    NSString *parent_id = nil;
    if ([self.type integerValue] == 1) {//加载省份 Parent_id = 0；
        parent_id = @"0";
    }
    if ([self.type integerValue] == 2) {//加载市
        parent_id = self.provinceModel.id;
    }
    if ([self.type integerValue] == 3) {//加载县
        parent_id = self.cityModel.id;
    }
    
    [App_HttpsRequestTool chooseCityListRequestForParent_id:parent_id withSuccess:^(id responseObject) {
        CityResponse *result = [[CityResponse alloc] initWithDictionary:responseObject error:nil];
        if ([result isSuccess]) {
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:result.result];
            [self.tableView reloadData];
        }else{
            
        }
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - 重写set方法
- (void)setType:(NSString *)type{
    _type = type;
    
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
    
    CompanyChooseResultCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil ){
        cell = [[CompanyChooseResultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    CityModel *model = self.dataSource[indexPath.row];
    cell.resultLabel.text = model.name;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CityModel *model = self.dataSource[indexPath.row];
    if ([self.type integerValue] == 1) {//省
        ChooseCityViewController *vc = [[ChooseCityViewController alloc] init];
        vc.provinceModel = model;
        vc.type = @"2";
        [self.rt_navigationController pushViewController:vc animated:YES];
    }
    
    if ([self.type integerValue] == 2) {//市
        ChooseCityViewController *vc = [[ChooseCityViewController alloc] init];
        vc.provinceModel = self.provinceModel;
        vc.cityModel = model;
        vc.type = @"3";
        [self.rt_navigationController pushViewController:vc animated:YES];
    }
    
    if ([self.type integerValue] == 3) {//县
        NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
        [param setValue:self.provinceModel forKey:@"provinceModel"];
        [param setValue:self.cityModel forKey:@"cityModel"];
        [param setValue:model forKey:@"areaMmodel"];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GetProvinceAndCityAndAreaModel" object:nil userInfo:param];
        
        for (UIViewController *vc in self.navigationController.viewControllers) {
            
            
            if ([vc isKindOfClass:NSClassFromString(@"AddAddressViewController")]) {
                [self.rt_navigationController popToViewController:vc animated:YES];
            }
        
        }
        
    }
}

#pragma mark - 懒加载
- (NSMutableArray *)dataSource{
    if (_dataSource == nil ) {
        NSMutableArray  *array = [NSMutableArray arrayWithCapacity:0];
        _dataSource = array;
    }
    return _dataSource;
}


@end
