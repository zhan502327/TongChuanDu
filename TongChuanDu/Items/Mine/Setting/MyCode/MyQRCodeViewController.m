//
//  MyQRCodeViewController.m
//  TongChuanDu
//
//  Created by zhandb on 2018/8/13.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "MyQRCodeViewController.h"
#import "QRCodeResponse.h"
#import <UShareUI/UShareUI.h>


@interface MyQRCodeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *codeImageView;

@property (nonatomic, strong) QRCodeModel *model;

@end

@implementation MyQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavgiationBarTitle:@"我的二维码"];
    
    [self loadData];
    
    [self configNav];
}

- (void)loadData{
    
    [App_HttpsRequestTool myQRCodeWithSuccess:^(id responseObject) {
        
        QRCodeResponse *response = [[QRCodeResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response isSuccess]) {
            self.model = response.result;
            
            [self.codeImageView sd_setImageWithURL:[NSURL URLWithString:response.result.code_url] placeholderImage:UseImage(@"Public_Image_Zheng_PlaceHolder")];
            
        }else{
            PopInfo(response.reason);
        }
        
        
        
    } failure:^(NSError *error) {
        PopError(netError);
    }];
    
    
}

- (void)configNav{
    
    UIBarButtonItem *itemTwo = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Market_share"] style:UIBarButtonItemStyleDone target:self action:@selector(shareButtonClicked)];
    itemTwo.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = itemTwo;
    
}

- (void)shareButtonClicked{
    if (self.model.code_url.length > 0) {
        
        //显示分享面板
        [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
            // 根据获取的platformType确定所选平台进行下一步操作
            [self shareWebPageToPlatformType:platformType];
        }];
        
    }
    
}



- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象
//    UIImage *thumbURL = [UIImage imageNamed:@"APP_share"];
    NSURL *url = [NSURL URLWithString:self.model.code_url];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"同船渡" descr:@"我在使用同船渡，快来加入我们吧！" thumImage:data];
    //设置网页地址
    shareObject.webpageUrl = self.model.code_url;
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
    }];
}




@end
