//
//  HomeViewController.m
//  TongChuanDu
//
//  Created by zhandb on 2018/8/3.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "HomeViewController.h"
#import "MarketCarViewController.h"
#import "HomeImageResponse.h"
#import "HomeInfoViewController.h"

//扫描二维码
#import "LBXScanViewStyle.h"
#import "DIYScanViewController.h"
#import "StyleDIY.h"
#import "Global.h"
#import "QQLBXScanViewController.h"


#define kSearchBarWidth 180


@interface HomeViewController ()<UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;

@property (nonatomic, strong) UISearchBar *searchBar;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftImageViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftImageVIewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightImageViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightImageViewHeight;

@end

@implementation HomeViewController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavgiationBarTitle:@""];
    
    [self configNavBar];
    
    
    [self configImageView];
    
    
}

- (void)configImageView{
    
    
    
    UITapGestureRecognizer *leftTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftImageViewClicked)];
    
    [self.leftImageView addGestureRecognizer:leftTap];
    
    
    UITapGestureRecognizer *rightTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightImageViewClicked)];
    
    [self.rightImageView addGestureRecognizer:rightTap];
    

}

- (void)leftImageViewClicked{
    HomeInfoViewController *vc = [[HomeInfoViewController alloc] init];
    [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
    

}

- (void)rightImageViewClicked{
    HomeInfoViewController *vc = [[HomeInfoViewController alloc] init];
    [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
}

- (void)loadData{
    
    [App_HttpsRequestTool appShouyewithSuccess:^(id responseObject) {
        
        HomeImageResponse *response = [[HomeImageResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response isSuccess]) {
            
            [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:response.result.backimg] placeholderImage:UseImage(@"")];
            
            [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:response.result.leftimg] placeholderImage:UseImage(@"")];
            
            
            [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:response.result.leftimg] placeholderImage:UseImage(@"") completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
               
                UIImage *leftImage = image;
                CGSize imageSize = leftImage.size;
                
                self.leftImageViewHeight.constant = (self.leftImageVIewWidth.constant * imageSize.height)/imageSize.width;
                
            }];
           
            
            [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:response.result.rightimg] placeholderImage:UseImage(@"") completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
                UIImage *rightImage = image;
                CGSize imageSize = rightImage.size;
                
                self.rightImageViewHeight.constant = (self.rightImageViewWidth.constant * imageSize.height)/imageSize.width;
                
            }];
      
            
            
        }else{
            PopInfo(response.reason);
            
        }
        
    } failure:^(NSError *error) {
        PopError(netError);
    }];
    
}


- (void)configNavBar{
    
    UIView *titleView = [[UIView alloc] init];
    titleView.frame = CGRectMake(50, 0, Current_Width - kSearchBarWidth, 30);
    
    [titleView addSubview:[self searchBar]];
    
    self.navigationItem.titleView = titleView;
    
    //左
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Makrket_Scan"] style:UIBarButtonItemStyleDone target:self action:@selector(scanButtonClicked)];
    leftItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    //右
    UIBarButtonItem *itemOne = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Market_car"] style:UIBarButtonItemStyleDone target:self action:@selector(carButtonClicked)];
    itemOne.tintColor = [UIColor whiteColor];
    UIBarButtonItem *itemTwo = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Market_share"] style:UIBarButtonItemStyleDone target:self action:@selector(shareButtonClicked)];
    itemTwo.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItems = @[itemTwo, itemOne];
    
}

#pragma mark -- 扫描二维码 点击事件
- (void)scanButtonClicked{
    //    [self openScanVCWithStyle:[StyleDIY weixinStyle]];
    
    //添加一些扫码或相册结果处理
    QQLBXScanViewController *vc = [QQLBXScanViewController new];
    vc.libraryType = [Global sharedManager].libraryType;
    vc.scanCodeType = [Global sharedManager].scanCodeType;
    vc.style = [StyleDIY qqStyle];
    
    //镜头拉远拉近功能
    vc.isVideoZoom = YES;
    [self.rt_navigationController pushViewController:vc animated:YES];
    
}

- (void)openScanVCWithStyle:(LBXScanViewStyle*)style
{
    DIYScanViewController *vc = [[DIYScanViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.style = style;
    vc.isOpenInterestRect = YES;
    vc.libraryType = [Global sharedManager].libraryType;
    vc.scanCodeType = [Global sharedManager].scanCodeType;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark -- 购物车 点击事件
- (void)carButtonClicked{
    
    MarketCarViewController *vc = [[MarketCarViewController alloc] init];
    [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
    
}

#pragma mark -- 分享 点击事件
- (void)shareButtonClicked{
    
}


- (UISearchBar *)searchBar{
    if (_searchBar == nil) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, Current_Width - kSearchBarWidth, 30)];
        _searchBar.placeholder = @"请输入商品名称";
        _searchBar.layer.masksToBounds = YES;
        _searchBar.layer.cornerRadius = 15;
        _searchBar.barStyle = UIBarStyleDefault;
        _searchBar.delegate = self;
        
        _searchBar.tintColor = [UIColor whiteColor];
        //设置背景图是为了去掉上下黑线
        _searchBar.backgroundImage = [[UIImage alloc] init];
        //self.searchBar.backgroundImage = [UIImage imageNamed:@"sexBankgroundImage"];
        //设置背景色
        _searchBar.backgroundColor = HexColor(0XFF7800);
        // 修改cancel
        _searchBar.showsCancelButton=NO;
        _searchBar.barStyle=UIBarStyleDefault;
        //    self.searchBar.keyboardType=UIKeyboardTypeNamePhonePad;
        //self.searchBar.searchBarStyle = UISearchBarStyleMinimal;//没有背影，透明样式
        _searchBar.delegate=self;
        // 修改cancel
        _searchBar.showsSearchResultsButton=NO;
        //5. 设置搜索Icon
        [_searchBar setImage:[UIImage imageNamed:@"Search_Icon"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
        /*这段代码有个特别的地方就是通过KVC获得到UISearchBar的私有变量
         
              searchField（类型为UITextField），设置SearchBar的边框颜色和圆角实际上也就变成了设置searchField的边框颜色和圆角，你可以试试直接设置SearchBar.layer.borderColor和cornerRadius，会发现这样做是有问题的。*/
        
        //一下代码为修改placeholder字体的颜色和大小
        
        UITextField *searchField = [_searchBar valueForKey:@"_searchField"];
        //2. 设置圆角和边框颜色
        if(searchField) {
            [searchField setBackgroundColor:[UIColor clearColor]];
            
            //        searchField.layer.borderColor = [UIColor colorWithRed:49/255.0f green:193/255.0f blue:123/255.0f alpha:1].CGColor;
            
            
            //        searchField.layer.borderWidth = 1;
            
            //        searchField.layer.cornerRadius = 23.0f;
            
            //        searchField.layer.masksToBounds = YES;
            
            
            // 根据@"_placeholderLabel.textColor" 找到placeholder的字体颜色
            
            [searchField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        }
        // 输入文本颜色
        
        searchField.textColor= [UIColor whiteColor];
        searchField.font= [UIFont systemFontOfSize:15];
        // 默认文本大小
        [searchField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
        //只有编辑时出现出现那个叉叉
        searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _searchBar;
}




@end
