//
//  UserManager.m
//  TongChuanDu
//
//  Created by zhandb on 2018/7/16.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "UserManager.h"
#import "AppDelegate+UI.h"

#define kUserInfoKey @"UserInfo"
#define kUploadIdCardStatus @"kUploadIdCardStatus"
#define kUploadStudentStatus @"kUploadStudentStatus"

static UserManager *_userManager;

@implementation UserManager

+ (UserManager *)shareUserManager{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_userManager == nil) {
            _userManager = [[super alloc] init];
        }
    });
    return _userManager;
}


- (instancetype)init{
    self = [super init];
    if (self) {
        _userModel = [[UserInfoModel alloc] initWithString:[[NSUserDefaults standardUserDefaults] objectForKey:kUserInfoKey] error:nil];

    }
    return self;
    
}


//重写set方法
- (void)setUserModel:(UserInfoModel *)userModel{
    
    _userModel = userModel;
    [[NSUserDefaults standardUserDefaults] setObject:[userModel toJSONString] forKey:kUserInfoKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}


//获取头像
- (NSString *)avatar{
    
    return _userModel.avatar;
    
}

//获取用户名
- (NSString *)userName{
    
    return _userModel.username;
}

//获取用户id
- (NSString *)uid{
    return _userModel.uid;
}

//判断是否登录
- (BOOL)isLogined{
    return _userModel && _userModel.uid;
}


//退出登录
- (void)loginOut{
    _userModel = nil;
    // ------清除保存的用户数据
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserInfoKey];

    // ------ 清除身份证上传状态
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUploadIdCardStatus];
    
    // ------ 清除学生证上传状态
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUploadStudentStatus];

    //清除数据退出登录后跳转到首页
    [(AppDelegate *)[UIApplication sharedApplication].delegate relinkToRootVC];
}

//清除用户信息
- (void)cleanUserInfo{
    _userModel = nil;
    // ------清除保存的用户数据
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserInfoKey];
    
    // ------ 清除身份证上传状态
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUploadIdCardStatus];
    
    // ------ 清除学生证上传状态
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUploadStudentStatus];
}


//上传身份证信息成功
- (void)isUploadIdCardWithStatus:(BOOL)status{
    [[NSUserDefaults standardUserDefaults] setBool:status forKey:kUploadIdCardStatus];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//获取上传身份证信息状态
- (BOOL)uploadIdCardWithStatus{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kUploadIdCardStatus];
}


//上传学生证信息成功
- (void)isUploadStudentWithStatus:(BOOL)status{
    [[NSUserDefaults standardUserDefaults] setBool:status forKey:kUploadStudentStatus];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//获取上传学生证信息状态
- (BOOL)uploadStudentWithStatus{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kUploadStudentStatus];
}



















// 为了严谨，也要重写copyWithZone 和 mutableCopyWithZone
-(id)copyWithZone:(NSZone *)zone
{
    return _userManager;
}
-(id)mutableCopyWithZone:(NSZone *)zone
{
    return _userManager;
}



@end
