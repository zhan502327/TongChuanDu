//
//  MarketListViewController.m
//  TongChuanDu
//
//  Created by zhandb on 2018/7/9.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "MarketListViewController.h"
#import "MarketImageViewCell.h"
#import "MarketProductTableViewCell.h"
#import "MarketDetailViewController.h"
#import "SDCycleScrollView.h"
#import "MarketCarViewController.h"
#import "MarketHeader.h"
#import "MarketBannerResponse.h"
#import "MarketListResponse.h"
#import "MarketViewController.h"



//扫描二维码
#import "LBXScanViewStyle.h"
#import "DIYScanViewController.h"
#import "StyleDIY.h"
#import "Global.h"
#import "QQLBXScanViewController.h"



static NSString *imageViewCell = @"MarketImageViewCell";
static NSString *productCell = @"MarketProductTableViewCell";

#define kCycleViewHeight 124


#define kGAP (10)
#define kItemWidth ((Current_Width - 3*kGAP)/2)
#define kItemHeight (kItemWidth + 85)
#define kSearchBarWidth 180

@interface MarketListViewController ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, SDCycleScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, weak) SDCycleScrollView *cycleView;

@property (weak, nonatomic) IBOutlet UIView *bannerView;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (weak, nonatomic) IBOutlet UIImageView *categoryOneImageView;
@property (weak, nonatomic) IBOutlet UIImageView *categoryTwoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *categoryThreeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *categoryFourImageView;
@property (weak, nonatomic) IBOutlet UILabel *categoryOneLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryTwoLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryThreeLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryFourLabel;

@property (nonatomic, strong) NSArray *categoryArray;

@end

@implementation MarketListViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.cycleView adjustWhenControllerViewWillAppera];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavgiationBarTitle:@""];
    
    [self configNavBar];

    [self configTableView];
    
    
    [self loadData];
    
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

- (void)configTableView{
    [self.tableView registerNib:[UINib nibWithNibName:imageViewCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:imageViewCell];
    [self.tableView registerNib:[UINib nibWithNibName:productCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:productCell];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self loadData];
    }];
    
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

- (void)loadData{
    //加载首页banner
    [App_HttpsRequestTool marketBannerRequestWithType:@"market" WithSuccess:^(id responseObject) {
        [self endRefresh];
        MarketBannerResponse *response = [[MarketBannerResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response isSuccess]) {
            NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
            
            for (MarketBannerModel *model in response.result) {
                
                [array addObject:model.imageurl];
            }
            self.cycleView.imageURLStringsGroup = array;
        }
    } failure:^(NSError *error) {
        [SVProgressHUDManager popTostErrorWithString:netError];
        [self endRefresh];
    }];
    
    //加载热门商品和最新商品
    [App_HttpsRequestTool marketHotListAndNewListRequestWithSuccess:^(id responseObject) {
        [self endRefresh];
        MarketListResponse *response = [[MarketListResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response isSuccess]) {
            NSArray *categoryarray = response.result.category;
            self.categoryArray = categoryarray;
            for (int i = 0; i<categoryarray.count; i++) {
                MarketListCategoryModel *model = categoryarray[i];
                if (i == 0) {
                    self.categoryOneLabel.text = model.title;
                    [self.categoryOneImageView sd_setImageWithURL:[NSURL URLWithString:model.path] placeholderImage:UseImage(@"Public_Image_Zheng_PlaceHolder")];
                    self.categoryOneImageView.layer.masksToBounds = YES;
                    self.categoryOneImageView.layer.cornerRadius = 3;
                }
                
                if (i == 1) {
                    self.categoryTwoLabel.text = model.title;
                    [self.categoryTwoImageView sd_setImageWithURL:[NSURL URLWithString:model.path] placeholderImage:UseImage(@"Public_Image_Zheng_PlaceHolder")];
                    self.categoryTwoImageView.layer.masksToBounds = YES;
                    self.categoryTwoImageView.layer.cornerRadius = 3;
                }
                
                if (i == 2) {
                    self.categoryThreeLabel.text = model.title;
                    [self.categoryThreeImageView sd_setImageWithURL:[NSURL URLWithString:model.path] placeholderImage:UseImage(@"Public_Image_Zheng_PlaceHolder")];
                    self.categoryThreeImageView.layer.masksToBounds = YES;
                    self.categoryThreeImageView.layer.cornerRadius = 3;
                }
                
                if (i == 3) {
                    self.categoryFourLabel.text = model.title;
                    [self.categoryFourImageView sd_setImageWithURL:[NSURL URLWithString:model.path] placeholderImage:UseImage(@"Public_Image_Zheng_PlaceHolder")];
                    self.categoryFourImageView.layer.masksToBounds = YES;
                    self.categoryFourImageView.layer.cornerRadius = 3;
                }
            }
            NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
            [array addObject:response.result.newlist];
            [array addObject:response.result.hotlist];
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:array];
            [self.tableView reloadData];
            
            
        }else{
            
            PopError(response.reason);
        }
        
        
    } failure:^(NSError *error) {
        [SVProgressHUDManager popTostErrorWithString:netError];
        [self endRefresh];
    }];
    
}

