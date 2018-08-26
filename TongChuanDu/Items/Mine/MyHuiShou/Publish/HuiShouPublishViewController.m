//
//  HuiShouPublishViewController.m
//  TongChuanDu
//
//  Created by zhandb on 2018/7/30.
//  Copyright © 2018年 zhandb. All rights reserved.
//

#import "HuiShouPublishViewController.h"
#import "HuishouPublishTextFieldCell.h"
#import "HuishouPublishButtonCell.h"
#import "HuiShouPublishPhotoCell.h"
#import "PGDatePickManager.h"
#import "ZZYPhotoHelper.h"



static NSString *textfieldCellID = @"HuishouPublishTextFieldCell";
static NSString *buttonCellID = @"HuishouPublishButtonCell";
static NSString *photoCellID = @"HuiShouPublishPhotoCell";

@interface HuiShouPublishViewController ()<UITableViewDelegate, UITableViewDataSource, PGDatePickerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSArray *placeHolderArray;

@property (nonatomic, copy) NSString *phoneTypeStr;
@property (nonatomic, copy) NSString *phoneColorStr;
@property (nonatomic, copy) NSString *phoneNeiCunStr;
@property (nonatomic, copy) NSString *buyTimeStr;
@property (nonatomic, copy) NSString *useTimeStr;
@property (nonatomic, copy) NSString *jiNewStr;
@property (nonatomic, assign) BOOL isYes;
@property (nonatomic, strong) NSData *imageData;
@property (nonatomic, weak) PGDatePickManager *datePickerManager;


@end

@implementation HuiShouPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavgiationBarTitle:@"回收发布"];
    
    [self configTabelView];
    
    self.isYes = NO;
    
}
- (void)configTabelView{
    
    [self.tableView registerNib:[UINib nibWithNibName:textfieldCellID bundle:[NSBundle mainBundle]] forCellReuseIdentifier:textfieldCellID];
    
    [self.tableView registerNib:[UINib nibWithNibName:buttonCellID bundle:[NSBundle mainBundle]] forCellReuseIdentifier:buttonCellID];

    [self.tableView registerNib:[UINib nibWithNibName:photoCellID bundle:[NSBundle mainBundle]] forCellReuseIdentifier:photoCellID];

}



#pragma mark - tableView delegate and tableView dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 7) {
        return 300;
    }else{
        return 50;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2) {//手机型号  颜色  内存
        
        HuishouPublishTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:textfieldCellID];
        cell.mouthLabel.hidden = YES;
        cell.titleLabel.text = self.dataSource[indexPath.row];
        cell.resultTextField.placeholder = self.placeHolderArray[indexPath.row];
        cell.resultTextField.tag = (100 + indexPath.row);
        [cell.resultTextField addTarget:self action:@selector(resultTextFieldClicked:) forControlEvents:UIControlEventEditingChanged];
        
        return cell;
        
    }else if (indexPath.row == 3){//购买时间
        
        HuishouPublishTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:textfieldCellID];
        cell.mouthLabel.hidden = YES;
        cell.titleLabel.text = self.dataSource[indexPath.row];
        cell.resultTextField.placeholder = self.placeHolderArray[indexPath.row];
        if (self.buyTimeStr.length > 0) {
            cell.resultTextField.text = self.buyTimeStr;
        }
        cell.resultTextField.enabled = NO;
        
        return cell;
        
    }else if (indexPath.row == 4){//使用时间
        HuishouPublishTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:textfieldCellID];
        cell.titleLabel.text = self.dataSource[indexPath.row];
        cell.mouthLabel.hidden = NO;
        cell.resultTextField.keyboardType = UIKeyboardTypeNumberPad;
        cell.resultTextField.placeholder = self.placeHolderArray[indexPath.row];
        cell.resultTextField.tag = (100 + indexPath.row);
        [cell.resultTextField addTarget:self action:@selector(resultTextFieldClicked:) forControlEvents:UIControlEventEditingChanged];
        
        return cell;
        
    }else if (indexPath.row == 5){//几成新
        HuishouPublishTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:textfieldCellID];
        cell.mouthLabel.hidden = YES;
        cell.titleLabel.text = self.dataSource[indexPath.row];
        cell.resultTextField.placeholder = self.placeHolderArray[indexPath.row];
        if (self.jiNewStr.length > 0) {
            cell.resultTextField.text = self.jiNewStr;
        }
        cell.resultTextField.enabled = NO;
        
        return cell;
    }else if (indexPath.row == 6){//是否维修过
        HuishouPublishButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:buttonCellID];
        cell.titleLaebl.text = self.dataSource[indexPath.row];
        
        //是
        [cell setYesButtonBlock:^{
            self.isYes = YES;
        }];
        
        //否
        [cell setNoButtonBlock:^{
            self.isYes = NO;
        }];
        
        return cell;
    }else{
        
        HuiShouPublishPhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:photoCellID];
        
        if (self.imageData.length > 0) {
            cell.photoImageView.image = [UIImage imageWithData:self.imageData];
        }
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClicked)];
        [cell.photoImageView addGestureRecognizer:tap];
        
        [cell setCommitButtonBlock:^{
            [self commitHuiShou];
            
        }];
        
        return cell;
    }
    
}

