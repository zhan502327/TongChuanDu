//
//  RegisterViewController.m
//  TongChuanDu
//
//  Created by zhandb on 2018/7/12.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "RegisterViewController.h"
#import "UserInfoModel.h"
#import "LoginViewController.h"
#import "MyIUploadViewController.h"
#import "UserInfoResponse.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;
@property (weak, nonatomic) IBOutlet UIButton *codeButton;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextfield;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavgiationBarTitle:@"注册"];
    
    
    
}

- (IBAction)sendCodeButtonClicked:(id)sender {
    
    
    
    
}
- (IBAction)registerButtonClicked:(id)sender {
    
    if (self.mobileTextField.text.length == 0) {
        
        [SVProgressHUDManager popTostInfoWithString:@"请输入手机号"];
        return;
    }
    
//    if (self.codeTextField.text.length == 0) {
//
//        [SVProgressHUDManager popTostInfoWithString:@"请输入验证码"];
//        return;
//    }
    
    if (self.passwordTextfield.text.length == 0) {
        
        [SVProgressHUDManager popTostInfoWithString:@"请输入密码"];
        return;
    }
    
    [App_HttpsRequestTool registerUserWithphone:self.mobileTextField.text password:self.passwordTextfield.text pid:self.scanModel.uid withSuccess:^(id responseObject) {
        
        UserInfoResponse *response = [[UserInfoResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response isSuccess]) {
            //注册成功清除上个用户的信息
            [UserInfoManager cleanUserInfo];
            
            if (self.scanModel.uid.length > 0) {//扫码注册 -- 跳转认证界面 -- 自动登录
                //省去用户登录界面 -- 保存用户信息
                UserInfoManager.userModel = response.result;

                //跳转
                MyIUploadViewController *vc = [[MyIUploadViewController alloc] init];
                vc.isFromeRegisterVC = YES;
                [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
                
            }else{//存储电话号 -- 返回登录界面
                UserInfoModel *model = [[UserInfoModel alloc] init];
                model.username = self.mobileTextField.text;
                UserInfoManager.userModel = model;
                
                [self.rt_navigationController popViewControllerAnimated:YES complete:nil];

                
            }
       
            [SVProgressHUDManager popTostSuccessWithString:@"恭喜您注册成功"];
        }else{
            
            [SVProgressHUDManager popTostErrorWithString:response.reason];
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUDManager popTostErrorWithString:netError];
    }];
    
}

@end
