//
//  FBFoodNearbyViewController.m
//  FirstBlood
//
//  Created by lanou on 16/4/21.
//  Copyright © 2016年 林佳乔. All rights reserved.
//

#import "FBFoodNearbyViewController.h"
#import "NetWorkRequestManager.h"
#import "FBNearbyModel.h"
#import "FBFoodNearbyTableViewCell.h"
#import "FBFoodXQViewController.h"
#import "FBFoodNeabyXQrViewController.h"

@interface FBFoodNearbyViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain) NSMutableArray *FoodNearbyArray;
@end

@implementation FBFoodNearbyViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"附近美食";
    [self Http];
    
}

-(void)Http
{
    __weak typeof (self)bSelf = self;
    if ([self isNetWork] == YES) {
          [self showHudInViewhint:@"正在加载"];
        
        
        NSArray *urlArray = @[FB_FoodNearByUrl,FB_PlayNearByUrl];
        
        [NetWorkRequestManager requestWithType:GET urlString:urlArray[_count] parDic:nil finish:^(NSData *data) {
            
            [self showhide];
            NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray * array = [[dataDic objectForKey:@"data"]objectForKey:@"list"];
            for (NSDictionary *dict in array) {
                
                FBNearbyModel *model = [FBNearbyModel new];
                [model setValuesForKeysWithDictionary:dict];
                
                [bSelf.FoodNearbyArray addObject:model];
             
            }
            [_Tableview1 reloadData];
        } error:^(NSError *error) {

            [self showHint:@"服务器异常"];
            
        }];
    }else{
        
        [self showHint:@"当前网络异常请检测网络"];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.FoodNearbyArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"cell";
    FBFoodNearbyTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:str];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"FBFoodNearbyTableViewCell" owner:self options:nil]lastObject];
        FBNearbyModel * model = self.FoodNearbyArray[indexPath.row];
        [cell getDataModel:model];
   
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     FBFoodNeabyXQrViewController* foodxq1 = [[FBFoodNeabyXQrViewController alloc]init];
    
    FBNearbyModel *model = self.FoodNearbyArray[indexPath.row];
    
    NSString * string = [NSString stringWithFormat:@"%@%@",FB_FoodNearXQByUrl,model.masterID];
     foodxq1.urlID = string;
    
    self.count = foodxq1.count;
    
    [self.navigationController pushViewController:foodxq1 animated:YES];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

-(NSMutableArray * )FoodNearbyArray
{
    if (!_FoodNearbyArray) {
        self.FoodNearbyArray = [NSMutableArray array];
    }
    return _FoodNearbyArray;
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