#pragma mark -- 图片点击事件
- (void)imageViewClicked{
    
//    WeakSelf;
    [[ZZYPhotoHelper shareHelper] showImageViewSelcteWithResultBlock:^(id data) {
        
        NSData *imagedata = UIImageJPEGRepresentation((UIImage *)data, 0.5);
        self.imageData = imagedata;
        
        NSIndexPath *index = [NSIndexPath indexPathForRow:7 inSection:0];
        
        [self.tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
        
    }];
    
}

#pragma mark -- 发布回收
- (void)commitHuiShou{
    
    if (self.phoneTypeStr.length == 0) {
        PopInfo(@"请输入手机型号");
        return;
    }
    if (self.phoneColorStr.length == 0) {
        PopInfo(@"请输入手机颜色");
        return;
    }
    if (self.phoneNeiCunStr.length == 0) {
        PopInfo(@"请输入手机内存");
        return;
    }
    if (self.buyTimeStr.length == 0) {
        PopInfo(@"请选择购买时间");
        return;
    }
    if (self.useTimeStr.length == 0) {
        PopInfo(@"请输入使用时间");
        return;
    }
    if (self.jiNewStr.length == 0) {
        PopInfo(@"请选择几成新");
        return;
    }
    if (self.imageData.length == 0) {
        PopInfo(@"请上传手机照片");
        return;
    }
    
    NSString *isrepair = self.isYes == YES ? @"1" : @"0";
    
    [App_HttpsRequestTool publishHuishouWithspec:self.phoneTypeStr storage:self.phoneNeiCunStr color:self.phoneColorStr buytime:self.buyTimeStr usingtime:self.useTimeStr isrepair:isrepair hownew:self.jiNewStr cover:self.imageData Success:^(id responseObject) {
        
        BaseResponse *response = [[BaseResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response isSuccess]) {
            
            [self.rt_navigationController popViewControllerAnimated:YES complete:nil];
            
            if (self->_refreshDataAfterPublishBlock) {
                self->_refreshDataAfterPublishBlock();
            }
            
        }else{
            
            PopInfo(response.reason);
        }
    } failure:^(NSError *error) {
        
        PopError(netError);
    }];
    
    
    
}

- (void)resultTextFieldClicked:(UITextField *)textField{
    
    if (textField.tag == 100) {//手机型号
        self.phoneTypeStr = textField.text;
        
    }
    
    if (textField.tag == 101) {//手机颜色
        self.phoneColorStr = textField.text;
    }
    
    if (textField.tag == 102) {//手机内存
        self.phoneNeiCunStr = textField.text;
    }
    
    if (textField.tag == 104) {//使用时间
        self.useTimeStr = textField.text;
    }
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //消除cell选择痕迹
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.2];
    
    if (indexPath.row == 3) {//购买时间
        [self datePickerManager];
    }
    
    if (indexPath.row == 5) {//几成新
        
        [self showNewOrOldWith:indexPath];
        
    }
    
}

#pragma mark --- 几成新
- (void)showNewOrOldWith:(NSIndexPath *)index{
    
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    NSArray *array = @[@"一成新",@"二成新",@"三成新",@"四成新",@"五成新",@"六成新",@"七成新",@"八成新",@"九成新",@"十成新"];
    
    for (NSString *str in array) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:str style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           
            self.jiNewStr = str;
            
            [self.tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
            
        }];
        
        [vc addAction:action];
    }
    
    
    [self presentViewController:vc animated:YES completion:nil];
    
}

- (void)deselect
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}


- (NSArray *)dataSource{
    if (_dataSource == nil) {
        NSArray *array = @[@"手机型号",@"颜色",@"内存",@"购买时间",@"使用时间",@"几成新",@"是否维修过",@""];
        _dataSource = array;
    }
    return _dataSource;
}

- (NSArray *)placeHolderArray{
    if (_placeHolderArray == nil) {
        
        NSArray *array = @[@"请输入手机型号",@"请输入颜色",@"请输入内存",@"请选择购买时间",@"请输入使用时间",@"请选择几成新",@"是否维修过",@""];
        _placeHolderArray = array;
    }
    return _placeHolderArray;
}

- (PGDatePickManager *)datePickerManager{
    if (_datePickerManager == nil) {
        
        
        PGDatePickManager *datePickManager = [[PGDatePickManager alloc]init];
        datePickManager.isShadeBackgroud = true;
        PGDatePicker *datePicker = datePickManager.datePicker;
        datePicker.delegate = self;
        datePicker.datePickerType = PGPickerViewType1;
        datePicker.isHiddenMiddleText = false;
        datePicker.datePickerMode = PGDatePickerModeDate;
        [self presentViewController:datePickManager animated:NO completion:nil];
        
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
//        dateFormatter.dateFormat = @"yyyy-MM-dd";
//
//        datePicker.minimumDate = [dateFormatter dateFromString: @"2010-01-01"];
//        datePicker.maximumDate = [dateFormatter dateFromString: @"2020-01-18"];
//
//        NSDate *date = [dateFormatter dateFromString: @"2019-01-18"];
//        [datePicker setDate:date animated:true];
        
        _datePickerManager = datePickManager;
        
        
    }
    return _datePickerManager;
}

- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents{
    
    NSString *timeStr = [NSString stringWithFormat:@"%ld年%.2ld月%.2ld日",dateComponents.year, dateComponents.month, dateComponents.day];
    self.buyTimeStr = timeStr;
    
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:3 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}


@end
