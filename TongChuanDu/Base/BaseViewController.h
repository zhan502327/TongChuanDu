//
//  BaseViewController.h
//  JianZuLianApp
//
//  Created by 张帅 on 2017/9/7.
//  Copyright © 2017年 JianZuLian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController


@property (nonatomic, copy) void(^refreshDataBlock)();


/** NavgiationBar标题 */
- (void)setNavgiationBarTitle:(NSString *)string;





@end
