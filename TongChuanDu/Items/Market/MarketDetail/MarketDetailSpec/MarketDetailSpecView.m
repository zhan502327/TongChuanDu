//
//  MarketDetailSpecView.m
//  TongChuanDu
//
//  Created by zhandb on 2018/7/15.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "MarketDetailSpecView.h"
#import "MarketDetailSpecNumCell.h"
#import "MarketDetailSpecNormalCell.h"
#import "MarketDetaildataattrbute.h"
#import "IMJIETagView.h"
#import "MarketDetailSpecSelectResponse.h"

#define ktitleLabelHeight 40

#define kPlaceHolderStr @"占位符"



static NSString *specNumCell = @"MarketDetailSpecNumCell";
static NSString *specNormalCell = @"MarketDetailSpecNormalCell";


@interface MarketDetailSpecView ()<UITableViewDelegate, UITableViewDataSource>

//存储tagsFrame
@property (nonatomic, strong) NSMutableArray *tagsFrameArray;

//参数数组
@property (nonatomic, strong) NSMutableArray *attrbuteArray;


@property (nonatomic, strong) NSMutableArray *selectCategoryModelArray;


/**
 查询值后返回的model
 */
@property (nonatomic, strong) DBMarketDetailSpecSelectModel *resultModel;


/**
 购买商品数量
 */
@property (nonatomic, copy) NSString *selectNumStr;
/**
 规格id字符串
 */
@property (nonatomic, copy) NSString *attrvalue_id;

@end


@implementation MarketDetailSpecView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self = [[[NSBundle mainBundle] loadNibNamed:@"MarketDetailSpecView" owner:self options:nil] lastObject];
        self.frame = frame;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.selectNumStr = @"1";//默认最少购买1件
        [self configTableView];
        
    }
    return self;
}

- (void)setBottomButtonClickedType:(NSString *)bottomButtonClickedType{
    _bottomButtonClickedType = bottomButtonClickedType;
    //立即购买
    if ([bottomButtonClickedType isEqualToString:@"finishButtonNowBuy"]) {
        _bottomViewOne.hidden = NO;
        _bottomViewTwo.hidden = YES;
        
    }
    
    //加入购物车
    if ([bottomButtonClickedType isEqualToString:@"finishButtonAddCar"]) {
        
        _bottomViewOne.hidden = NO;
        _bottomViewTwo.hidden = YES;
    }
    
    //选择规格
    if ([bottomButtonClickedType isEqualToString:@"twoButton"]) {
        _bottomViewOne.hidden = YES;
        _bottomViewTwo.hidden = NO;
    }
}

- (void)setSpecArray:(NSArray *)specArray{
    _specArray = specArray;
    [self.tagsFrameArray removeAllObjects];
    
    for (MarketDetaildataattrbute *model in specArray) {//model - 颜色@[@"金色",@"银色",@"灰色"]//父数组
        
        NSMutableArray *categoryArray = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *attrbuteArray = [NSMutableArray arrayWithCapacity:0];
        for (MarketDetailattrvalue *categoryModel in model.attrvalue) {//子数组
            [categoryArray addObject:categoryModel.attrvalue];
            [attrbuteArray addObject:categoryModel];
            
        }
        [self.attrbuteArray addObject:attrbuteArray];
        
        IMJIETagFrame *tagsFrame = [[IMJIETagFrame alloc] init];
        tagsFrame.tagsMinPadding = 20;//标签内间距
        tagsFrame.tagsMargin = 20;//标签间距
        tagsFrame.tagsLineSpacing = 10;//标签行间距
        tagsFrame.tagsArray = categoryArray;
        
        [self.tagsFrameArray addObject:tagsFrame];
    }
}

