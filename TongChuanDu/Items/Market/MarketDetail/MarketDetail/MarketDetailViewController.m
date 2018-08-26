//
//  MarketDetailViewController.m
//  TongChuanDu
//
//  Created by zhandb on 2018/7/12.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "MarketDetailViewController.h"
#import "MarketDetailNormalCell.h"
#import "MarketDetailWebViewCellCell.h"
#import "SDCycleScrollView.h"
#import "MarketDetailResponse.h"
#import "MarketDetailHeaderView.h"
#import "MarketDetailSpecView.h"
#import "MarketDetailParameter.h"
#import "MarketCarViewController.h"
#import "MarketSureOrderViewController.h"
#import <WebKit/WebKit.h>
#import <UShareUI/UShareUI.h>


#define kAninationDuration 0.5
#define kSpecViewHeight 520

#define kBannerViewHeight 375

#define R 255
#define G 118
#define B 0


//        finishButtonNowBuy -- //立即购买
//
//        finishButtonAddCar -- //加入购物车
//
//        twoButton -- //选择规格
typedef enum SpecButtonType{
    SpecButtonTypeBuyAndAddCar,
    SpecButtonTypeBuy ,
    SpecButtonTypeAddCar
}SpecButtonType;

static NSString *detailNormalCellID = @"MarketDetailNormalCell";
static NSString *detailWebViewCellID = @"MarketDetailWebViewCellCell";

@interface MarketDetailViewController ()<UITableViewDataSource, UITableViewDelegate, SDCycleScrollViewDelegate, UIGestureRecognizerDelegate>
{
    CGFloat _webViewCellHeight; // cell高度

}

@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *carButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *bannerView;
@property (weak, nonatomic) IBOutlet UILabel *protuctNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *freeLabel;
@property (weak, nonatomic) IBOutlet UILabel *salesLabel;
@property (weak, nonatomic) IBOutlet UIView *navBarView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, weak) UIView *specBlackView;

/**
 规格view
 */
@property (nonatomic, weak) MarketDetailSpecView *specView;

/**
 参数view
 */
@property (nonatomic, weak) MarketDetailParameter *parameterView;

@property (nonatomic, weak) SDCycleScrollView *cycleView;

@property (nonatomic, strong) NSArray *contentArray;


//商品详情model
@property (nonatomic, strong) MarketDetailModel *productDetailModel;


@end

@implementation MarketDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavgiationBarTitle:@"商品详情"];
    self.navigationController.navigationBar.hidden = YES;
    
    _webViewCellHeight = 1;

    [self configTableView];
    
    [self configNav];
    
    [self loadData];
}

- (void)configNav{
    [self.bannerView bringSubviewToFront:self.navBarView];
    
    NSMutableDictionary *attDic = [NSMutableDictionary dictionary];
    [attDic setValue:[UIFont systemFontOfSize:16] forKey:NSFontAttributeName];      // 字体大小
    [attDic setValue:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];     // 字体颜色
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:@"商品详情" attributes:attDic];
    self.titleLabel.attributedText = attStr;
    
    self.navBarView.backgroundColor = RGBA(R, G, B, 0);
    
    [self.backButton setBackgroundColor:[UIColor clearColor]];
    [self.carButton setBackgroundColor:[UIColor clearColor]];
    
    self.titleLabel.textColor = [UIColor colorWithWhite:1 alpha:0];
}


- (void)configTableView{
    [self.tableView registerNib:[UINib nibWithNibName:detailNormalCellID bundle:[NSBundle mainBundle]] forCellReuseIdentifier:detailNormalCellID];
    [self.tableView registerNib:[UINib nibWithNibName:detailWebViewCellID bundle:[NSBundle mainBundle]] forCellReuseIdentifier:detailWebViewCellID];
    
}

