//
//  FBPrivateEnjoyViewController.m
//  FirstBlood
//
//  Created by 林佳乔 on 16/4/18.
//  Copyright © 2016年 林佳乔. All rights reserved.
//

#import "FBPrivateEnjoyViewController.h"
#import "NetWorkRequestManager.h"
#import "FBFoodPrivateModel.h"
#import "FBTableViewCell.h"
#import "FBPlayPrivateModel.h"
#import "FBFoodNearbyViewController.h"
#import "FBFoodXQViewController.h"
#import "FBScreenXQViewController.h"
#import "Button.h"



@interface FBPrivateEnjoyViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSInteger sortType;//标记请求类型 0 美食 1潮玩
}

@property (nonatomic,retain) NSMutableArray *FoodArray;
@property (nonatomic,retain) NSMutableArray *PlayArray;
@property (nonatomic,retain) UITableView * FoodTableview;
@property (nonatomic,retain) UITableView * PlayTableview;
@property (nonatomic,retain) UIScrollView * ScrollView;
@property (nonatomic,retain) UIView * view1;
@property (nonatomic,retain) UIView * view2;
@property (nonatomic,retain) UIView * view3;
@property (nonatomic,assign) BOOL condition;
@property (nonatomic,assign)NSInteger a;
@property (nonatomic,retain) Button * FoodButton;
@property (nonatomic,retain) Button * PlayButton;



@end

@implementation FBPrivateEnjoyViewController

#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    [self getButton];
    [self HttpData];
    [self PlayHttp];
    [self buttoncj];
    
    self.condition = NO;
    
    _ScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 104, FB_SCREEN_WIDTH, FB_SCREEN_HEIGHT)];
    _ScrollView.delegate = self;
    _ScrollView.pagingEnabled = YES;
    _ScrollView.contentSize = CGSizeMake(FB_SCREEN_WIDTH * 2, 0);
    [self.view addSubview:_ScrollView];
    
    
    _FoodTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, FB_SCREEN_WIDTH, FB_SCREEN_HEIGHT - 104)];
    _FoodTableview.delegate = self;
    _FoodTableview.dataSource = self;
    [_ScrollView addSubview:_FoodTableview];
    
    _PlayTableview = [[UITableView alloc]initWithFrame:CGRectMake(FB_SCREEN_WIDTH, 0, FB_SCREEN_WIDTH, FB_SCREEN_HEIGHT - 104)];
    _PlayTableview.delegate = self;
    _PlayTableview.dataSource = self;
    _PlayTableview.backgroundColor =[ UIColor orangeColor];
    [_ScrollView addSubview:_PlayTableview];
    
    
    
}
#pragma mark - <UITableViewDelegate>

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *str = @"cell";
    FBTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:str];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"FBTableViewCell" owner:self options:nil]lastObject];
    }
    
    if(tableView == self.FoodTableview){
        FBFoodPrivateModel * model;
        model = _FoodArray[indexPath.row];
        [cell getDataModel:model];
    }
    if (tableView == self.PlayTableview) {
        FBPlayPrivateModel *model1;
        model1 = _PlayArray[indexPath.row];
        [cell getDataModel1:model1];
    }
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.FoodTableview) {
        return self.FoodArray.count;
    }
    if (tableView == self.PlayTableview) {
        return self.PlayArray.count;
    }
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.FoodTableview) {
        
        if (indexPath.section == 0) {
            FBFoodXQViewController * foodxq = [[FBFoodXQViewController alloc]init];
            NSInteger num = _ScrollView.contentOffset.x/FB_SCREEN_WIDTH;
            foodxq.count = num;
            [self.navigationController pushViewController:foodxq animated:YES];
        }
    }
    
    else if (tableView == self.PlayTableview){
        if (indexPath.section == 0) {
            FBFoodXQViewController * foodxq = [[FBFoodXQViewController alloc]init];
            [self.navigationController pushViewController:foodxq animated:YES];
            
        }
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}

#pragma mark - <UITableViewDataSource>

