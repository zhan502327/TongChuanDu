//
//  UIBarButtonItem+Badge.h
//  therichest
//
//  Created by Mike on 2014-05-05.
//  Copyright (c) 2014 Valnet Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Badge)

@property (strong, atomic) UILabel *badge;

/** 角标数值*/
@property (nonatomic) NSString *badgeValue;
/** 角标背景色*/
@property (nonatomic) UIColor *badgeBGColor;
/** 角标数值颜色*/
@property (nonatomic) UIColor *badgeTextColor;
/** 角标数值字号*/
@property (nonatomic) UIFont *badgeFont;
/** 角标数值尺寸*/
@property (nonatomic) CGFloat badgePadding;
/** 角标数值最小尺寸*/
@property (nonatomic) CGFloat badgeMinSize;
/** 角标数值的坐标位置*/
@property (nonatomic) CGFloat badgeOriginX;
@property (nonatomic) CGFloat badgeOriginY;
/** 角标数值是否等于0*/
@property BOOL shouldHideBadgeAtZero;
/** 角标数值变化时是否有动画*/
@property BOOL shouldAnimateBadge;

@end