- (void)configTableView{
    
    [self.tableView registerNib:[UINib nibWithNibName:specNormalCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:specNormalCell];
    
    [self.tableView registerNib:[UINib nibWithNibName:specNumCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:specNumCell];
    
}

#pragma mark - tableView delegate and tableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.specArray.count;
    }else{
        return 1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        IMJIETagFrame *frame = self.tagsFrameArray[indexPath.row];
        return (frame.tagsHeight + ktitleLabelHeight);
    }else{
        return 50;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        MarketDetaildataattrbute *model = self.specArray[indexPath.row];
        
        MarketDetailSpecNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:specNormalCell];
        cell.titleLabel.text = model.name;
        cell.tagsFrame = self.tagsFrameArray[indexPath.row];
        
        [cell setSelectIndexBlock:^(NSInteger selectTag) {
            MarketDetaildataattrbute *superSpecModel = self.attrbuteArray[indexPath.row];//父规格
            MarketDetailattrvalue *submodel = self.attrbuteArray[indexPath.row][selectTag];//子规格
            
            [self.selectCategoryModelArray replaceObjectAtIndex:indexPath.row withObject:submodel];
            
            [self configselectCategoryIDArray:self.selectCategoryModelArray];
            
            NSString *allValueStr = @"已选择：";
            for (MarketDetailattrvalue *subModel in self.selectCategoryModelArray) {
                if (![subModel.attrvalue isEqualToString:kPlaceHolderStr]) {
                    allValueStr = [allValueStr stringByAppendingString:[NSString stringWithFormat:@" \"%@\"",subModel.attrvalue]];
                }
            }
            self.specLable.text = allValueStr;
            
        }];
        return cell;
    }else{
        MarketDetailSpecNumCell *cell = [tableView dequeueReusableCellWithIdentifier:specNumCell];
        
        //商品数量增加
        
        __weak typeof(cell) weakcell = cell;
        
        [cell setProductNumAddBlock:^(NSInteger count) {
            
            if (self.resultModel.stock.length > 0) {
                
                if (count > [self.resultModel.stock integerValue]) {
                    weakcell.numLabel.text = self.resultModel.stock;
                }else{
                    weakcell.numLabel.text = [NSString stringWithFormat:@"%ld",(long)count];
                }
            }else{
                weakcell.numLabel.text = [NSString stringWithFormat:@"%ld",(long)count];
            }
            
            self.selectNumStr = weakcell.numLabel.text;
        }];
        
        //商品数量减少
        [cell setProductNumDeleteBlock:^(NSInteger count) {
            if (self.resultModel.stock.length > 0) {
                
                if (count > [self.resultModel.stock integerValue]) {
                    weakcell.numLabel.text = self.resultModel.stock;
                    
                }else{
                    weakcell.numLabel.text = [NSString stringWithFormat:@"%ld",(long)count];
                    
                }
                
            }else{
                weakcell.numLabel.text = [NSString stringWithFormat:@"%ld",(long)count];
                
            }
            
            self.selectNumStr = weakcell.numLabel.text;
            
            
        }];
        return cell;
    }
}


#pragma mark -- 判断是否包含空model
- (BOOL)isContainObjectWith:(NSMutableArray *)selectCategoryModelArray{
    for (MarketDetailattrvalue *subModel in selectCategoryModelArray) {
        if ([subModel.attrvalue isEqualToString:kPlaceHolderStr]) {
            return YES;
        }
    }
    return NO;
}


#pragma mark -- 根据规格id 查询 价格
- (void)configselectCategoryIDArray:(NSMutableArray *)selectCategoryModelArray{
    NSLog(@"selectCategoryModelArray == %@",selectCategoryModelArray);
    BOOL isContain = [self isContainObjectWith:selectCategoryModelArray];
    if (isContain == NO) {//全选的情况下，可以网络请求
        
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        //根据规格id 查询库存数据
        for (MarketDetailattrvalue *subModel in selectCategoryModelArray) {
            [array addObject:subModel.attrvalue_id];
            
        }
        
        NSString *attrvalue_id = [array componentsJoinedByString:@","];
        
        self.attrvalue_id = attrvalue_id;
        
        [App_HttpsRequestTool clickProductCategoryGetPriceWithgoods_id:self.goods_id attrvalue_id:attrvalue_id Success:^(id responseObject) {
            
            MarketDetailSpecSelectResponse *response = [[MarketDetailSpecSelectResponse alloc] initWithDictionary:responseObject error:nil];
            if ([response isSuccess]) {
                DBMarketDetailSpecSelectModel *resultModel = response.result;
                self.resultModel = resultModel;
                
                //图片
                [self.productImageView sd_setImageWithURL:[NSURL URLWithString:resultModel.cover] placeholderImage:UseImage(@"Public_Image_Zheng_PlaceHolder")];
                
                //价格
                self.priceLabel.text = [NSString stringWithFormat:@"¥ %@",resultModel.price];
                
                //库存
                self.saveLabel.text = [NSString stringWithFormat:@"剩余库存%@件",resultModel.stock];
                if ([resultModel.stock isEqualToString:@"0"] || resultModel.stock.length == 0) {
                    self.finishButton.enabled = NO;
                    self.nowBuyButton.enabled = NO;
                    self.addCarButton.enabled = NO;
                }else{
                    self.finishButton.enabled = YES;
                    self.nowBuyButton.enabled = YES;
                    self.addCarButton.enabled = YES;
                }
            }else{
                
                self.finishButton.enabled = NO;
                self.nowBuyButton.enabled = NO;
                self.addCarButton.enabled = NO;
                
                //图片
                [self.productImageView sd_setImageWithURL:[NSURL URLWithString:self.productModel.path] placeholderImage:UseImage(@"Public_Image_Zheng_PlaceHolder")];

                
                //价格
                self.priceLabel.text = [NSString stringWithFormat:@"¥ %@",self.productModel.price];
                
                //库存
                self.saveLabel.text = @"暂无库存";
                
                
            }
        } failure:^(NSError *error) {
            PopError(netError);
        }];
    }
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
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor clearColor];
    return backView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.00000001;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor clearColor];
    return backView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.00000001;
}

