//
//  SettingViewController.m
//  TongChuanDu
//
//  Created by zhandb on 2018/7/12.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingNormalCell.h"
#import "SettingHeaderCell.h"
#import "AddressManagerViewController.h"
#import "SettingResponse.h"
#import "ZZYPhotoHelper.h"
#import "ConfigNicknameViewController.h"
#import "MyQRCodeViewController.h"

static NSString *normalCell = @"SettingNormalCell";
static NSString *headerCell = @"SettingHeaderCell";

@interface SettingViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, strong) NSMutableArray *resultArray;

@property (nonatomic, strong) SettingInfoModel *model;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavgiationBarTitle:@"设置"];
    
    [self configTableView];
    
    [self loadData];
    
}

- (void)loadData{
    [self.resultArray removeAllObjects];
    [App_HttpsRequestTool personuserInfoWithSuccess:^(id responseObject) {
    
        SettingResponse *response = [[SettingResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response isSuccess]) {
            
            self.model = response.result;
            NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
            [array addObject:ADDOBJECT(self.model.avatar)];
            [array addObject:ADDOBJECT(self.model.nickname)];
            [array addObject:ADDOBJECT(self.model.sex)];
            [array addObject:ADDOBJECT(@"")];
            [array addObject:ADDOBJECT(self.model.phone)];
            [array addObject:ADDOBJECT(@"")];

            [self.resultArray addObjectsFromArray:array];
            
            [self.tableView reloadData];
        }else{
            [SVProgressHUDManager popTostErrorWithString:response.reason];
            
        }
        
    } failure:^(NSError *error) {
     
        [SVProgressHUDManager popTostErrorWithString:netError];
    }];
    
}
- (void)configTableView{
    
    [self.tableView registerNib:[UINib nibWithNibName:normalCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:normalCell];
    
    [self.tableView registerNib:[UINib nibWithNibName:headerCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:headerCell];

    
}

#pragma mark - tableView delegate and tableView dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 80;
    }else{
        return 55;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        SettingHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:headerCell];
        cell.titleLabel.text = self.dataSource[indexPath.row];
        
        if (self.resultArray.count > 0) {
            [cell.headerImageView sd_setImageWithURL:[NSURL URLWithString:self.resultArray[indexPath.row]] placeholderImage:[UIImage imageNamed:@"Mine_NoLogin"]];
        }
        
        [cell setHeaderImageBlock:^{
            WeakSelf;
            [[ZZYPhotoHelper shareHelper] showImageViewSelcteWithResultBlock:^(id data) {
                NSData *imagedata = UIImageJPEGRepresentation((UIImage *)data, 0.5);
                [weakSelf editUserInfoRequestData:imagedata type:@"a" value:nil];
            }];
        }];
        
        return cell;
    }else{
        SettingNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:normalCell];
        cell.titleNameLabel.text = self.dataSource[indexPath.row];
        if (self.resultArray.count > 0) {
            cell.contentLabel.text = self.resultArray[indexPath.row];
        }
        return cell;
    }
}


- (void)editUserInfoRequestData:(NSData *)imageData type:(NSString *)type value:(NSString *)value{
    
    
    [SVProgressHUDManager popTostLoadingWithString:@"上传个人信息中"];


    [App_HttpsRequestTool editPersonInfoWithImageData:imageData type:type value:value WithSuccess:^(id responseObject) {
        
        [SVProgressHUDManager popTostDismiss];

        BaseResponse *response =[[BaseResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response isSuccess]) {
            [SVProgressHUDManager popTostSuccessWithString:@"上传成功"];
            [self loadData];
            
        }else{
            [SVProgressHUDManager popTostErrorWithString:response.reason];
        }
    } failure:^(NSError *error) {
        [SVProgressHUDManager popTostErrorWithString:netError];
        [SVProgressHUDManager popTostDismiss];
    }];

    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //消除cell选择痕迹
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.2];
    
    if (indexPath.row == 1) {//昵称
        
        ConfigNicknameViewController *vc = [[ConfigNicknameViewController alloc] init];
        if (self.resultArray.count > 0) {
            vc.nickname = self.resultArray[indexPath.row];
        }
        [vc setRefreshDataBlock:^{
            [self loadData];
        }];
        [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
        
    }
    
    if (indexPath.row == 2) {//性别
        
        [self chooseSexWithIndex:indexPath];
        
    }
    
    if (indexPath.row == 3) {//地址管理
        AddressManagerViewController *vc = [[AddressManagerViewController alloc] init];
        [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
    }
    
    if (indexPath.row == 5) {//我的二维码
        MyQRCodeViewController *vc = [[MyQRCodeViewController alloc] init];
        [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
    }
}

- (void)deselect{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

- (void)chooseSexWithIndex:(NSIndexPath *)index{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"请选择性别" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self editUserInfoRequestData:nil type:@"s" value:@"男"];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self editUserInfoRequestData:nil type:@"s" value:@"女"];

    }]];
    
    
    [self presentViewController:alert animated:YES completion:nil];
}



#pragma mark -- 懒加载
- (NSArray *)dataSource{
    if (_dataSource == nil) {
        NSArray *array = @[@"头像",@"昵称",@"性别",@"地址管理",@"注册手机号",@"我的二维码"];
        _dataSource = array;
    }
    return _dataSource;
}

- (NSMutableArray *)resultArray{
    if (_resultArray == nil) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        _resultArray = array;
    }
    return _resultArray;
}

- (IBAction)loginOutButtonClicked:(id)sender {
    
    UIAlertController *loginOutAlert = [UIAlertController alertControllerWithTitle:@"退出登录" message:@"确认要退出么？" preferredStyle:UIAlertControllerStyleAlert];
    [loginOutAlert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }]];
    [loginOutAlert addAction:[UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        [UserInfoManager loginOut];
    }]];
    [self presentViewController:loginOutAlert animated:YES completion:nil];
    
}

@end
