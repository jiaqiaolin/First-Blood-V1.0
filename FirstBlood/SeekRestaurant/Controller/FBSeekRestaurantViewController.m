//
//  FBSeekRestaurantViewController.m
//  FirstBlood
//
//  Created by 林佳乔 on 16/4/18.
//  Copyright © 2016年 林佳乔. All rights reserved.
//

#import "FBSeekRestaurantViewController.h"
#import "FBBaseNavigationController.h"

#import "FBDishesSortView.h"
#import "FBAllDishesSortView.h"
#import "FBHotDistrictView.h"
#import "FBTopicView.h"
#import "FBHttpsServer.h"
#import "TopicArticleModel.h"
#import "FBSortByDishesViewController.h"
@interface FBSeekRestaurantViewController ()
/** abc*/
@property (nonatomic, strong) dispatch_source_t timer;
@property (nonatomic, strong) FBTopicView *FBTView;
@end

@implementation FBSeekRestaurantViewController
#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setNavBarWithAlpha:.8 barTintColor:[UIColor whiteColor] tintColor:[UIColor yellowColor]];
    [self.navigationController.navigationBar setTranslucent:NO];

//    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
//    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
//    dispatch_source_set_event_handler(timer, ^{
//        [self setNavBarWithAlpha:arc4random()%1000/1000. barTintColor:FB_RANDOM_COLOR tintColor:FB_RANDOM_COLOR];
//    });
//    self.timer = timer;
//    dispatch_resume(timer);
    
    UIScrollView* scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, FB_SCREEN_WIDTH, FB_SCREEN_HEIGHT)];
    [scrollView setContentSize:CGSizeMake(FB_SCREEN_WIDTH, 2 * FB_SCREEN_HEIGHT )];
    [scrollView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:scrollView];
    FBAllDishesSortView* view = [[FBAllDishesSortView alloc]initWithFrame:CGRectMake(0, 0, FB_SCREEN_WIDTH, FB_SCREEN_HEIGHT / 3.5) returnTagsBlock:^(NSInteger tags) {
        
        
        FBSortByDishesViewController* vc = [[FBSortByDishesViewController alloc]init];
        vc.tagID = tags;
        [self.navigationController pushViewController:vc animated:YES];
        NSLog(@"%@",[NSString stringWithFormat:@"%@%ld",FBSeekRestaurantTopicUrl,tags]);
        
        
    }];
    
    FBHotDistrictView* FBHDView = [[FBHotDistrictView alloc]initWithFrame:CGRectMake(0, FB_SCREEN_HEIGHT / 3.5, FB_SCREEN_WIDTH, FB_SCREEN_HEIGHT / 2.2)];
    
    _FBTView = [[FBTopicView alloc]initWithFrame:CGRectMake(0, FB_SCREEN_HEIGHT / 3.5 + FB_SCREEN_HEIGHT / 2.2, FB_SCREEN_WIDTH, FB_SCREEN_HEIGHT )];
    [scrollView addSubview:view];
    [scrollView addSubview:FBHDView];
    [scrollView addSubview:_FBTView];
    
    [self getModel];
    
}



#pragma mark - <UITableViewDelegate>

#pragma mark - <UITableViewDataSource>

#pragma mark - Private methods
//网络请求
-(void)getModel
{
    NSArray* array = @[@"A866913",@"A878499",@"A842743",@"A865884",@"A822309"];
    NSMutableArray *seekRestaurantTopicImgArray = [[NSMutableArray alloc]init];
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t serialQueue = dispatch_queue_create("com.FBLZJ.www", DISPATCH_QUEUE_SERIAL);
    for (NSInteger i = 0; i < 5; i++) {
        dispatch_group_async(group, serialQueue, ^{
            NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",FBSeekRestaurantTopicUrl,array[i]]];
            NSData *data = [NSData dataWithContentsOfURL:url];
            id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSDictionary* dic = result[@"data"][@"article"];
            NSString* str = [dic objectForKey:@"discoveryBanner"];
            
            NSURL *imgURL = [NSURL URLWithString:str];
            NSData* imgData = [NSData dataWithContentsOfURL:imgURL];
            UIImage *img = [UIImage imageWithData:imgData];
            [seekRestaurantTopicImgArray addObject:img];
            
            
        });
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        
        
        [self updateSeekRestaurantTopic:seekRestaurantTopicImgArray];
        
    });
    
    
}



-(void)updateSeekRestaurantTopic:(NSArray*)array
{
    for (NSInteger i = 0; i < array.count; i++) {
        UIButton *btn = [_FBTView.subviews objectAtIndex:(i+1)];
        [btn setBackgroundImage:array[i] forState:UIControlStateNormal];
    }
}

@end
