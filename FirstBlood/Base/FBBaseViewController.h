//
//  FBBaseViewController.h
//  FirstBlood
//
//  Created by 林佳乔 on 16/4/18.
//  Copyright © 2016年 林佳乔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBBaseViewController : UIViewController
/**
 *  设置NavigationBar的透明度 底色 文字颜色
 *
 *  @param alpha        透明度
 *  @param BarTintColor Bar底色
 *  @param tintColor    文字颜色
 */
- (void)setNavBarWithAlpha:(CGFloat)alpha barTintColor:(UIColor *)barTintColor tintColor:(UIColor *)tintColor;


//显示菊花效果
-(void)showHudInViewhint:(NSString *)string;

//隐藏菊花
-(void)showhide;

//显示提示框
-(void)showHint:(NSString *)string;

//判断网络状态
-(BOOL)isNetWork;

@end
