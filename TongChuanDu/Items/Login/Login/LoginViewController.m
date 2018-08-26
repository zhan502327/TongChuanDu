//
//  LoginViewController.m
//  TongChuanDu
//
//  Created by zhandb on 2018/7/9.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "UserInfoResponse.h"
#import "AppDelegate+UI.h"
#import "AppDelegate.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavgiationBarTitle:@"登录"];
    
    if (UserInfoManager.userModel.username.length > 0) {
        self.mobileTextField.text = UserInfoManager.userModel.username;
    }
    
}
- (IBAction)loginButtonClicked:(id)sender {
    
    if (_mobileTextField.text.length == 0) {
        [SVProgressHUDManager popTostInfoWithString:@"请输入账号"];
        return;
    }
    
    if (_passwordTextField.text.length == 0) {
        [SVProgressHUDManager popTostInfoWithString:@"请输入密码"];
        return;
        
    }
    
    [App_HttpsRequestTool loginLoginRequestMobile:self.mobileTextField.text passWord:self.passwordTextField.text deviceID:Device_Id withSuccess:^(id responseObject) {
        
        UserInfoResponse *response = [[UserInfoResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response isSuccess]) {
            
            UserInfoManager.userModel = response.result;
            
            
            [(AppDelegate *)[UIApplication sharedApplication].delegate relinkToRootVC];

            
        }else{
            [SVProgressHUDManager popTostErrorWithString:response.reason];
        }
        
        
    } failure:^(NSError *error) {
        
    }];
    
    
}

- (IBAction)registerButtonClicked:(id)sender {
    
    RegisterViewController *vc = [[RegisterViewController alloc] init];
    [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
}

@end