#pragma mark - Private methods

-(void)buttoncj
{
    
    _view3 = [[UIView alloc]initWithFrame:CGRectMake(0, 64, FB_SCREEN_WIDTH, 40)];
    
    
    _FoodButton = [Button buttonWithType:UIButtonTypeCustom];
    [_FoodButton setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 3, 0, 60, 45)];
    [_FoodButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_FoodButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [_FoodButton setTitle:@"美食" forState:UIControlStateNormal];
     _FoodButton.titleLabel.font = [UIFont systemFontOfSize:16.];
    [_FoodButton addTarget:self action:@selector(FoodButton:) forControlEvents:UIControlEventTouchUpInside];
      self.navigationItem.titleView = _FoodButton;
    
    _PlayButton = [Button buttonWithType:UIButtonTypeCustom];
    [_PlayButton setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2, 0, 60, 45)];
    [_PlayButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_PlayButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [_PlayButton setTitle:@"潮玩" forState:UIControlStateNormal];
     _PlayButton.titleLabel.font = [UIFont systemFontOfSize:16.];
    [_PlayButton addTarget:self action:@selector(PlayButton:) forControlEvents:UIControlEventTouchUpInside];
      self.navigationItem.titleView = _PlayButton;
}

-(void)PlayHttp
{
    __weak typeof (self)bSelf = self;
    if ([self isNetWork] == YES) {
        [self showHudInViewhint:@"正在加载"];
        [NetWorkRequestManager requestWithType:GET urlString:@"http://oper.imeetin.com/rest/goods/listActive?page=1" parDic:nil finish:^(NSData *data) {
            
            [self showhide];
            NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray * array = [[dataDic objectForKey:@"data"]objectForKey:@"list"];
            for (NSDictionary *dict in array) {
                
                FBPlayPrivateModel *model = [FBPlayPrivateModel new];
                [model setValuesForKeysWithDictionary:dict];
                
                
                [bSelf.PlayArray addObject:model];
                
            }
            
            [_PlayTableview reloadData];
        } error:^(NSError *error) {
            [self showHint:@"服务器异常"];
            
        }];
    }else{
        [self showHint:@"当前网络异常请检测网络"];
    }
}


-(void)HttpData
{
    __weak typeof (self)bSelf = self;
    if ([self isNetWork] == YES) {
        [self showHudInViewhint:@"正在加载"];
        [NetWorkRequestManager requestWithType:GET urlString:@"http://oper.imeetin.com/rest/goods/listFood?page=1" parDic:nil finish:^(NSData *data) {
            
            [self showhide];
            NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray * array = [[dataDic objectForKey:@"data"]objectForKey:@"list"];
            for (NSDictionary *dict in array) {
                
                FBFoodPrivateModel *model = [FBFoodPrivateModel new];
                [model setValuesForKeysWithDictionary:dict];
                
                [bSelf.FoodArray addObject:model];
                
            }
            
            [_FoodTableview reloadData];
        } error:^(NSError *error) {
            [self showHint:@"服务器异常"];
            
        }];
    }else{
        [self showHint:@"当前网络异常请检测网络"];
    }
}


-(void)getButton
{
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 64, FB_SCREEN_WIDTH, 40)];
    
    [self.view addSubview:view1];
    
    UIButton * NearbyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    NearbyButton.frame = CGRectMake(10, 5, 40, 30);
    [NearbyButton setTitle:@"附近" forState:UIControlStateNormal];
    [NearbyButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    NearbyButton.titleLabel.font = [UIFont systemFontOfSize:15.];
    [NearbyButton addTarget:self action:@selector(NearbyButton:) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:NearbyButton];
    
    
    UIButton * FilterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    FilterButton.frame = CGRectMake(FB_SCREEN_WIDTH - 80, 5, 40, 30);
    [FilterButton setTitle:@"筛选" forState:UIControlStateNormal];
    [FilterButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    FilterButton.titleLabel.font = [UIFont systemFontOfSize:15.];
    [FilterButton addTarget:self action:@selector(FilterButton:) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:FilterButton];
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(FB_SCREEN_WIDTH - 40, 11, 20, 20)];
    image.image = [UIImage imageNamed:@"筛选.png"];
    [view1 addSubview:image];
    
    
}

