//
//  ConfigNicknameViewController.m
//  TongChuanDu
//
//  Created by zhandb on 2018/7/17.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "ConfigNicknameViewController.h"

@interface ConfigNicknameViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nicknameTextField;

@end

@implementation ConfigNicknameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavgiationBarTitle:@"修改昵称"];
    
    
    self.nicknameTextField.text = self.nickname;
}
- (IBAction)saveButtonClicked:(id)sender {
    
    if (self.nicknameTextField.text.length == 0) {
        
        [SVProgressHUDManager popTostInfoWithString:@"请输入昵称"];

        return;
    }
    
    [SVProgressHUDManager popTostLoadingWithString:@"修改中"];
    [App_HttpsRequestTool editPersonInfoWithImageData:nil type:@"n" value:self.nicknameTextField.text WithSuccess:^(id responseObject) {
        
        [SVProgressHUDManager popTostDismiss];
        
        BaseResponse *response =[[BaseResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response isSuccess]) {
            
            [SVProgressHUDManager popTostSuccessWithString:@"修改昵称成功"];
            [self.rt_navigationController popViewControllerAnimated:YES complete:nil];
            
            if (self.refreshDataBlock) {
                self.refreshDataBlock();
            }
        }else{
            [SVProgressHUDManager popTostErrorWithString:response.reason];
        }
       
        
    } failure:^(NSError *error) {
        [SVProgressHUDManager popTostDismiss];

        [SVProgressHUDManager popTostErrorWithString:netError];
    }];
    
    
}

@end