- (void)loadData{
    
    [App_HttpsRequestTool marketDetailWithgoods_id:self.goods_id tWithSuccess:^(id responseObject) {
        
        MarketDetailResponse *response = [[MarketDetailResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response isSuccess]) {
            MarketDetailModel *model = response.result;
            
            self.productDetailModel = model;
            //轮播图数组
            NSMutableArray *cycleArray = [NSMutableArray arrayWithCapacity:0];
            for (MarketDetailDataimg *cycleModel in response.result.dataimg) {
                [cycleArray addObject:cycleModel.path];
            }
            
            self.cycleView.imageURLStringsGroup = cycleArray;
            
           
            //商品名称
            self.protuctNameLabel.text = model.title;
            //商品价格
            self.priceLabel.text = [NSString stringWithFormat:@"¥%@",model.price];
            //快递
            self.freeLabel.text = [NSString stringWithFormat:@"快递： %@",model.express_fee];
            //销量
            self.salesLabel.text = [NSString stringWithFormat:@"销量%@笔",model.sell_num];
            
            //详情
            self.specView.productModel = model;
            //规格数组
            self.specView.specArray = model.dataattrbute;
           
            
            //规格 图片
            [self.specView.productImageView sd_setImageWithURL:[NSURL URLWithString:model.path] placeholderImage:UseImage(@"Public_Image_Zheng_PlaceHolder")];
            
            //规格 商品名称
            self.specView.productNameLabel.text = model.title;
            //剩余库存
            self.specView.saveLabel.text = [NSString stringWithFormat:@"剩余库存%@件",model.stock];
            //商品价格
            self.specView.priceLabel.text = [NSString stringWithFormat:@"¥ %@",model.price];
            //商品分类
            NSString *specCategoryStr = @"请选择：";
            for (MarketDetaildataattrbute *superModel in model.dataattrbute) {
                specCategoryStr = [specCategoryStr stringByAppendingString:[NSString stringWithFormat:@" \"%@\"",superModel.name]];
            }
            self.specView.specLable.text = specCategoryStr;
            
            //产品参数
            self.parameterView.textView.text = model.spec;
            
            
            
            
        }else{
            PopError(response.reason);
        }
        
    } failure:^(NSError *error) {
        PopError(netError);
    }];
    
}


#pragma mark - tableView delegate and tableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.contentArray.count;
    }else{
        return 1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 50;
    }else{
        return _webViewCellHeight;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        MarketDetailNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:detailNormalCellID];
        cell.titleLabel.text = self.contentArray[indexPath.row][0];
        cell.contentLabel.text = self.contentArray[indexPath.row][1];
        return cell;
    }else{
        MarketDetailWebViewCellCell *cell = [tableView dequeueReusableCellWithIdentifier:detailWebViewCellID];
        
        NSString *urlStr = [self.productDetailModel.detail stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];

        [cell.contentWebView addSubview:self.webView];

        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //消除cell选择痕迹
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.2];
    if (indexPath.section == 0) {
  

        if (indexPath.row == 0) {//型号规格
            
            //        finishButtonNowBuy -- //立即购买
            //
            //        finishButtonAddCar -- //加入购物车
            //
            //        twoButton -- //选择规格
            [self clickedSpecItemWithType:SpecButtonTypeBuyAndAddCar];
        }
        
        if (indexPath.row == 1) {//产品参数
            
            [self parameterView];
            self.specBlackView.hidden = NO;
            
            [UIView animateWithDuration:kAninationDuration animations:^{
                self.parameterView.frame = CGRectMake(0, Current_Height - kSpecViewHeight, Current_Width, kSpecViewHeight);
            } completion:^(BOOL finished) {
                
            }];
        }

        
    }
    
}

