//
//  Utility.m
//  JianZuLianApp
//
//  Created by 张帅 on 2017/9/14.
//  Copyright © 2017年 JianZuLian. All rights reserved.
//

#import "Utility.h"

#define UILABEL_LINE_SPACE 6

@implementation Utility

+ (BOOL)checkPhone:(NSString *)phoneNumber {
    
    NSString *regex = @"^((13[0-9])|(147)|(199)|(15[^4,\\D])|(18[0-9])|(17[0-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:phoneNumber];
    if (!isMatch) {
        return NO;
    }
    return YES;
}

+ (NSString*)phoneNumToAsterisk:(NSString*)phoneNum {
    
    return [phoneNum stringByReplacingCharactersInRange:NSMakeRange(3,4)withString:@"****"];
}

+ (NSString*)idCardToAsterisk:(NSString*)idCard {
    
    return [idCard stringByReplacingCharactersInRange:NSMakeRange(1,idCard.length - 2)withString:@"**** **** **** ****"];
}

+ (NSString*)bankCardToAsterisk:(NSString*)bankCard {
    
    return [bankCard stringByReplacingCharactersInRange:NSMakeRange(0, bankCard.length - 4)withString:@"****  ****  ****  "];
}

+ (NSString *)weekdayStringFromDate:(NSDate *)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"日", @"一", @"二", @"三", @"四", @"五", @"六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone:timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    return [weekdays objectAtIndex:theComponents.weekday];
}

+ (NSString *)sexString:(NSNumber *)num {
    
    NSString *sexStr;
    if ([num intValue] == 1) {
        sexStr = @"男";
    }else{
        sexStr = @"女";
    }
    return sexStr;
}

+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString timeDateFormat:(NSString *)dateFormat {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateFormat:dateFormat]; //@"yyyy年MM月dd日 HH:mm:ss"
    long long int date1 = (long long int)[timeString intValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:date1];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (NSDate *)resolveTimeDifference:(NSDate *)currentDate {
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:currentDate];
    return [currentDate dateByAddingTimeInterval:interval];
}

+ (NSString *)commentSatisfaction:(CGFloat)count {
    
    NSString *commentStr;
    if (count == 1) {
        commentStr = @"很不满意";
    }else if (count == 2) {
        commentStr = @"不太满意";
    }else if (count == 3) {
        commentStr = @"满意";
    }else if (count == 4) {
        commentStr = @"比较满意";
    }else if (count == 5) {
        commentStr = @"非常满意";
    }
    return commentStr;
}

+ (int)commentSatisfactionScroe:(NSUInteger)count {
    
    int starCount;
    if (count == 6) {
        starCount = 1;
    }else if (count == 7) {
        starCount = 2;
    }else if (count == 8) {
        starCount = 3;
    }else if (count == 9) {
        starCount = 4;
    }else {
        starCount = 5;
    }
    return starCount;
}

+ (NSMutableAttributedString *)mustIdentifier:(NSString *)string {
    
    NSMutableAttributedString *mustIdStr = [[NSMutableAttributedString alloc]initWithString:string];
    [mustIdStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[[mustIdStr string] rangeOfString:@"* "]];
    return mustIdStr;
}

+ (NSString *)equipmentStatus:(int)count {
    
    NSString *statusStr;
    if (count == 0) {
        statusStr = @"该设备闲置中";
    }else if (count == 1) {
        statusStr = @"该设备已被预定";
    }else if (count == 2) {
        statusStr = @"该设备正常服务中";
    }else if (count == 3) {
        statusStr = @"该设备已报停";
    }else if (count == 4) {
        statusStr = @"该设备不可用";
    }else if (count == 5) {
        statusStr = @"该设备正在维修中";
    }else if (count == 6) {
        statusStr = @"该设备等待派工";
    }
    return statusStr;
}

