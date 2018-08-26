//
//  WelfareDetailViewController.m
//  TongChuanDu
//
//  Created by zhandb on 2018/7/30.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "WelfareDetailViewController.h"
#import "MarketDetailWebViewCellCell.h"
#import "SDCycleScrollView.h"
#import "MarketDetailResponse.h"
#import "MarketDetailHeaderView.h"
#import <WebKit/WebKit.h>



#define kBannerViewHeight 375


#define R 255
#define G 118
#define B 0

static NSString *detailWebViewCellID = @"MarketDetailWebViewCellCell";

@interface WelfareDetailViewController ()<UITableViewDataSource, UITableViewDelegate, SDCycleScrollViewDelegate>

{
    CGFloat _webViewCellHeight; // cell高度
    
}

@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *carButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *bannerView;
@property (weak, nonatomic) IBOutlet UILabel *protuctNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
//@property (weak, nonatomic) IBOutlet UILabel *salesLabel;
@property (weak, nonatomic) IBOutlet UIView *navBarView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *shichangPriceLabel;

@property (nonatomic, strong) WKWebView *webView;


//商品详情model
@property (nonatomic, strong) MarketDetailModel *productDetailModel;
//轮播图
@property (nonatomic, weak) SDCycleScrollView *cycleView;

@end

@implementation WelfareDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavgiationBarTitle:@"积分兑换"];
    
    
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
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:@"积分兑换" attributes:attDic];
    self.titleLabel.attributedText = attStr;
    
    self.navBarView.backgroundColor = RGBA(R, G, B, 0);
    
    [self.backButton setBackgroundColor:[UIColor clearColor]];
    [self.carButton setBackgroundColor:[UIColor clearColor]];
    
    self.titleLabel.textColor = [UIColor colorWithWhite:1 alpha:0];
}


- (void)configTableView{
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
            self.priceLabel.text = [NSString stringWithFormat:@"%@",model.price];
            //市场价
//            self.shichangPriceLabel.text =
       
            
            [self.tableView reloadData];
            
            
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _webViewCellHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MarketDetailWebViewCellCell *cell = [tableView dequeueReusableCellWithIdentifier:detailWebViewCellID];
    
    //webview
    
    NSString *urlStr = [self.productDetailModel.detail stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
    
    
    [cell.contentWebView addSubview:self.webView];

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //消除cell选择痕迹
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.2];
}

- (void)deselect
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}
//HeaderInSection  &&  FooterInSection

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    MarketDetailHeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"MarketDetailHeaderView" owner:nil options:nil] lastObject];
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor clearColor];
    return backView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
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
                NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
                [self.tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
            }];
        }
    }
    
}
- (void)dealloc {
    [_webView.scrollView removeObserver:self forKeyPath:@"contentSize" context:nil];
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

#pragma mark -- 返回
- (IBAction)leftBackButtonCLicked:(id)sender {
    [self.rt_navigationController popViewControllerAnimated:YES complete:nil];
}

#pragma mark -- 积分兑换
- (IBAction)jifenDuiHuanButtonClicked:(id)sender {
    
    [App_HttpsRequestTool jifenDuihuanWithgood_id:self.productDetailModel.good_id WithSuccess:^(id responseObject) {
        BaseResponse *response = [[BaseResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response isSuccess]) {
            
            PopSuccess(@"恭喜您兑换成功");
            
        }else{
            PopInfo(response.reason);
        }
        
    } failure:^(NSError *error) {
        PopError(netError);
    }];
    
}

@end