- (WKWebView *)webView{
    if (_webView == nil) {
        WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0,Current_Width , _webViewCellHeight)];
        [webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        webView.scrollView.scrollEnabled = NO;
        _webView = webView;
    }
    return _webView;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if (object == _webView.scrollView && [keyPath isEqual:@"contentSize"]) {
        UIScrollView *scrollView = _webView.scrollView;
        if (scrollView.contentSize.height > _webViewCellHeight) {
            _webViewCellHeight = scrollView.contentSize.height;
            _webView.frame = CGRectMake(0, 0, Current_Width, _webViewCellHeight);
            [UIView performWithoutAnimation:^{
                NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:1];
                [self.tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
            }];
        }
    }
    
}
- (void)dealloc {
    [_webView.scrollView removeObserver:self forKeyPath:@"contentSize" context:nil];
}

#pragma mark -- 选择规格
- (void)clickedSpecItemWithType:(SpecButtonType)type{
    
    //        finishButtonNowBuy -- //立即购买
    //
    //        finishButtonAddCar -- //加入购物车
    //
    //        twoButton -- //选择规格
    NSString *str = @"";
    switch (type) {
        case SpecButtonTypeBuyAndAddCar:
            str = @"twoButton";
            break;
            
          
        case SpecButtonTypeBuy:
            str = @"finishButtonNowBuy";
            break;
            
            
        case SpecButtonTypeAddCar:
            str = @"finishButtonAddCar";
            break;
            
        default:
            break;
    }
    
    self.specView.bottomButtonClickedType = str;
    self.specBlackView.hidden = NO;
    
    [self.specView setNowBuyButtonBlock:^(NSString *goods_attr_store_id, NSString *attrvalue_id, NSString *selectNumStr, NSString *price) {
        self.specView.frame = CGRectMake(0, Current_Height, Current_Width, kSpecViewHeight);
        self.specBlackView.hidden = YES;
        
        MarketSureOrderViewController *vc = [[MarketSureOrderViewController alloc] init];
        vc.price_num = [NSString stringWithFormat:@"%@_%@",price, selectNumStr];
        
        //商品ids    商品id例如id=”3,4”
        vc.ids = self.productDetailModel.good_id;
        
        //buynum   购买数量，例如：buynum=”3,2”
        vc.buynum = selectNumStr;
        
        //attrvalueid    商品规格
        vc.attrvalueid = attrvalue_id;
        
        [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
        
        
    }];
    
    [UIView animateWithDuration:kAninationDuration animations:^{
        self.specView.frame = CGRectMake(0, Current_Height - kSpecViewHeight, Current_Width, kSpecViewHeight);
    } completion:^(BOOL finished) {
    }];
    
}

- (void)deselect
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}
//HeaderInSection  &&  FooterInSection

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {//详情
        MarketDetailHeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"MarketDetailHeaderView" owner:nil options:nil] lastObject];
        return headerView;
    }else{
        UIView *backView = [[UIView alloc]init];
        backView.backgroundColor = HexColor(0XF5F5F5);
        return backView;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {//详情
        return 40;
    }else{
        return 10;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = HexColor(0XF5F5F5);
    return backView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }else{
        return 0.000000001;
    }
}


#pragma mark -- 规格view
- (UIView *)specBlackView{
    if (_specBlackView == nil) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        view.frame = CGRectMake(0, 0, Current_Width, Current_Height);
        view.hidden = YES;
        [[UIApplication sharedApplication].keyWindow addSubview:view];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(specBlackViewClicked)];
        tap.delegate = self;
        
        [view addGestureRecognizer:tap];
        _specBlackView = view;
    }
    return _specBlackView;
}

#pragma mark -- tap delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if ([touch.view isDescendantOfView:self.specView.tableView]) {
        return NO;
    }
    
    if ([touch.view isDescendantOfView:self.parameterView.textView]) {
        return NO;
    }
    
    if ([touch.view isDescendantOfView:self.specView.bottomViewOne]) {
        return NO;
    }
    
    if ([touch.view isDescendantOfView:self.specView.bottomViewTwo]) {
        return NO;
    }
    
    return YES;
}

