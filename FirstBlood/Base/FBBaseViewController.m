//
//  FBBaseViewController.m
//  FirstBlood
//
//  Created by 林佳乔 on 16/4/18.
//  Copyright © 2016年 林佳乔. All rights reserved.
//

#import "FBBaseViewController.h"
#import "FBBaseNavigationController.h"
#import <MBProgressHUD.h>
#import <Reachability.h>

@interface FBBaseViewController ()

@end

@implementation FBBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)setNavBarWithAlpha:(CGFloat)alpha barTintColor:(UIColor *)barTintColor tintColor:(UIColor *)tintColor
{
    FBBaseNavigationController *FBBNC = (FBBaseNavigationController *)self.navigationController;
    [FBBNC setBarAlpha:alpha barTintColor:barTintColor tintColor:tintColor];
}
-(void)showHudInViewhint:(NSString *)string
{
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *HUD  = [[MBProgressHUD alloc] initWithView:view];
    HUD.labelText = string;
    HUD.tag = 1000;
    [view addSubview:HUD];
    [HUD show:YES];
}
-(void)showhide
{
    NSArray *array = [[UIApplication sharedApplication].delegate window].subviews;
    for (UIView *view in array) {
        if (view.tag == 1000) {
            [view removeFromSuperview];
        }
    }
}
-(void)showHint:(NSString *)string
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = string;
    //设置显示的类型
    hud.mode = MBProgressHUDModeText;
    hud.yOffset = 150.f;
    [hud hide:YES afterDelay:2];
}

-(BOOL)isNetWork
{
    BOOL isNetWork = NO;
    Reachability *reachability = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([reachability currentReachabilityStatus]) {
        case NotReachable:
        {
            NSLog(@"当前没有网络");
            isNetWork = NO;
        }
            break;
        case ReachableViaWiFi:
            isNetWork = YES;
            break;
        case ReachableViaWWAN:
            isNetWork = NO;
            break;
        default:
            break;
    }
    return isNetWork;
}

@end