- (void)endRefresh{
    [self.tableView.mj_header endRefreshing];
}



#pragma mark - tableView delegate and tableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [self.dataSource[section] count];
    }else{
        return 1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 150;
    }else{
        NSUInteger itemCount = [self.dataSource[indexPath.section] count];
        
        CGFloat tem = (itemCount / 2);
        
        NSInteger row = ceilf(tem);

        if (row == 0) {
            return 0;
        }else{
            return (row * kItemHeight + (row + 1)*kGAP);
        }
//        return (3*kItemHeight + 4*kGAP);

    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        MarketListNewModel *model = self.dataSource[indexPath.section][indexPath.row];
        MarketImageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:imageViewCell];
        cell.model = model;
        return cell;
    }else{
        
        NSArray *hotArray = self.dataSource[indexPath.section];
        MarketProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:productCell];
        cell.hotArray = hotArray;
        [cell setItemClickedBlock:^(NSIndexPath *index) {
           
            MarketListHotModel *model = self.dataSource[indexPath.section][index.row];
            MarketDetailViewController *vc = [[MarketDetailViewController alloc] init];
            vc.goods_id = model.good_id;
            [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
            
        }];
        return cell;
        
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //消除cell选择痕迹
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.2];
    if (indexPath.section == 0) {
        
        MarketListNewModel *model = self.dataSource[indexPath.section][indexPath.row];
        
        MarketDetailViewController *vc = [[MarketDetailViewController alloc] init];
        vc.goods_id = model.good_id;
        [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
    }
}

- (void)deselect
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}
//HeaderInSection  &&  FooterInSection

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc]init];
    backView.frame = CGRectMake(0, 0, Current_Width, 50);
    backView.backgroundColor = [UIColor clearColor];
    MarketHeader *header = [[[NSBundle mainBundle] loadNibNamed:@"MarketHeader" owner:self options:nil] lastObject];
    if (section == 0) {
        [header.headerButton setTitle:@"最新商品" forState:UIControlStateNormal];
    }else{
        [header.headerButton setTitle:@"热门商品" forState:UIControlStateNormal];

    }
    [backView addSubview:header];
    
    return backView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
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


- (SDCycleScrollView *)cycleView{
    if (_cycleView == nil) {
        SDCycleScrollView *view = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, Current_Width, kCycleViewHeight) delegate:self placeholderImage:[UIImage imageNamed:@"Public_Image_Long_PlaceHolder"]];
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

- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        _dataSource = array;
    }
    return _dataSource;
}
- (IBAction)firstButtonClicked:(id)sender {
    
    if (self.categoryArray.count > 0) {
        MarketListCategoryModel *categoryModel = self.categoryArray[0];
        MarketViewController *vc = [[MarketViewController alloc] init];
        vc.categoryModel = categoryModel;
        [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
    }

}
- (IBAction)secondButtonCLicked:(id)sender {
    
    if (self.categoryArray.count > 1) {
        MarketListCategoryModel *categoryModel = self.categoryArray[1];
        MarketViewController *vc = [[MarketViewController alloc] init];
        vc.categoryModel = categoryModel;
        [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
    }

}
- (IBAction)thirdButtonCLicked:(id)sender {
    if (self.categoryArray.count > 2) {
        MarketListCategoryModel *categoryModel = self.categoryArray[2];
        MarketViewController *vc = [[MarketViewController alloc] init];
        vc.categoryModel = categoryModel;
        [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
    }

}
- (IBAction)fourthButtonCLicekd:(id)sender {
    if (self.categoryArray.count > 3) {
        MarketListCategoryModel *categoryModel = self.categoryArray[3];
        MarketViewController *vc = [[MarketViewController alloc] init];
        vc.categoryModel = categoryModel;
        [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
    }

}

@end