+ (NSString *)formateDate:(NSString *)dateString {
    
    @try {
        // ------实例化一个NSDateFormatter对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        // ------这里的格式必须和DateString格式一致
        NSDate * nowDate = [NSDate date];
        // ------将需要转换的时间转换成 NSDate 对象
        NSDate * needFormatDate = [dateFormatter dateFromString:dateString];
        // ------取当前时间和转换时间两个日期对象的时间间隔
        NSTimeInterval time = [nowDate timeIntervalSinceDate:needFormatDate];
        NSLog(@"time----%f",time);
        // ------再然后，把间隔的秒数折算成天数和小时数：
        NSString *dateStr = [[NSString alloc] init];
        if (time <= 60) {
            //1分钟以内的
            dateStr = @"刚刚";
        }else if(time <= 60 * 60){
            //一个小时以内的
            int mins = time/60;
            dateStr = [NSString stringWithFormat:@"%d分钟前",mins];
        }else if(time <= 60 * 60 * 24){
            //在两天内的 [dateFormatter setDateFormat:@"YYYY-MM-dd"];
             NSString * need_yMd = [dateFormatter stringFromDate:needFormatDate];
            NSString *now_yMd = [dateFormatter stringFromDate:nowDate];
            [dateFormatter setDateFormat:@"HH:mm"];
            if ([need_yMd isEqualToString:now_yMd]) {
                //在同一天
                dateStr = [NSString stringWithFormat:@"今天 %@",[dateFormatter stringFromDate:needFormatDate]];
            }else{
                //昨天
                dateStr = [NSString stringWithFormat:@"昨天 %@",[dateFormatter stringFromDate:needFormatDate]];
            }
        }else {
            [dateFormatter setDateFormat:@"yyyy"];
            NSString * yearStr = [dateFormatter stringFromDate:needFormatDate];
            NSString *nowYear = [dateFormatter stringFromDate:nowDate];
            if ([yearStr isEqualToString:nowYear]) {
                //在同一年
                [dateFormatter setDateFormat:@"MM-dd"];
                dateStr = [dateFormatter stringFromDate:needFormatDate];
            }else{
                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                dateStr = [dateFormatter stringFromDate:needFormatDate];
            }
        } return dateStr;
    } @catch (NSException *exception) {
        return @"";
    }
}

#pragma mark - **************** 字符串相关
// ------显示原价（字符串上添加横线）
+ (NSMutableAttributedString *)addStringLineString:(NSString *)string {
    
    NSMutableAttributedString *oldPrice = [[NSMutableAttributedString alloc] initWithString:string];
    [oldPrice addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, oldPrice.length)];
    return oldPrice;
}

// ------设置不同字体 大小 和 颜色
+ (NSMutableAttributedString *)addStringColorOrFontString:(NSString *)string fontSize:(CGFloat)fontSize numString:(NSString *)numString firstLocation:(NSInteger)firstLocation {
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:string];
    NSInteger strRange = 0;
    if ([numString intValue] >= 0 && [numString intValue] < 10) {
        strRange = 1;
    }else if ([numString intValue] >= 10 && [numString intValue] < 100) {
        strRange = 2;
    }else if ([numString intValue] >= 100 && [numString intValue] < 1000) {
        strRange = 3;
    }else if ([numString intValue] >= 1000 && [numString intValue] < 10000) {
        strRange = 4;
    }else if ([numString intValue] >= 10000 && [numString intValue] < 1000000) {
        strRange = 5;
    }
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize] range:NSMakeRange(firstLocation, strRange)];
    [str addAttribute:NSForegroundColorAttributeName value:HexColor(0Xfc9d08) range:NSMakeRange(firstLocation, strRange)];
    return str;
}

//计算UILabel的高度(带有行间距的情况)
+ (CGFloat)getSpaceLabelHeightWithText:(NSString*)str font:(UIFont*)font labelWidth:(CGFloat)width {
   
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = UILABEL_LINE_SPACE;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f};
    
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}

//给UILabel设置行间距和字间距
+ (void)setLabelSpace:(UILabel*)label labelText:(NSString*)str font:(UIFont*)font {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = UILABEL_LINE_SPACE; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    label.attributedText = attributeStr;
}

@end
