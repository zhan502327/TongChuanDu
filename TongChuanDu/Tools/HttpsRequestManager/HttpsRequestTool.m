
//
//  HttpsRequestTool.m
//  JianZuLianApp
//
//  Created by 张帅 on 2017/9/9.
//  Copyright © 2017年 JianZuLian. All rights reserved.
//

#import "HttpsRequestTool.h"
#import "HttpsRequestManager.h"



#define App_Api_Base_Url(url) [NSString stringWithFormat:@"%@%@",cnUrl,url]

static HttpsRequestTool *shareHttpsRequestTool = nil;

@implementation HttpsRequestTool

+ (HttpsRequestTool *)shareHttpsRequestTool {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        shareHttpsRequestTool = [[self alloc] init];
        
    });
    return shareHttpsRequestTool;
}




#pragma mark - **************** 登陆注册
// ------密码登陆
- (void)loginLoginRequestMobile:(NSString *)mobile passWord:(NSString *)passWord deviceID:(NSString *)deviceId withSuccess:(getBackBlock)success failure:(getFailBlock)failure {
    
    NSString *url = App_Api_Base_Url(@"/user/dologin");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:mobile forKey:@"username"];
    [dic setValue:passWord forKey:@"password"];
    [dic setValue:@"" forKey:@"jpush_id"];
    [dic setValue:deviceId forKey:@"device_id"];

    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// ----- 用户注册
- (void)registerUserWithphone:(NSString *)phone password:(NSString *)password pid:(NSString *)pid withSuccess:(getBackBlock)success failure:(getFailBlock)failure {
    
    NSString *url = App_Api_Base_Url(@"/Member/regisiter");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:phone forKey:@"username"];
    [dic setValue:password forKey:@"password"];
    [dic setValue:pid forKey:@"pid"];
    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}



#pragma mark - **************** 首页
// ----- 首页
- (void)appShouyewithSuccess:(getBackBlock)success failure:(getFailBlock)failure{
    
    NSString *url = App_Api_Base_Url(@"/appindex/index");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:@"token" forKey:@"token"];
    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}











#pragma mark - **************** 个人信息
// ------ 获取个人信息
- (void)personuserInfoWithSuccess:(getBackBlock)success failure:(getFailBlock)failure{
    
    NSString *url = App_Api_Base_Url(@"/member/getUserInfo");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:[UserInfoManager uid] forKey:@"uid"];
    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}


// ----- 编辑修改个人信息
- (void)editPersonInfoWithImageData:(NSData *)imageData type:(NSString *)type value:(NSString *)value WithSuccess:(getBackBlock)success failure:(getFailBlock)failure{
    
//    头像，type 选 a
//    姓名，type 选 n
//    姓别，type 选 s
//    电话，type 选 p
    
    NSString *url = App_Api_Base_Url(@"/member/editUserInfo");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:[UserInfoManager uid] forKey:@"uid"];
    [dic setValue:type forKey:@"type"];
 

    if ([type isEqualToString:@"a"]) {
        [App_HttpsRequestManager configPersonAvatarWithUrl:url imageData:imageData andParameterDictionary:dic withSuccess:^(id responseObject) {
            success(responseObject);
            
        } failure:^(NSError *error) {
            failure(error);
            
        }];
    }else{
        [dic setValue:value forKey:@"value"];

        [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
            success(responseObject);
        } failure:^(NSError *error) {
            failure(error);
        }];
        
    }
}


// ------ 上传身份证
- (void)upLoadShenFenZhengWithtruename:(NSString *)truename IDcard:(NSString *)IDcard card_face:(NSData *)card_face card_back:(NSData *)card_back WithSuccess:(getBackBlock)success failure:(getFailBlock)failure {
    
    NSString *url = App_Api_Base_Url(@"/member/uploadUserCards");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:truename forKey:@"truename"];
    [dic setObject:IDcard forKey:@"IDcard"];
    [dic setObject:[UserInfoManager uid] forKey:@"uid"];


    
    [App_HttpsRequestManager upLoadShenFenZhengWithurl:url card_face:card_face card_back:card_back andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);

    } failure:^(NSError *error) {
        failure(error);

    }];
}


