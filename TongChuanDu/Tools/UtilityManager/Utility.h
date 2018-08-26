//
//  Utility.h
//  JianZuLianApp
//
//  Created by 张帅 on 2017/9/14.
//  Copyright © 2017年 JianZuLian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utility : NSObject

/** 检测手机号是否正确 */
+ (BOOL)checkPhone:(NSString *)phoneNumber;

/** 把手机号第4-7位变成星号*/
+ (NSString*)phoneNumToAsterisk:(NSString*)phoneNum;

/** 把身份证号变成星号*/
+ (NSString*)idCardToAsterisk:(NSString*)idCard;

/** 把银行卡证号变成星号*/
+ (NSString*)bankCardToAsterisk:(NSString*)bankCard;

/** 得出当天是星期几*/
+ (NSString *)weekdayStringFromDate:(NSDate *)inputDate;

/** 性别 分类 男 女*/
+ (NSString *)sexString:(NSNumber *)num;

/** 时间戳转换成时间 */
+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString timeDateFormat:(NSString *)dateFormat;

/** 解决 [NSDate date] 获取时间 有时间差 增加8小时  得到 北京时间 */
+ (NSDate *)resolveTimeDifference:(NSDate *)currentDate;

/** 评分满意度 */
+ (NSString *)commentSatisfaction:(CGFloat)count;

/** 选择星星评分分值 */
+ (int)commentSatisfactionScroe:(NSUInteger)count;

/** 标示必填 */
+ (NSMutableAttributedString *)mustIdentifier:(NSString *)string;

/** 设备状态 */
+ (NSString *)equipmentStatus:(int)count;

/** 时间显示状态 */
+ (NSString *)formateDate:(NSString *)dateString;

#pragma mark - **************** 字符串相关
/** 显示原价（字符串上添加横线） */
+ (NSMutableAttributedString *)addStringLineString:(NSString *)string;

/** 设置不同字体 大小 和 颜色 (项目专属) */
+ (NSMutableAttributedString *)addStringColorOrFontString:(NSString *)string fontSize:(CGFloat)fontSize numString:(NSString *)numString firstLocation:(NSInteger)firstLocation;

/** 计算UILabel的高度(带有行间距的情况)*/
+ (CGFloat)getSpaceLabelHeightWithText:(NSString*)str font:(UIFont*)font labelWidth:(CGFloat)width;

/** 给UILabel设置行间距和字间距*/
+ (void)setLabelSpace:(UILabel*)label labelText:(NSString*)str font:(UIFont*)font;
@end
