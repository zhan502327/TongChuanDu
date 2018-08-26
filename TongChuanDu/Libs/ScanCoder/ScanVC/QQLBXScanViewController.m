//
//
//
//
//  Created by lbxia on 15/10/21.
//  Copyright © 2015年 lbxia. All rights reserved.
//

#import "QQLBXScanViewController.h"
#import "CreateBarCodeViewController.h"
//#import "ScanResultViewController.h"
#import "LBXScanVideoZoomView.h"
#import "LBXPermission.h"
#import "LBXPermissionSetting.h"
#import "CustomImagePickerViewController.h"
#import "RegisterViewController.h"
#import "ScanResultResponse.h"

@interface QQLBXScanViewController ()
@property (nonatomic, strong) LBXScanVideoZoomView *zoomView;

@end

@implementation QQLBXScanViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configUI];
    
    [self setNavgiationBarTitle:@"扫一扫"];
    
}

#pragma mark -- 处理扫描结果
- (void)scanResultWithArray:(NSArray<LBXScanResult*>*)array
{
    if (array.count < 1)
    {
        [self popAlertMsgWithScanResult:nil];
     
        return;
    }
    
    //经测试，可以同时识别2个二维码，不能同时识别二维码和条形码
    for (LBXScanResult *result in array) {
        
        NSLog(@"scanResult:%@",result.strScanned);
    }
    
    LBXScanResult *scanResult = array[0];
    
    NSString*strResult = scanResult.strScanned;
    
    self.scanImage = scanResult.imgScanned;
    
    if (!strResult) {
        
        [self popAlertMsgWithScanResult:nil];
        
        return;
    }
    
//    震动提醒
//    [LBXScanWrapper systemVibrate];
//    声音提醒
//    [LBXScanWrapper systemSound];
    

    
    [self showNextVCWithScanResult:scanResult];
   
}

#pragma mark -- 显示结果
- (void)showNextVCWithScanResult:(LBXScanResult*)strResult
{
    //    ScanResultViewController *vc = [ScanResultViewController new];
    //    vc.imgScan = strResult.imgScanned;
    //
    //    vc.strScan = strResult.strScanned;
    //
    //    vc.strCodeType = strResult.strBarCodeType;
    //
    //    [self.navigationController pushViewController:vc animated:YES];
    
    
    ScanResultResponse *response = [[ScanResultResponse alloc] initWithString:strResult.strScanned error:nil];
    
    if ([response isSuccess]) {
        RegisterViewController *vc = [[RegisterViewController alloc] init];
        
        vc.scanModel = response.result;
        
        [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
        
    }else{
        
        //        PopInfo(@"请扫描正确二维码");
        [self popAlertMsgWithScanResult:nil];
        NSLog(@"strResult.strBarCodeType == %@",strResult.strBarCodeType);
        NSLog(@"strResult.strScanned == %@",strResult.strScanned);
        NSLog(@"strResult.imgScanned == %@",strResult.imgScanned);
    }
    
    
}


- (void)popAlertMsgWithScanResult:(NSString*)strResult
{
    if (!strResult) {
        
        strResult = @"扫码识别失败";
    }
    
    __weak __typeof(self) weakSelf = self;
    [LBXAlertAction showAlertWithTitle:@"提示" msg:strResult buttonsStatement:@[@"知道了"] chooseBlock:^(NSInteger buttonIdx) {
        
        [weakSelf reStartDevice];
    }];
}




#pragma mark -底部功能项
//打开相册
- (void)openPhoto
{
    __weak __typeof(self) weakSelf = self;
    [LBXPermission authorizeWithType:LBXPermissionType_Photos completion:^(BOOL granted, BOOL firstTime) {
        if (granted) {
//            [weakSelf openLocalPhoto:NO];
            [weakSelf localPhoto:NO];
        }
        else if (!firstTime )
        {
            [LBXPermissionSetting showAlertToDislayPrivacySettingWithTitle:@"提示" msg:@"没有相册权限，是否前往设置" cancel:@"取消" setting:@"设置"];
        }
    }];
}

#pragma mark -- 打开本地相册
- (void)localPhoto:(BOOL)allowsEditing{
    CustomImagePickerViewController *picker = [[CustomImagePickerViewController alloc] init];

    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    picker.delegate = self;
    
    
    //部分机型有问题
    picker.allowsEditing = allowsEditing;
    
    picker.navigationBar.translucent = NO;
    
    picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;

    
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark --  开关闪光灯
- (void)openOrCloseFlash
{
    [super openOrCloseFlash];
   
    if (self.isOpenFlash)
    {
        [_btnFlash setImage:[UIImage imageNamed:@"qrcode_scan_btn_flash_down"] forState:UIControlStateNormal];
    }
    else
        [_btnFlash setImage:[UIImage imageNamed:@"qrcode_scan_btn_flash_nor"] forState:UIControlStateNormal];
}


#pragma mark -底部功能项
- (void)myQRCode
{
    CreateBarCodeViewController *vc = [CreateBarCodeViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)configUI{
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor = [UIColor blackColor];
    
    
    //设置扫码后需要扫码图像
    self.isNeedScanImage = YES;
}


// ------NavgiationBar标题
- (void)setNavgiationBarTitle:(NSString *)string {
    
    //主色调
    self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
    
    self.title = string;
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:HexColor(0XFFFFFF),NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Semibold" size:16]};
    
}

- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action {
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:UseImage(@"App_NavBar_backImg_Icon") style:UIBarButtonItemStyleDone target:target action:action];
    item.tintColor = [UIColor whiteColor];
    return item;
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self drawBottomItems];
    [self drawTitle];
    
    
}

//绘制扫描区域
- (void)drawTitle
{
    if (!_topTitle)
    {
        self.topTitle = [[UILabel alloc]init];
        _topTitle.bounds = CGRectMake(0, 0, 145, 60);
        _topTitle.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, 50);
        
        //3.5inch iphone
        if ([UIScreen mainScreen].bounds.size.height <= 568 )
        {
            _topTitle.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, 38);
            _topTitle.font = [UIFont systemFontOfSize:14];
        }
        
        
        _topTitle.textAlignment = NSTextAlignmentCenter;
        _topTitle.numberOfLines = 0;
        _topTitle.text = @"将取景框对准二维码即可自动扫描";
        _topTitle.textColor = [UIColor whiteColor];
        [self.view addSubview:_topTitle];
    }
    
    [self.view bringSubviewToFront:_topTitle];
    
}