// ------ 上传学生证
- (void)upLoadStudentInfoWithtruename:(NSString *)truename school:(NSString *)school std_number:(NSString *)std_number std_face:(NSData *)std_face WithSuccess:(getBackBlock)success failure:(getFailBlock)failure {
    
    NSString *url = App_Api_Base_Url(@"/member/uploadUserStdCard");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:truename forKey:@"truename"];
    [dic setObject:school forKey:@"school"];
    [dic setObject:std_number forKey:@"std_number"];
    [dic setObject:std_face forKey:@"std_face"];
    [dic setObject:[UserInfoManager uid] forKey:@"uid"];
    
    [App_HttpsRequestManager upLoadStudentInfoWithurl:url std_face:std_face andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);

    } failure:^(NSError *error) {
        failure(error);

    }];

}



// ----- 地址列表
- (void)addressListWithSuccess:(getBackBlock)success failure:(getFailBlock)failure {
    
    NSString *url = App_Api_Base_Url(@"/member/addressList");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:[UserInfoManager uid] forKey:@"uid"];

    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// ----- 新增地址
- (void)addNewAddressWithname:(NSString *)name phone:(NSString *)phone province:(NSString *)province city:(NSString *)city area:(NSString *)area address:(NSString *)address is_default:(NSString *)is_default WithSuccess:(getBackBlock)success failure:(getFailBlock)failure {
    
    NSString *url = App_Api_Base_Url(@"/member/addUserAddress");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:[UserInfoManager uid] forKey:@"uid"];
    [dic setObject:name forKey:@"name"];
    [dic setObject:phone forKey:@"phone"];
    [dic setObject:province forKey:@"province"];
    [dic setObject:city forKey:@"city"];
    [dic setObject:area forKey:@"area"];
    [dic setObject:address forKey:@"address"];
    [dic setObject:is_default forKey:@"is_default"];
    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


// ------ 我的二维码
- (void)myQRCodeWithSuccess:(getBackBlock)success failure:(getFailBlock)failure {
    
    NSString *url = App_Api_Base_Url(@"/member/makeMyQrcode");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:[UserInfoManager uid] forKey:@"uid"];
    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}








// ------选择 省/市/县（区）
- (void)chooseCityListRequestForParent_id:(NSString *)parent_id withSuccess:(getBackBlock)success failure:(getFailBlock)failure {
    
    NSString *url = App_Api_Base_Url(@"/member/getChildRegion");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    if (parent_id.length == 0) {
        [dic setObject:@"0" forKey:@"parent_id"];
    }else{
        [dic setObject:parent_id forKey:@"parent_id"];
    }
    
    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


// ----- 获取银行卡列表
- (void)bankListwithSuccess:(getBackBlock)success failure:(getFailBlock)failure {
    
    NSString *url = App_Api_Base_Url(@"/member/getUserBankCard");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:[UserInfoManager uid] forKey:@"uid"];
    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// ------ 新增银行卡
- (void)addNewBankWithname:(NSString *)name IDcard:(NSString *)IDcard bank:(NSString *)bank account:(NSString *)account phone:(NSString *)phone Success:(getBackBlock)success failure:(getFailBlock)failure {
    
    NSString *url = App_Api_Base_Url(@"/member/addUserBankCard");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:[UserInfoManager uid] forKey:@"uid"];
    [dic setValue:name forKey:@"name"];
    [dic setValue:IDcard forKey:@"IDcard"];
    [dic setValue:bank forKey:@"bank"];
    [dic setValue:account forKey:@"account"];
    [dic setValue:phone forKey:@"phone"];

    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}














#pragma mark - **************** 我的
// ----- 我的回收
- (void)myOldPhoneListSuccess:(getBackBlock)success failure:(getFailBlock)failure{
    
    NSString *url = App_Api_Base_Url(@"/oldphone/oldlist");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:[UserInfoManager uid] forKey:@"uid"];

    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

// ----- 发布回收
- (void)publishHuishouWithspec:(NSString *)spec storage:(NSString *)storage color:(NSString *)color buytime:(NSString *)buytime usingtime:(NSString *)usingtime isrepair:(NSString *)isrepair hownew:(NSString *)hownew cover:(NSData *)cover Success:(getBackBlock)success failure:(getFailBlock)failure{
    
    NSString *url = App_Api_Base_Url(@"/oldphone/add");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:[UserInfoManager uid] forKey:@"uid"];
    [dic setValue:spec forKey:@"spec"];
    [dic setValue:storage forKey:@"storage"];
    [dic setValue:color forKey:@"color"];
    [dic setValue:buytime forKey:@"buytime"];
    [dic setValue:usingtime forKey:@"usingtime"];
    [dic setValue:isrepair forKey:@"isrepair"];
    [dic setValue:hownew forKey:@"hownew"];

    
    [App_HttpsRequestManager publishHuiShouWithUrl:url imageData:cover andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);

    } failure:^(NSError *error) {
        failure(error);

    }];
    

    
}

