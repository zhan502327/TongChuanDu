//
//  AddAddressViewController.m
//  TongChuanDu
//
//  Created by zhandb on 2018/7/18.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "AddAddressViewController.h"
#import "AddAddressTextFieldCell.h"
#import "AddAddressLabelCell.h"
#import "AddAddressDefaultCell.h"
#import "ChooseCityViewController.h"
#import "CityModel.h"

static NSString *textFieldCell = @"AddAddressTextFieldCell";
static NSString *tabelCell = @"AddAddressLabelCell";
static NSString *defaultCell = @"AddAddressDefaultCell";


@interface AddAddressViewController ()<UITableViewDataSource, UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) NSArray *placeHolderArray;

@property (nonatomic, strong) CityModel *provinceModel;
@property (nonatomic, strong) CityModel *cityModel;
@property (nonatomic, strong) CityModel *areaModel;
@property (nonatomic, copy) NSString *nameStr;
@property (nonatomic, copy) NSString *mobileStr;

@property (nonatomic, copy) NSString *addressStr;

@property (nonatomic, copy) NSString *detailAddressStr;

@property (nonatomic, assign) BOOL isDefault;





@end

@implementation AddAddressViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //获取省市区
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getProvinceAndCityAndAreaModel:) name:@"GetProvinceAndCityAndAreaModel" object:nil];
    
}

#pragma mark - 通知 获取省市区
- (void)getProvinceAndCityAndAreaModel:(NSNotification *)center{
    NSDictionary *info = center.userInfo;
    self.provinceModel = info[@"provinceModel"];
    self.cityModel = info[@"cityModel"];
    self.areaModel = info[@"areaMmodel"];
    self.addressStr = [NSString stringWithFormat:@"%@%@%@",self.provinceModel.name, self.cityModel.name, self.areaModel.name];
    
    NSIndexPath *index = [NSIndexPath indexPathForRow:2 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationAutomatic];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavgiationBarTitle:@"添加新地址"];
    
    self.isDefault = NO;
    
    [self configTableView];
}

- (void)configTableView{
    
    [self.tableView registerNib:[UINib nibWithNibName:textFieldCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:textFieldCell];
    
    [self.tableView registerNib:[UINib nibWithNibName:tabelCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:tabelCell];
    
    [self.tableView registerNib:[UINib nibWithNibName:defaultCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:defaultCell];

    
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
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 2) {
            AddAddressLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:tabelCell];
            cell.titleLabel.text = self.dataSource[indexPath.section][indexPath.row];
            cell.resultTextField.placeholder = self.placeHolderArray[indexPath.section][indexPath.row];
            if (self.addressStr.length > 0) {
                cell.resultTextField.text = self.addressStr;
            }
            cell.resultTextField.tag = 100 + indexPath.row;
            [cell.resultTextField addTarget:self action:@selector(resultTextFieldClicked:) forControlEvents:UIControlEventEditingChanged];
            
            
            return cell;
            
        }else{
            AddAddressTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:textFieldCell];
            cell.titleLabel.text = self.dataSource[indexPath.section][indexPath.row];
            cell.resultTextField.placeholder = self.placeHolderArray[indexPath.section][indexPath.row];
            cell.resultTextField.tag = 100 + indexPath.row;
            [cell.resultTextField addTarget:self action:@selector(resultTextFieldClicked:) forControlEvents:UIControlEventEditingChanged];
            
            return cell;
        }
    }else{
        
        AddAddressDefaultCell *cell = [tableView dequeueReusableCellWithIdentifier:defaultCell];
        cell.titleLabel.text = self.dataSource[indexPath.section][indexPath.row];
        [cell setIsDefaultSwitchBlock:^(BOOL isOn) {
           
            self.isDefault = isOn;
            
        }];
        return cell;
        
    }
}

- (void)resultTextFieldClicked:(UITextField *)textField{
    if (textField.tag == 100) {//收货人
        self.nameStr = textField.text;
    }
    
    if (textField.tag == 101) {//联系电话
        self.mobileStr = textField.text;
    }
    
    if (textField.tag == 103) {//街道
        self.detailAddressStr = textField.text;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //消除cell选择痕迹
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.2];
    
    if (indexPath.section == 0 || indexPath.row == 2) {
        ChooseCityViewController *vc = [[ChooseCityViewController alloc] init];
        vc.type = @"1";
        [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
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
    backView.backgroundColor = [UIColor clearColor];
    return backView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0000001;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = HexColor(0XF5F5F5);
    return backView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
- (IBAction)saveButtonClicked:(id)sender {
    
    if (self.nameStr.length == 0) {
        [SVProgressHUDManager popTostInfoWithString:@"请输入收货人姓名"];
        return;
    }
    
    if (self.mobileStr.length == 0) {
        [SVProgressHUDManager popTostInfoWithString:@"请输入收货人电话"];
        return;
    }
    
    if (self.addressStr.length == 0) {
        [SVProgressHUDManager popTostInfoWithString:@"请选择所在地区"];
        return;
    }
    
    if (self.detailAddressStr.length == 0) {
        [SVProgressHUDManager popTostInfoWithString:@"请输入详细收货地址"];
        return;
    }

    NSString *isDefault = self.isDefault == YES ? @"1" : @"0";
    [SVProgressHUDManager popTostLoadingWithString:@"保存中"];
    
    [App_HttpsRequestTool addNewAddressWithname:self.nameStr phone:self.mobileStr province:self.provinceModel.id city:self.cityModel.id area:self.areaModel.id address:self.detailAddressStr is_default:isDefault WithSuccess:^(id responseObject) {
        [SVProgressHUDManager popTostDismiss];
        BaseResponse *response =[[BaseResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response isSuccess]) {
            [SVProgressHUDManager popTostSuccessWithString:@"保存成功"];
            [self.rt_navigationController popViewControllerAnimated:YES complete:nil];
            
        }else{
            [SVProgressHUDManager popTostErrorWithString:response.reason];
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUDManager popTostDismiss];
        [SVProgressHUDManager popTostErrorWithString:netError];
    }];
}


- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        NSArray *resarray = @[@[@"收货人",@"联系电话",@"所在地区",@"街道"],@[@"设为默认"]];
        [array addObjectsFromArray:resarray];
        _dataSource = array;
    }
    return _dataSource;
}

- (NSArray *)placeHolderArray{
    if (_placeHolderArray == nil) {
        NSArray *array = @[@[@"请填写收货人姓名",@"请填写联系电话",@"请选择省市区",@"请填写详细街道"],@[@""]];
        _placeHolderArray = array;
    }
    return _placeHolderArray;
}
@end
