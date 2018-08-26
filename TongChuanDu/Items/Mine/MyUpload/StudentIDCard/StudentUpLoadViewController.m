//
//  StudentUpLoadViewController.m
//  TongChuanDu
//
//  Created by zhandb on 2018/7/15.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "StudentUpLoadViewController.h"
#import "UpLoadImageCell.h"
#import "UpLoadContentCell.h"
#import "ZZYPhotoHelper.h"

static NSString *contentCellID = @"UpLoadContentCell";
static NSString *imageCellID = @"UpLoadImageCell";

@interface StudentUpLoadViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *uploadButton;

@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, strong) NSArray *placeHolderArray;

//姓名
@property (nonatomic, copy) NSString *nameStr;
//学校名称
@property (nonatomic, copy) NSString *schoolNameStr;
//编号
@property (nonatomic, copy) NSString *idCardStr;

//学生证正面
@property (nonatomic, strong) NSData *imageData;

@end

@implementation StudentUpLoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setNavgiationBarTitle:@"上传学生证"];
    
    [self configTableView];
    
}

- (void)configTableView{
    [self.tableView registerNib:[UINib nibWithNibName:imageCellID bundle:[NSBundle mainBundle]] forCellReuseIdentifier:imageCellID];
    
    [self.tableView registerNib:[UINib nibWithNibName:contentCellID bundle:[NSBundle mainBundle]] forCellReuseIdentifier:contentCellID];
    self.tableView.backgroundColor = HexColor(0XF5F5F5);

}


#pragma mark - tableView delegate and tableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2) {
        return 60;
    }else{
        return 250;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2) {
        UpLoadContentCell *cell = [tableView dequeueReusableCellWithIdentifier:contentCellID];
        cell.titleLabel.text = self.dataSource[indexPath.row];
        cell.textField.placeholder = self.placeHolderArray[indexPath.row];
        
        cell.textField.tag = (100 + indexPath.row);
        [cell.textField addTarget:self action:@selector(textFieldClicked:) forControlEvents:UIControlEventEditingChanged];
        return cell;
        
        
    }else{
        UpLoadImageCell *cell = [tableView dequeueReusableCellWithIdentifier:imageCellID];
        cell.logImageView.image = [UIImage imageNamed:self.dataSource[indexPath.row]];
        
        cell.logImageView.contentMode = UIViewContentModeScaleAspectFill;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewCLicked:)];
        [cell.logImageView addGestureRecognizer:tap];
        
        if (self.imageData) {
            cell.logImageView.image = [UIImage imageWithData:self.imageData];
        }
        
        return cell;
    }
    
}

#pragma mark -- textField 点击事件
- (void)textFieldClicked:(UITextField *)textField{
    
    if (textField.tag == 100) {//姓名
        self.nameStr = textField.text;
    }
    
    if (textField.tag == 101) {//学校
        self.schoolNameStr = textField.text;
    }
    
    if (textField.tag == 101) {//编号
        self.idCardStr = textField.text;
    }
    
}
#pragma mark -- imageView 点击事件
- (void)imageViewCLicked:(UIGestureRecognizer *)tap{
    
    WeakSelf;
    [[ZZYPhotoHelper shareHelper] showImageViewSelcteWithResultBlock:^(id data) {
        
        NSData *imagedata = UIImageJPEGRepresentation((UIImage *)data, 0.5);
        
        weakSelf.imageData = imagedata;
        
        [weakSelf.tableView reloadData];
    }];
    
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
    backView.backgroundColor = HexColor(0XF5F5F5);
    
    UILabel *lable = [[UILabel alloc] init];
    lable.frame = CGRectMake(20, 10, Current_Width - 40, 20);
    lable.backgroundColor = [UIColor clearColor];
    lable.font = [UIFont systemFontOfSize:12];
    lable.textColor =  HexColor(0XFF7800);
    lable.text = @"* 请确保你填写的信息为真实信息";
    [backView addSubview:lable];
    
    return backView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor clearColor];
    return backView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0000001;
}


- (NSArray *)dataSource{
    if (_dataSource == nil ) {
        NSArray *array = @[@"姓名",@"学校名称",@"学生证编号",@"MyUpLoad_student_zheng"];
        _dataSource = array;
    }
    return _dataSource;
}


- (NSArray *)placeHolderArray{
    if (_placeHolderArray == nil) {
        NSArray *array = @[@"请输入姓名",@"请输入学校名称",@"请输入学生证编号"];
        _placeHolderArray = array;
    }
    return _placeHolderArray;
}


- (IBAction)upLoadButtonClicked:(id)sender {
    
    if (self.nameStr.length == 0) {
        [SVProgressHUDManager popTostInfoWithString:@"请输入姓名"];
        return;
    }
    
    
    if (self.schoolNameStr.length == 0) {
        [SVProgressHUDManager popTostInfoWithString:@"请输入学校名称"];
        return;
    }
    
    
    if (self.idCardStr.length == 0) {
        [SVProgressHUDManager popTostInfoWithString:@"请输入学生证编号"];
        return;
    }
    
    
    if (self.imageData.length == 0) {
        [SVProgressHUDManager popTostInfoWithString:@"请上传学生证"];
        return;
    }
    
    [SVProgressHUDManager popTostLoadingWithString:@"上传中"];

    [App_HttpsRequestTool upLoadStudentInfoWithtruename:self.nameStr school:self.schoolNameStr std_number:self.idCardStr std_face:self.imageData WithSuccess:^(id responseObject) {
        
        [SVProgressHUDManager popTostDismiss];
        
        BaseResponse *response =[[BaseResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response isSuccess]) {
            [SVProgressHUDManager popTostSuccessWithString:@"上传学生证成功"];
            
            [UserInfoManager isUploadStudentWithStatus:YES];
            
            if (self.isFromeRegisterVC == YES && [UserInfoManager uploadIdCardWithStatus] == YES) {//跳转到选择机型界面
                PopInfo(@"跳转选择机型界面");
        
            }else{
                NSLog(@"[UserInfoManager uploadIdCardWithStatus] == %d",[UserInfoManager uploadIdCardWithStatus]);
                NSLog(@"self.isFromeRegisterVC == %d",self.isFromeRegisterVC);

            }
            
        }else{
            [SVProgressHUDManager popTostErrorWithString:response.reason];
            [UserInfoManager isUploadStudentWithStatus:YES];

            
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUDManager popTostErrorWithString:netError];
        [SVProgressHUDManager popTostDismiss];
        [UserInfoManager isUploadStudentWithStatus:YES];

    }];
    
    
    
}



@end