// ----- 我的余额
- (void)myWalletInfoSuccess:(getBackBlock)success failure:(getFailBlock)failure{
    
    NSString *url = App_Api_Base_Url(@"/member/cash");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:[UserInfoManager uid] forKey:@"uid"];
    
    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

// ----- 提现申请
- (void)tixianApplytotal:(NSString *)total balance:(NSString *)balance bank_id:(NSString *)bank_id Success:(getBackBlock)success failure:(getFailBlock)failure{
    
    NSString *url = App_Api_Base_Url(@"/member/addcash");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:[UserInfoManager uid] forKey:@"uid"];
    [dic setValue:total forKey:@"total"];
    [dic setValue:balance forKey:@"balance"];
    [dic setValue:bank_id forKey:@"bank_id"];

    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// ----- 我的积分
- (void)myJiFenListSuccess:(getBackBlock)success failure:(getFailBlock)failure{
    
    NSString *url = App_Api_Base_Url(@"/fuli/mycoin");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:[UserInfoManager uid] forKey:@"uid"];

    
    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


// ----- 签到
- (void)qiandaoSuccess:(getBackBlock)success failure:(getFailBlock)failure{
    
    NSString *url = App_Api_Base_Url(@"/member/dayClick");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:[UserInfoManager uid] forKey:@"uid"];
    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}



// ----- 我的订单
- (void)myOrderListWithtype:(NSString *)type p:(int)p Success:(getBackBlock)success failure:(getFailBlock)failure{
    
    NSString *url = App_Api_Base_Url(@"/order/orderlist");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:[UserInfoManager uid] forKey:@"uid"];
    [dic setValue:type forKey:@"type"];
    [dic setValue:[NSString stringWithFormat:@"%d",p] forKey:@"p"];

    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

// ----- 确认收货
- (void)confirmShouHuoWithorder_sn:(NSString *)order_sn Success:(getBackBlock)success failure:(getFailBlock)failure{
    
    NSString *url = App_Api_Base_Url(@"/order/confirm");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:[UserInfoManager uid] forKey:@"uid"];
    [dic setValue:order_sn forKey:@"order_sn"];
    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}












#pragma mark - **************** 商城
// ------ 商城首页-banner
- (void)marketBannerRequestWithType:(NSString *)type WithSuccess:(getBackBlock)success failure:(getFailBlock)failure {
    
    NSString *url = App_Api_Base_Url(@"/goods/banner");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:type forKey:@"goods"];
    
    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


//商品列表
- (void)marketProductListWithpage:(int)page pagesize:(int)pagesize category:(NSString *)category WithSuccess:(getBackBlock)success failure:(getFailBlock)failure {
    
    NSString *url = App_Api_Base_Url(@"/goods/goodslist");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:category forKey:@"category"];
    [dic setValue:[NSNumber numberWithInt:page] forKey:@"page"];
    [dic setValue:[NSNumber numberWithInt:pagesize] forKey:@"pagesize"];

    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// ------ 商城首页最新列表和热门列表
- (void)marketHotListAndNewListRequestWithSuccess:(getBackBlock)success failure:(getFailBlock)failure {
    
    NSString *url = App_Api_Base_Url(@"/Goods/index");
    NSMutableDictionary *dic = [NSMutableDictionary new];

    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// ------ 商品详情
- (void)marketDetailWithgoods_id:(NSString *)goods_id tWithSuccess:(getBackBlock)success failure:(getFailBlock)failure {
    
    NSString *url = App_Api_Base_Url(@"/goods/detail");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:goods_id forKey:@"goods_id"];

    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


// ----- 积分兑换
- (void)jifenDuihuanWithgood_id:(NSString *)good_id WithSuccess:(getBackBlock)success failure:(getFailBlock)failure {
    
    NSString *url = App_Api_Base_Url(@"/fuli/duihuan");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:good_id forKey:@"good_id"];
    [dic setObject:@"token" forKey:@"token"];
    [dic setValue:[UserInfoManager uid] forKey:@"uid"];

    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


// ------ 订单结算
- (void)orderSureresult:(NSString *)result Success:(getBackBlock)success failure:(getFailBlock)failure{
    
    NSString *url = App_Api_Base_Url(@"/order/makeorder");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:@"token" forKey:@"token"];
    [dic setValue:[UserInfoManager uid] forKey:@"uid"];
    [dic setValue:result forKey:@"result"];
    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}