-(void)NearbyButton:(UIButton *)button1
{
    NSInteger num = _ScrollView.contentOffset.x/FB_SCREEN_WIDTH;
    
    FBFoodNearbyViewController * neraby = [[FBFoodNearbyViewController alloc]init];
    
    neraby.count =num;
    
    [self.navigationController pushViewController:neraby animated:YES];
    
}

-(void)FilterButton:(UIButton *)button1
{
    NSInteger num = _ScrollView.contentOffset.x/FB_SCREEN_WIDTH;
    if (num == 0) {
        if (self.condition == NO) {
            [self screen1];
            
            self.condition = YES;
            
        }else
        {
            _view1.hidden = YES;
            self.condition = NO;
            
        }
    }if (num == 1) {
        if (self.condition == NO) {
            [self screen1];
            self.condition = YES;
            
        }else{
            _view1.hidden = YES;
            self.condition = NO;
        }
    }
    
}

-(void)screen2
{
    
}


-(void)screen1
{
    _view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 104, FB_SCREEN_WIDTH, FB_SCREEN_HEIGHT - 49)];
    _view1.alpha = 0.9;
    [self.view addSubview:_view1];
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, FB_SCREEN_WIDTH, FB_SCREEN_HEIGHT * 0.2)];
    view2.backgroundColor = [UIColor colorWithRed:230/255. green:228/255. blue:226/255. alpha:1];
    
    [_view1 addSubview:view2];
    
    _a = 0;
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
            
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.layer.borderColor = [[UIColor grayColor]CGColor];
            button.layer.borderWidth = 1.0f;
            button.layer.cornerRadius = 4;
            button.frame = CGRectMake (FB_SCREEN_WIDTH * 0.35 * j + 30,
                                       FB_SCREEN_HEIGHT * 0.07 * i
                                       +10,
                                       50,
                                       20);
            NSArray * array = @[@"brunch",@"午餐",@"下午茶",@"晚餐",@"西餐",@"日料",@"甜品",@"中餐",@"美酒"];
            
            [button setTitle:array[_a] forState:UIControlStateNormal];
            
            button.tag = _a;
            _a = _a+1;
            NSLog(@"%ld",button.tag);
            button.titleLabel.font = [UIFont systemFontOfSize:15.];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(Button:) forControlEvents:UIControlEventTouchUpInside];
            [view2 addSubview:button];
        }
    }
    
}

-(void)Button:(UIButton *)button12
{
    FBScreenXQViewController * screen = [[FBScreenXQViewController alloc]init];
    
    screen.count11= button12.tag;
    NSLog(@"%ld",screen.count11);
    [self.navigationController pushViewController:screen animated:YES];
    
    
}

-(void)FoodButton:(UIButton *)sender
{
    if (sender.selected == YES) {
        [self.FoodButton setStatus:YES];
        [self.FoodButton setStatus:NO];
    }else{
        [self.FoodButton setStatus:YES];
        [self.PlayButton setStatus:NO];
    }
    sender.selected = sender.selected;
}

-(void)PlayButton:(UIButton *)sender
{
    if (sender.selected == YES) {
        [self.PlayButton setStatus:YES];
        [self.FoodButton setStatus:NO];
    }else{
        [self.PlayButton setStatus:YES];
        [self.FoodButton setStatus:NO];
    }
    sender.selected = sender.selected;
}


#pragma mark - 懒加载
-(NSMutableArray *)FoodArray
{
    if (!_FoodArray) {
        self.FoodArray = [NSMutableArray array];
    }
    return _FoodArray;
}
-(NSMutableArray *)PlayArray
{
    if (!_PlayArray) {
        self.PlayArray = [NSMutableArray array];
    }
    return _PlayArray;
}



@end
