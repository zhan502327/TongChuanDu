//
//  ChongzhiViewController.m
//  TongChuanDu
//
//  Created by zhandb on 2018/8/3.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "ChongzhiViewController.h"

#import "PurseRechargeCell.h"
#import "PurseRechargeHeaderView.h"
#import "WeiXinOrderResponse.h"

//#import <AlipaySDK/AlipaySDK.h>
//#import "WXApi.h"

static NSString *cellIdentifier = @"PurseRechargeCell";


@interface ChongzhiViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSString *_payTypeStr;   //支付方式 ali支付宝，wx是微信
    
    NSInteger _currentRow;
    
}

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (strong, nonatomic) NSArray *mainArray;
/** 充值金额 */
@property (weak, nonatomic) IBOutlet UITextField *rechargeTextFild;

//记录选择支付方式记录数组
@property (strong,nonatomic) NSMutableArray *dataSouceArray;

@end

@implementation ChongzhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavgiationBarTitle:@"充值"];
    
    [self configFile];
}

- (void)configFile {
    _currentRow = 0;
    self.mainTableView.rowHeight = 60.0f;
    self.mainTableView.tableFooterView = [[UIView alloc] init];
}

#pragma mark - **************** 懒加载
- (NSArray *)mainArray {
    
    if (!_mainArray) {
        
        _mainArray = @[@{@"image":@"App_AirPay_Icon",@"title":@"支付宝支付"},
                       @{@"image":@"App_WeChat_Icon",@"title":@"微信支付"}];
    }
    return _mainArray;
}


-(NSMutableArray *)dataSouceArray{
    if (!_dataSouceArray) {
        _dataSouceArray = [[NSMutableArray alloc]init];
        
        for (NSInteger cnt = 0; cnt < 2; cnt++)
        {
            [self.dataSouceArray addObject:@(0)];
            
            
        }
        [self.dataSouceArray replaceObjectAtIndex:0 withObject:@(1)];
    }
    return _dataSouceArray;
}

#pragma mark - **************** 点击实现
// ------确认充值
- (IBAction)sureRechargeButtonClick:(id)sender {
    
    if (self.rechargeTextFild.text.length == 0) {
        
        [SVProgressHUDManager popTostErrorWithString:@"充值金额不能为空"];
        return;
    }
    
    if ([self.dataSouceArray[0] isEqual:@(1)]) {
        _payTypeStr = @"ali";//支付宝支付
    }else{
        _payTypeStr = @"wx";//微信支付
        
    }
    
    PopInfo(@"请稍后再试");
    
    
//    [App_HttpsRequestTool purseRechargeRequestDataForRechargeType:self.rechargeType money:self.rechargeTextFild.text payType:_payTypeStr withSuccess:^(id responseObject) {
//        NSDictionary *dict = (NSDictionary *)responseObject;
//        if ([dict[@"error_code"] intValue] == 0) {
//            if ([_payTypeStr isEqualToString:@"ali"]) {
//                [[AlipaySDK defaultService] payOrder:dict[@"result"] fromScheme:@"jianzulian" callback:^(NSDictionary *resultDic) {
//                    NSLog(@"reslut = %@",resultDic);
//                }];
//            }
//            if ([_payTypeStr isEqualToString:@"wx"]) {
//                WeiXinOrderResponse *result = [[WeiXinOrderResponse alloc] initWithDictionary:responseObject error:nil];
//                if ([result isSuccess]) {
//
//                    PayReq *request = [[PayReq alloc] init];
//                    request.partnerId = result.result.partnerid;
//                    request.prepayId = result.result.prepayid;
//                    request.package = result.result.package;
//                    request.nonceStr = result.result.noncestr;
//                    request.timeStamp = [result.result.timestamp intValue];
//                    request.sign = result.result.sign;
//
//                    [WXApi sendReq:request];
//
//                }else{
//
//                }
//            }
//        }else{
//            [SVProgressHUDManager popTostErrorWithString:dict[@"reason"]];
//        }
//
//
//    } failure:^(NSError *error) {
//
//    }];
}

#pragma mark - **************** UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    self.rechargeTextFild.text = textField.text;
}

#pragma mark - **************** UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self mainArray].count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    PurseRechargeHeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"PurseRechargeHeaderView" owner:nil options:nil] lastObject];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PurseRechargeCell *cell = [[[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:nil options:nil] lastObject];
    cell.beSelected = [self.dataSouceArray[indexPath.row] integerValue];;
    
    [cell setPurseRechargeCellDictionary:[self mainArray][indexPath.row]];
    
    return cell;
}

#pragma mark - **************** UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    for (NSInteger a = 0; a< self.dataSouceArray.count; a++) {
        if (a == indexPath.row) {
            self.dataSouceArray[indexPath.row] = @(1);
            
        }else{
            self.dataSouceArray[a] = @(0);
        }
    }
    [self.mainTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
    
}

@end
