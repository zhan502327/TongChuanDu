//
//  MarketSureOrderViewController.m
//  TongChuanDu
//
//  Created by zhandb on 2018/8/5.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "MarketSureOrderViewController.h"
#import "MarketOrderCell.h"
#import "MarketSureOrderAddressCell.h"
#import "MarketSureOrderResponse.h"
#import "AddressManagerViewController.h"
#import "AddressListModel.h"
#import "MarketCatSelectModel.h"


#import <AlipaySDK/AlipaySDK.h>
//#import "WXApi.h"

static NSString *orderCellID = @"MarketOrderCell";
static NSString *addressCellID = @"MarketSureOrderAddressCell";



@interface MarketSureOrderViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *sumLabel;
@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, strong) MarketSureOrderAddress *addressModel;

@property (nonatomic, strong) AddressListModel *selectAddressModel;

//记录选择支付方式记录数组
@property (strong,nonatomic) NSMutableArray *selectArray;

@end

@implementation MarketSureOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavgiationBarTitle:@"立即支付"];
    
    [self loadData];
    
    [self configTabelView];
    
}

- (void)configTabelView{
    
    [self.tableView registerNib:[UINib nibWithNibName:orderCellID bundle:[NSBundle mainBundle]] forCellReuseIdentifier:orderCellID];
    
    [self.tableView registerNib:[UINib nibWithNibName:addressCellID bundle:[NSBundle mainBundle]] forCellReuseIdentifier:addressCellID];

    
}


- (void)loadData{
    
    
    [App_HttpsRequestTool orderSureresult:self.price_num Success:^(id responseObject) {
        
        MarketSureOrderResponse *response = [[MarketSureOrderResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response isSuccess]) {
            if (response.result.address.count > 0) {
                MarketSureOrderAddress *addressModel = response.result.address.firstObject;
                self.addressModel = addressModel;
            }
        
            [self dataSource];
            self.sumLabel.text = [NSString stringWithFormat:@"¥ %@",response.result.sum];
            
            [self.tableView reloadData];
            
        }else{
            PopInfo(response.reason);
            
        }
        
        
    } failure:^(NSError *error) {
        PopError(netError);
    }];
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
        return 90;
    }else{
        return 70;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
     
        
        MarketSureOrderAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:addressCellID];
        cell.selectAddressModel = self.selectAddressModel;
        
        cell.model = self.addressModel;
        return cell;
        
        
    }else{
        MarketOrderCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"MarketOrderCell" owner:nil options:nil] lastObject];
        
        if (indexPath.row == 0) {
            cell.payImageView.image = UseImage(@"App_AirPay_Icon");
            cell.payTitleLabel.text = @"支付宝支付";
            cell.payContentLabel.text = @"推荐有支付宝账户的用户支付";
            cell.choosePayButton.tag = indexPath.row;
            cell.beSelected= [self.selectArray[indexPath.row] integerValue];
            
        }else if (indexPath.row == 1) {
            cell.payImageView.image = UseImage(@"App_WeChat_Icon");
            cell.payTitleLabel.text = @"微信支付";
            cell.payContentLabel.text = @"推荐安装了微信5.0以上版本的用户支付";
            cell.beSelected= [self.selectArray[indexPath.row] integerValue];
        }
        return cell;
    }
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //消除cell选择痕迹
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.2];
    
    if (indexPath.section == 0) {//地址
  
        AddressManagerViewController *vc = [[AddressManagerViewController alloc] init];
        
        vc.fromSureOrderVC = YES;
        [vc setSelectAddressModelBlock:^(AddressListModel *addressModel) {
            self.selectAddressModel = addressModel;
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            
        }];
        [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
        
    }
    
    if (indexPath.section == 1) {
        /*  *< 改变数据源中的数据,并记录cell的选中状态 >*  */
        for (NSInteger a = 0; a< self.selectArray.count; a++) {
            if (a == indexPath.row) {
                self.selectArray[indexPath.row] = @(1);
                
            }else{
                self.selectArray[a] = @(0);
            }
        }
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
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
    backView.backgroundColor = [UIColor clearColor];
    return backView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0000001;
}

- (NSArray *)dataSource{
    if (_dataSource == nil) {
//        NSArray *array = @[@[@"地址"],@[@"支付宝",@"微信"]];
        NSArray *array = @[@[@"地址"],@[@"支付宝"]];

        _dataSource = array;
    }
    return _dataSource;
}

-(NSMutableArray *)selectArray{
    if (!_selectArray) {
        _selectArray = [[NSMutableArray alloc]init];
        
        for (NSInteger cnt = 0; cnt < 2; cnt++)
        {
            [self.selectArray addObject:@(0)];
            
            
        }
        [self.selectArray replaceObjectAtIndex:0 withObject:@(1)];
    }
    return _selectArray;
}

- (IBAction)commitOrderClicked:(id)sender {
    
    if (self.selectAddressModel == nil && self.addressModel == nil) {
        PopInfo(@"请选择收货地址");
        return;
    }
    
    
    NSString *payType;//二选一 wx alipay
    if ([self.selectArray[0] isEqual:@(1)]) {
        payType = @"alipay";//支付宝支付
    }else{
        payType = @"wx";//微信支付
    }
    
    NSString *ids = @"";
    NSString *buynum = @"";
    NSString *attrvalueid = @"";
    
    NSMutableArray *idsArray = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *buynumArray = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *attrvalueidArray = [NSMutableArray arrayWithCapacity:0];

    //购物车  -- 需要遍历选择数组
    if (self.selectedArray.count > 0) {//从购物车过来
        
        for (MarketCatSelectModel *model in self.selectedArray) {
            
            [idsArray addObject:model.product_sn];
            [buynumArray addObject:model.buynum];
            [attrvalueidArray addObject:model.attrvalueid];
            
        }
        
        ids = [idsArray componentsJoinedByString:@","];
        buynum = [buynumArray componentsJoinedByString:@","];
        attrvalueid = [attrvalueidArray componentsJoinedByString:@"|"];
    }else{//从商品详情过来
        
        ids = self.ids;
        buynum = self.buynum;
        attrvalueid = self.attrvalueid;
        
        
    }
    
    

    NSString *address_id = self.selectAddressModel.address_id.length > 0 ? self.selectAddressModel.address_id : self.addressModel.id;

    [App_HttpsRequestTool goBuyNowWithids:ids buynum:buynum address_id:address_id attrvalueid:attrvalueid paytype:payType Success:^(id responseObject) {
        

        if ([payType isEqualToString:@"alipay"]) {//支付宝支付
            
            
            NSDictionary *dictt = [NSDictionary dictionaryWithDictionary:responseObject];
            if ([dictt[@"error_code"] integerValue] == 0) {
                
                
                NSDictionary *result = [self dictionaryWithJsonString:dictt[@"result"]];
                
                
                if ([result[@"error_code"] intValue] == 0) {
                    [[AlipaySDK defaultService] payOrder:result[@"result"] fromScheme:@"tongchuandu" callback:^(NSDictionary *resultDic) {
                        NSLog(@"reslut = %@",resultDic);
                        
                        PopInfo(resultDic[@"memo"]);
                    }];
                    
                }else{
                    [SVProgressHUDManager popTostErrorWithString:result[@"reason"]];
                }
                
                
            }else{
                PopError(dictt[@"reason"]);
                
            }
            
            
            
        }
        
        
        if ([payType isEqualToString:@"wx"]) {//微信
            
            
            
            
        }
        
        
    } failure:^(NSError *error) {
        PopError(netError);
    }];


    
}



- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString.length == 0) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

@end
