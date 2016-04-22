//
//  FBSortByDishesViewController.m
//  FirstBlood
//
//  Created by lanou on 16/4/22.
//  Copyright © 2016年 林佳乔. All rights reserved.
//

#import "FBSortByDishesViewController.h"
#import "FBShopTableViewCell.h"
#import "FBHttpsServer.h"
#import "FBSeekRestaurantModel.h"

typedef NS_ENUM(NSInteger, tasteType)
{
    西餐 = 3001,
    日料,
    甜品,
    中国菜,
    火锅,
    自助餐,
    酒吧,
    咖啡
};

@interface FBSortByDishesViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
}

@property (nonatomic, strong)NSDictionary *dic;
@property (nonatomic,retain)NSMutableArray* RestaurantListArray;

@end

@implementation FBSortByDishesViewController


#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dic = [NSDictionary dictionaryWithObjectsAndKeys:@"西餐",@"3001",@"日料",@"3002",@"甜品",@"3003",@"中国菜",@"3004",@"火锅",@"3005",@"自助餐",@"3006",@"酒吧",@"3007",@"咖啡",@"3008",nil];
    
    [self setTitle:@"探店"];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, FB_SCREEN_WIDTH, FB_SCREEN_HEIGHT - 64 - 44) style:UITableViewStylePlain];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    _tableView.estimatedRowHeight = 300;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_tableView];
    
    
    [self getModel];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
}




-(NSString*)getUrl
{
    NSString* str = [FBSortByDishesUrl stringByReplacingOccurrencesOfString:@"tagID=" withString:[NSString stringWithFormat:@"tagID=%ld",self.tagID]];
    return str;
}

#pragma mark - <UITableViewDelegate>

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellid = @"FBShopTableViewCell";
    FBShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FBShopTableViewCell" owner:nil options:nil] lastObject];
    }
    
    return cell;
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _RestaurantListArray.count;
}

#pragma mark - Private methods
//网络请求
-(void)getModel
{
    
    [[FBHttpsServer shareHttps]connectHttpsWithUrl:[self getUrl] model:httpsModelDefault method:get postBody:nil resultBlock:^(id result, NSURLResponse *response, NSError *error) {
        NSArray *array = result[@"data"][@"list"];
        for (NSDictionary* dic in array) {
            NSLog(@"dic = %@",dic);
            FBSeekRestaurantModel* model = [[FBSeekRestaurantModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.RestaurantListArray addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
        
        
    }];
    
    NSLog(@"count = %ld",_RestaurantListArray.count);
}


//懒加载形式(getter方法)
-(NSMutableArray*)RestaurantListArray
{
    if (!_RestaurantListArray) {
        self.RestaurantListArray = [NSMutableArray array];
    }
    return _RestaurantListArray;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