#pragma mark -- 加入购物车
- (IBAction)addCarButtonClicled:(id)sender {
    
    [self addCar];
    
}

- (void)addCar{
    BOOL isContain = [self isContainObjectWith:self.selectCategoryModelArray];
    if (isContain == NO){//全选的情况下，可以网络请求
        
        NSLog(@"self.selectNumStr == %@",self.selectNumStr);
        
        [App_HttpsRequestTool marketShoppingCarAddProductRequestDataForProduct_id:self.goods_id buynum:self.selectNumStr price:self.resultModel.price goods_attr_store_id:self.resultModel.goods_attr_store_id attrvalue_id:self.attrvalue_id remark:@"" withSuccess:^(id responseObject) {
            BaseResponse *result = [[BaseResponse alloc] initWithDictionary:responseObject error:nil];
            if ([result isSuccess]) {
                [SVProgressHUDManager popTostSuccessWithString:@"添加成功"];
            }else{
                [SVProgressHUDManager popTostErrorWithString:result.reason];
            }
            
        } failure:^(NSError *error) {
            [SVProgressHUDManager popTostErrorWithString:netError];
        }];
        
    }else{
        for (MarketDetailattrvalue *subModel in self.selectCategoryModelArray) {
            if ([subModel.attrvalue_id isEqualToString:kPlaceHolderStr]) {
                NSInteger index = [self.selectCategoryModelArray indexOfObject:subModel];
                MarketDetaildataattrbute *model = self.specArray[index];
                NSString *tips = [NSString stringWithFormat:@"请选择商品\"%@\"",model.name];
                PopInfo(tips);
                return;
            }
            
        }
        
    }
}

#pragma mark -- 立即购买
- (IBAction)nowBuyButtonCLicked:(id)sender {
    
    [self nowBuy];

    
}

- (void)nowBuy{
    
    BOOL isContain = [self isContainObjectWith:self.selectCategoryModelArray];
    if (isContain == NO){//全选的情况下，可以网络请求
        
        NSLog(@"self.selectNumStr == %@",self.selectNumStr);
        
        
        if (_nowBuyButtonBlock) {
            _nowBuyButtonBlock(self.resultModel.goods_attr_store_id, self.attrvalue_id, self.selectNumStr, self.resultModel.price);
        }
        
    }else{
        for (MarketDetailattrvalue *subModel in self.selectCategoryModelArray) {
            if ([subModel.attrvalue_id isEqualToString:kPlaceHolderStr]) {
                NSInteger index = [self.selectCategoryModelArray indexOfObject:subModel];
                MarketDetaildataattrbute *model = self.specArray[index];
                NSString *tips = [NSString stringWithFormat:@"请选择商品\"%@\"",model.name];
                PopInfo(tips);
                return;
            }
            
        }
        
    }
}
#pragma mark -- 完成
- (IBAction)finishButtonCLicekd:(id)sender {
    //立即购买
    if ([self.bottomButtonClickedType isEqualToString:@"finishButtonNowBuy"]) {
        [self nowBuy];

    }
    
    //加入购物车
    if ([self.bottomButtonClickedType isEqualToString:@"finishButtonAddCar"]) {
        [self addCar];
    }
}

- (NSMutableArray *)tagsFrameArray{
    if (_tagsFrameArray == nil) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        _tagsFrameArray = array;
    }
    return _tagsFrameArray;
}

- (NSMutableArray *)attrbuteArray{
    if (_attrbuteArray == nil) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        _attrbuteArray = array;
    }
    return _attrbuteArray;
}

- (NSMutableArray *)selectCategoryModelArray{
    if (_selectCategoryModelArray == nil) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        for (int i = 0; i<self.attrbuteArray.count; i++) {
            MarketDetailattrvalue *attrvalue = [[MarketDetailattrvalue alloc] init];
            attrvalue.attrvalue = kPlaceHolderStr;
            attrvalue.attrvalue_id = kPlaceHolderStr;
            [array addObject:attrvalue];
            
        }
        _selectCategoryModelArray = array;
    }
    return _selectCategoryModelArray;
}


@end
