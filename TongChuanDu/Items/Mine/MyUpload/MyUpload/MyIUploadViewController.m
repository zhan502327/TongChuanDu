//
//  MyIUploadViewController.m
//  TongChuanDu
//
//  Created by zhandb on 2018/7/15.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "MyIUploadViewController.h"
#import "SGPagingView.h"
#import "PersonUpLoadViewController.h"
#import "StudentUpLoadViewController.h"



@interface MyIUploadViewController ()<SGPageTitleViewDelegate, SGPageContentScrollViewDelegate>


@property (nonatomic, weak) SGPageTitleView *pageTitleView;

@property (nonatomic, weak) SGPageContentScrollView *pageContentView;

@end

@implementation MyIUploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavgiationBarTitle:@"我的上传"];

    [self pageTitleView];
    [self pageContentView];
}



- (SGPageTitleView *)pageTitleView{
    if (_pageTitleView == nil) {
        NSArray *titleArray = @[@"身份证",@"学生证"];
        SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
        configure.bottomSeparatorColor = HexColor(0XCCCCCC);
        configure.titleColor = HexColor(0X333333);
        configure.titleSelectedColor = HexColor(0X333333);
        configure.indicatorColor = HexColor(0XFF7800);
        
        configure.indicatorScrollStyle = SGIndicatorScrollStyleHalf;
        
        SGPageTitleView *titleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, Current_Width, 44) delegate:self titleNames:titleArray configure:configure];
        
        
        [self.view addSubview:titleView];
        _pageTitleView = titleView;
    }
    return _pageTitleView;
}

- (SGPageContentScrollView *)pageContentView{
    if (_pageContentView == nil) {
        PersonUpLoadViewController *oneVC = [[PersonUpLoadViewController alloc] init];
        oneVC.isFromeRegisterVC = self.isFromeRegisterVC;
        
        StudentUpLoadViewController *twoVC = [[StudentUpLoadViewController alloc] init];
        twoVC.isFromeRegisterVC = self.isFromeRegisterVC;

        NSArray *childArr = @[oneVC,twoVC];
        
        SGPageContentScrollView *contentView = [[SGPageContentScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.pageTitleView.frame), Current_Width, Current_Height - CGRectGetMaxY(self.pageTitleView.frame) - TabBar_Height) parentVC:self childVCs:childArr];
        contentView.delegatePageContentScrollView = self;
        
        [self.view addSubview:contentView];
        _pageContentView = contentView;
    }
    return _pageContentView;
}

//滚动内容视图的代理方法
- (void)pageContentScrollView:(SGPageContentScrollView *)pageContentScrollView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex{
        [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
    
}

//滚动标题视图的代理方法
- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex{
    [self.pageContentView setPageContentScrollViewCurrentIndex:selectedIndex];
}




- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action{
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:UseImage(@"App_NavBar_backImg_Icon") style:UIBarButtonItemStyleDone target:self action:@selector(popVC)];
    item.tintColor = [UIColor whiteColor];
    return item;
    
}

- (void)popVC{
    if (self.isFromeRegisterVC) {//返回首页
        
        for (UIViewController *vc in self.navigationController.viewControllers) {
            
            if ([vc isKindOfClass: NSClassFromString(@"MarketListViewController")]) {
                
                [self.rt_navigationController popToViewController:vc animated:YES complete:nil];
            }
        }
        
        
    }else{
        
        [self.rt_navigationController popViewControllerAnimated:YES complete:nil];
        
    }
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.isFromeRegisterVC == YES) {
        // 禁用iOS7返回手势
        
        self.rt_disableInteractivePop = YES;
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    // 开启
    self.rt_disableInteractivePop = NO;

    
}


@end
