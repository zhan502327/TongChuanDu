//
//  AddBankViewController.m
//  TongChuanDu
//
//  Created by zhandb on 2018/7/19.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "AddBankViewController.h"
#import "AddBankNormalCell.h"
#import "AddBankFooter.h"

static NSString *notmallCell = @"AddBankNormalCell";

@interface AddBankViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSArray *placeHolderArray;

@property (nonatomic, copy) NSString *personNameStr;//持卡人
@property (nonatomic, copy) NSString *idCardStr;//身份证号码
@property (nonatomic, copy) NSString *bankNameStr;//银行名称
@property (nonatomic, copy) NSString *bankCardStr;//银行卡卡号
@property (nonatomic, copy) NSString *mobileStr;//银行预留手机号

@end

@implementation AddBankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavgiationBarTitle:@"新增银行卡"];
    
    [self configTableView];
    
    self.tipsLabel.attributedText = [Utility mustIdentifier:@"* 请绑定持卡人本人的银行卡"];
    
    
    self.view.backgroundColor = HexColor(0XF5F5F5);
}

- (void)configTableView{
    
    [self.tableView registerNib:[UINib nibWithNibName:notmallCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:notmallCell];
    
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
    
    AddBankNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:notmallCell];
    cell.titleLabel.text = self.dataSource[indexPath.row];
    cell.resultTexField.placeholder = self.placeHolderArray[indexPath.row];
    cell.resultTexField.tag = 100 + indexPath.row;
    [cell.resultTexField addTarget:self action:@selector(resultTexFieldClicked:) forControlEvents:UIControlEventEditingChanged];
    return cell;
    
}

- (void)resultTexFieldClicked:(UITextField *)textField{
    
    if (textField.tag == 100) {//持卡人
        self.personNameStr = textField.text;
    }
    
    if (textField.tag == 101) {//身份证号码
        self.idCardStr = textField.text;
    }
    
    if (textField.tag == 102) {//银行名称

        self.bankNameStr = textField.text;
        
    }
    
    
    if (textField.tag == 103) {//银行卡卡号
        self.bankCardStr = textField.text;

    }
    
    if (textField.tag == 104) {//银行预留手机号
        self.mobileStr = textField.text;

    }
    
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
    AddBankFooter *footer = [[[NSBundle mainBundle] loadNibNamed:@"AddBankFooter" owner:nil options:nil] lastObject];
    [footer setNextButtonBlock:^{
        [self nextButtonClicked];
    }];
    return footer;

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 90;
}

- (void)nextButtonClicked{
    
    if (self.personNameStr.length == 0) {//持卡人姓名
        PopInfo(@"请填写持卡人姓名");
        return;
    }
    
    if (self.idCardStr.length == 0) {//身份证号
        PopInfo(@"请填写身份证号码");
        return;
    }
    
    if (self.bankNameStr.length == 0) {//银行名称
        PopInfo(@"请填写银行名称");
        return;
    }
    
    if (self.bankCardStr.length == 0) {//银行卡卡号
        PopInfo(@"请填写银行卡卡号");
        return;
    }
    
    if (self.mobileStr.length == 0) {//银行预留手机号
        PopInfo(@"请填写银行预留手机号");
        return;
    }
    
    [App_HttpsRequestTool addNewBankWithname:self.personNameStr IDcard:self.idCardStr bank:self.bankNameStr account:self.bankCardStr phone:self.mobileStr Success:^(id responseObject) {
        
        BaseResponse *response = [[BaseResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response isSuccess]) {
            
            PopSuccess(@"添加银行卡成功");
            [self.rt_navigationController popViewControllerAnimated:YES complete:nil];
            
            if (self.refreshDataBlock) {
                self.refreshDataBlock();
            }
        }else{
            PopError(response.reason);
        }
        
    } failure:^(NSError *error) {
        PopError(netError);
    }];
    
    
    
}

- (NSArray *)dataSource{
    if (_dataSource == nil) {
        NSArray *array = @[@"持卡人",@"身份证号码", @"银行名称", @"银行卡卡号",@"银行预留手机号"];
        _dataSource = array;
    }
    return _dataSource;
}

- (NSArray *)placeHolderArray{
    if (_placeHolderArray == nil) {
        NSArray *array = @[@"请填写持卡人",@"请填写身份证号码", @"请填写银行名称", @"请填写银行卡卡号",@"请填写银行预留手机号"];
        _placeHolderArray = array;
    }
    return _placeHolderArray;
}




@end