- (void)cameraInitOver
{
    if (self.isVideoZoom) {
        [self zoomView];
    }
}

- (LBXScanVideoZoomView*)zoomView
{
    if (!_zoomView)
    {
        
        CGRect frame = self.view.frame;
        
        int XRetangleLeft = self.style.xScanRetangleOffset;
        
        CGSize sizeRetangle = CGSizeMake(frame.size.width - XRetangleLeft*2, frame.size.width - XRetangleLeft*2);
        
        if (self.style.whRatio != 1)
        {
            CGFloat w = sizeRetangle.width;
            CGFloat h = w / self.style.whRatio;
            
            NSInteger hInt = (NSInteger)h;
            h  = hInt;
            
            sizeRetangle = CGSizeMake(w, h);
        }
        
        CGFloat videoMaxScale = [self.scanObj getVideoMaxScale];
        
        //扫码区域Y轴最小坐标
        CGFloat YMinRetangle = frame.size.height / 2.0 - sizeRetangle.height/2.0 - self.style.centerUpOffset;
        CGFloat YMaxRetangle = YMinRetangle + sizeRetangle.height;
        
        CGFloat zoomw = sizeRetangle.width + 40;
        _zoomView = [[LBXScanVideoZoomView alloc]initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame)-zoomw)/2, YMaxRetangle + 40, zoomw, 18)];
        
        [_zoomView setMaximunValue:videoMaxScale/4];
        
        
        __weak __typeof(self) weakSelf = self;
        _zoomView.block= ^(float value)
        {
            [weakSelf.scanObj setVideoScale:value];
        };
        [self.view addSubview:_zoomView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        [self.view addGestureRecognizer:tap];
    }
    
    return _zoomView;
    
}

- (void)tap
{
    _zoomView.hidden = !_zoomView.hidden;
}

- (void)drawBottomItems
{
    if (_bottomItemsView) {
        
        return;
    }
    
    self.bottomItemsView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view.frame)-164,
                                                                   CGRectGetWidth(self.view.frame), 100)];
    _bottomItemsView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    [self.view addSubview:_bottomItemsView];
    
    
    [self createButton];
    
    
}


- (void)createButton{
    CGSize size = CGSizeMake(65, 87);
    
    
    self.btnFlash = [[UIButton alloc]init];
    _btnFlash.bounds = CGRectMake(0, 0, size.width, size.height);
    _btnFlash.center = CGPointMake(CGRectGetWidth(_bottomItemsView.frame)/2 - 80, CGRectGetHeight(_bottomItemsView.frame)/2);
    [_btnFlash setImage:[UIImage imageNamed:@"qrcode_scan_btn_flash_nor"] forState:UIControlStateNormal];
    [_btnFlash addTarget:self action:@selector(openOrCloseFlash) forControlEvents:UIControlEventTouchUpInside];
    
    self.btnPhoto = [[UIButton alloc]init];
    _btnPhoto.bounds = _btnFlash.bounds;
    _btnPhoto.center = CGPointMake(CGRectGetWidth(_bottomItemsView.frame)/2 + 80, CGRectGetHeight(_bottomItemsView.frame)/2);
    [_btnPhoto setImage:[UIImage imageNamed:@"qrcode_scan_btn_photo_nor"] forState:UIControlStateNormal];
    [_btnPhoto setImage:[UIImage imageNamed:@"qrcode_scan_btn_photo_down"] forState:UIControlStateHighlighted];
    [_btnPhoto addTarget:self action:@selector(openPhoto) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_bottomItemsView addSubview:_btnFlash];
    [_bottomItemsView addSubview:_btnPhoto];
    
}

- (void)showError:(NSString*)str
{
    [LBXAlertAction showAlertWithTitle:@"提示" msg:str buttonsStatement:@[@"知道了"] chooseBlock:nil];
}



@end