// ----- 立即购买 /order/add
- (void)goBuyNowWithids:(NSString *)ids buynum:(NSString *)buynum address_id:(NSString *)address_id attrvalueid:(NSString *)attrvalueid paytype:(NSString *)paytype Success:(getBackBlock)success failure:(getFailBlock)failure{
    
    NSString *url = App_Api_Base_Url(@"/order/add");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:@"token" forKey:@"token"];
    [dic setValue:[UserInfoManager uid] forKey:@"uid"];
    [dic setValue:ids forKey:@"ids"];//商品id例如id=”3,4”
    [dic setValue:buynum forKey:@"buynum"];//buynum=”3,2”
    [dic setValue:address_id forKey:@"address_id"];
    [dic setValue:attrvalueid forKey:@"attrvalueid"];
    [dic setValue:paytype forKey:@"paytype"];//支付方式 二选一 wx alipay

    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}



// ------ 点击规格 获取价格
- (void)clickProductCategoryGetPriceWithgoods_id:(NSString *)goods_id attrvalue_id:(NSString *)attrvalue_id Success:(getBackBlock)success failure:(getFailBlock)failure {
    
    NSString *url = App_Api_Base_Url(@"/goods/getrealgood");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:goods_id forKey:@"goods_id"];
    [dic setObject:attrvalue_id forKey:@"attrvalue_id"];

    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// ------添加购物车
- (void)marketShoppingCarAddProductRequestDataForProduct_id:(NSString *)product_id buynum:(NSString *)buynum price:(NSString *)price goods_attr_store_id:(NSString *)goods_attr_store_id attrvalue_id:(NSString *)attrvalue_id remark:(NSString *)remark withSuccess:(getBackBlock)success failure:(getFailBlock)failure {
    
    NSString *url = App_Api_Base_Url(@"/Shoppingcar/add");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:@"token" forKey:@"token"];
    [dic setValue:[UserInfoManager uid] forKey:@"uid"];
    [dic setValue:product_id forKey:@"good_id"];
    [dic setValue:buynum forKey:@"buynum"];
    [dic setValue:price forKey:@"price"];
    [dic setValue:remark forKey:@"remark"];//备注
    [dic setValue:goods_attr_store_id forKey:@"goods_attr_store_id"];
    [dic setValue:attrvalue_id forKey:@"attrvalue_id"];
    
    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// ----- 购物车列表
- (void)carListwithSuccess:(getBackBlock)success failure:(getFailBlock)failure{
    
    NSString *url = App_Api_Base_Url(@"/Shoppingcar/carlist");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:@"token" forKey:@"token"];
    [dic setValue:[UserInfoManager uid] forKey:@"uid"];

    
    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];

}



// ------改变商品数量
- (void)marketChangeProductNumRequestDataForProduct_id:(NSString *)product_id buyNum:(NSString *)buyNum withSuccess:(getBackBlock)success failure:(getFailBlock)failure {
    
    
    NSString *url = App_Api_Base_Url(@"/Shoppingcar/edit");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:@"token" forKey:@"token"];
    [dic setValue:[UserInfoManager uid] forKey:@"uid"];
    [dic setObject:product_id forKey:@"good_store_id"];
    [dic setObject:buyNum forKey:@"buynum"];
    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


// ------删除购物车商品
- (void)marketShoppingCarListDeleteProductWithproduct_sn:(NSString *)product_sn withSuccess:(getBackBlock)success failure:(getFailBlock)failure {
    
    NSString *url = App_Api_Base_Url(@"/Shoppingcar/del");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:@"token" forKey:@"token"];
    [dic setValue:[UserInfoManager uid] forKey:@"uid"];
    [dic setObject:product_sn forKey:@"good_store_id"];
    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}










#pragma mark - **************** 福利
// ------ 福利首页
- (void)welfareListwithSuccess:(getBackBlock)success failure:(getFailBlock)failure{
    
    NSString *url = App_Api_Base_Url(@"/fuli/index");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:@"token" forKey:@"token"];
    
    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}








#pragma mark - **************** 推广
// ------  推广首页
- (void)extentionwithSuccess:(getBackBlock)success failure:(getFailBlock)failure{
    
    NSString *url = App_Api_Base_Url(@"/fuli/tuiguang");
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:@"token" forKey:@"token"];
    [dic setValue:[UserInfoManager uid] forKey:@"uid"];

    [App_HttpsRequestManager POST_HttpsRequestUrl:url andParameterDictionary:dic withSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}


@end
