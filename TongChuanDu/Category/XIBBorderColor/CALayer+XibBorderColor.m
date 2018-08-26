//
//  CALayer+XibBorderColor.m
//  JZLLeaseApp
//
//  Created by zhangshuai on 2017/5/5.
//  Copyright © 2017年 zhangshuai. All rights reserved.
//

#import "CALayer+XibBorderColor.h"

@implementation CALayer (XibBorderColor)

- (void)setBorderColorWithUIColor:(UIColor *)color {
    
    self.borderColor = color.CGColor;
}

@end