- (MarketDetailSpecView *)specView{
    if (_specView == nil) {
        
        MarketDetailSpecView *specView = [[MarketDetailSpecView alloc] initWithFrame:CGRectMake(0, Current_Height, Current_Width, kSpecViewHeight)];
        specView.goods_id = self.goods_id;
        [self.specBlackView addSubview:specView];
        _specView = specView;
    }
    return _specView;
}

- (MarketDetailParameter *)parameterView{
    if (_parameterView == nil) {
        MarketDetailParameter *view = [[MarketDetailParameter alloc] initWithFrame:CGRectMake(0, Current_Height, Current_Width, kSpecViewHeight)];
        [view setParameterBttonBlock:^{
            [self specBlackViewClicked];
        }];
        
        [self.specBlackView addSubview:view];
        _parameterView = view;
    }
    return _parameterView;
}


- (void)specBlackViewClicked{
    
    [UIView animateWithDuration:kAninationDuration animations:^{
        if (self->_specView) {
            self.specView.frame = CGRectMake(0, Current_Height, Current_Width, kSpecViewHeight);
        }
        if (self->_parameterView) {
            self.parameterView.frame = CGRectMake(0, Current_Height, Current_Width, kSpecViewHeight);
        }
    } completion:^(BOOL finished) {
        self.specBlackView.hidden = YES;
    }];
}

- (SDCycleScrollView *)cycleView{
    if (_cycleView == nil) {
        SDCycleScrollView *view = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, Current_Width, CGRectGetMaxY(self.bannerView.frame)) delegate:self placeholderImage:[UIImage imageNamed:@"Public_Image_Zheng_PlaceHolder"]];
        view.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        [self.bannerView addSubview:view];
        _cycleView = view;
        
    }
    return _cycleView;
}


/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    CGFloat percent = offsetY/kBannerViewHeight;
    
    if (offsetY < kBannerViewHeight) {
        self.navBarView.backgroundColor = RGBA(G, G, B, percent);
        self.titleLabel.textColor = [UIColor colorWithWhite:1 alpha:percent];
        
    }else{
        self.navBarView.backgroundColor = RGBA(R, G, B, 1);
        self.titleLabel.textColor = [UIColor colorWithWhite:1 alpha:1];
        
    }
    
}


- (NSArray *)contentArray{
    if (_contentArray == nil) {
        NSArray *array = @[@[@"规格",@"请选择 机身颜色 存储容量"],@[@"参数",@"规格 型号"]];
        _contentArray = array;
    }
    return _contentArray;
}

#pragma mark -- 返回
- (IBAction)leftBackButtonCLicked:(id)sender {
    [self.rt_navigationController popViewControllerAnimated:YES complete:nil];
}

#pragma mark -- 顶部 - 购物车
- (IBAction)carButtonClicked:(id)sender {
    
    MarketCarViewController *vc = [[MarketCarViewController alloc] init];
    [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
}

#pragma mark -- 分享
- (IBAction)shareButtonClicked:(id)sender {
    
    //显示分享面板
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        [self shareWebPageToPlatformType:platformType];
    }];

    
}
#pragma mark -- 底部 - 购物车
- (IBAction)bottomCarButtonClicked:(id)sender {
    
    MarketCarViewController *vc = [[MarketCarViewController alloc] init];
    [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
}
#pragma mark -- 加入购物车
- (IBAction)bottomAddCarButtonClicked:(id)sender {
    [self clickedSpecItemWithType:SpecButtonTypeAddCar];
}

#pragma mark -- 立即购买
- (IBAction)bottomNowBuyButtonClicked:(id)sender {
    [self clickedSpecItemWithType:SpecButtonTypeBuy];
}



- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象
    UIImage *thumbURL = [UIImage imageNamed:@"APP_Share_Log_120"];
    
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"同船渡" descr:@"我在使用同船渡，快来加入我们吧！" thumImage:thumbURL];
    //设置网页地址
    shareObject.webpageUrl = self.productDetailModel.shareurl;
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
