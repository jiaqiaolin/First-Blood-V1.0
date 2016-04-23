//
//  FBSortByDishesViewController.m
//  FirstBlood
//
//  Created by lanou on 16/4/22.
//  Copyright © 2016年 林佳乔. All rights reserved.
//

#import "FBSortByDishesViewController.h"
#import "FBShopTableViewCell.h"
#import "FBShopTableViewCell2.h"
#import "FBHttpsServer.h"
#import "FBSeekRestaurantModel.h"
#import "UIImageView+WebCache.h"


@interface FBSortByDishesViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSArray* _imgArray;
    
}


@property (nonatomic,retain)NSMutableArray* RestaurantListArray;
@property (nonatomic, strong) NSDictionary *dic;
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




//-(NSString*)getUrl
//{
//    NSString* str = [FBSortByDishesUrl stringByReplacingOccurrencesOfString:@"tagID=" withString:[NSString stringWithFormat:@"tagID=%ld",self.tagID]];
//    return str;
//}

#pragma mark - <UITableViewDelegate>

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    FBSeekRestaurantModel* model = _RestaurantListArray[indexPath.row];
    if (model.imgArray.count == 0) {
        static NSString *cellid = @"FBShopTableViewCell2";
        FBShopTableViewCell2 *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"FBShopTableViewCell2" owner:nil options:nil] objectAtIndex:0];
            
        }
        
        cell.nameLabel.text = model.name;
        if (self.tagID != 0) {
            NSString *str = [NSString stringWithFormat:@"%ld",self.tagID];
            cell.dishesType.text = [_dic objectForKey:str];
        }
        else
        {
            
            cell.dishesType.text =[_dic objectForKey:model.tagsArray.lastObject];
        }
        if (model.haveGoods == 1) {
            [cell.vipImgView setImage:[UIImage imageNamed:@"SeekRestaurantVip"]];
        }
        [cell.logoImageView sd_setImageWithURL:[NSURL URLWithString:model.logo]];
        cell.areaNameLabel.text = model.areaName;
        cell.avgPriceLabel.text = [NSString stringWithFormat:@"%ld",model.avgPrice];
        
        return cell;

    }
    
    else
    {
    static NSString *cellid = @"FBShopTableViewCell";
    FBShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FBShopTableViewCell" owner:nil options:nil] lastObject];
    }
    
    cell.nameLabel.text = model.name;
    if (self.tagID != 0) {
        NSString *str = [NSString stringWithFormat:@"%ld",self.tagID];
        cell.dishesType.text = [_dic objectForKey:str];
    }
    else
    {
        cell.dishesType.text =[_dic objectForKey:model.tagsArray.lastObject];
    }
        
    if (model.haveGoods == 1) {
        [cell.vipImgView setImage:[UIImage imageNamed:@"SeekRestaurantVip"]];
    }
    [cell.logoImageView sd_setImageWithURL:[NSURL URLWithString:model.logo]];
    cell.areaNameLabel.text = model.areaName;
    cell.avgPriceLabel.text = [NSString stringWithFormat:@"%ld",model.avgPrice];
    
    [self setbrightPointsLabelWithArray:model.brightPointsArray cell:cell];
    [cell.firstImage sd_setImageWithURL:[NSURL URLWithString:model.imgArray[0]]];
    [cell.secImageView sd_setImageWithURL:[NSURL URLWithString:model.imgArray[1]]];
    [cell.thirdImageView sd_setImageWithURL:[NSURL URLWithString:model.imgArray[2]]];
    
    
     return cell;
    }
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
    
    [[FBHttpsServer shareHttps]connectHttpsWithUrl:self.urlStr model:httpsModelDefault method:get postBody:nil resultBlock:^(id result, NSURLResponse *response, NSError *error) {
        NSArray *array = result[@"data"][@"list"];
        for (NSDictionary* dic in array) {
            FBSeekRestaurantModel* model = [[FBSeekRestaurantModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
     
            [self.RestaurantListArray addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
        
        
    }];
    
}



//给cell.brightPointsLabel赋值
-(void)setbrightPointsLabelWithArray:(NSArray*)array cell:(FBShopTableViewCell*)cell
{
    NSInteger labelCount = array.count;
    switch (labelCount) {
        case 0:
            cell.firstBrightPointLabel.text = @"";
            cell.dotLabel1.text = @"";
            cell.secBrightPointLabel.text = @"";
            cell.dotLabel2.text = @"";
            cell.thirdBrightPointLabel.text = @"";
            cell.dotLabel3.text = @"";
            break;
        case 1:
            cell.firstBrightPointLabel.text = array[0];
            cell.dotLabel1.text = @"";
            cell.secBrightPointLabel.text = @"";
            cell.dotLabel2.text = @"";
            cell.thirdBrightPointLabel.text = @"";
            cell.dotLabel3.text = @"";
            break;
        case 2:
            cell.firstBrightPointLabel.text = array[0];
            cell.secBrightPointLabel.text = array[1];
            cell.thirdBrightPointLabel.text = @"";
            cell.dotLabel3.text = @"";
            break;
        case 3:
            cell.firstBrightPointLabel.text = array[0];
            cell.secBrightPointLabel.text = array[1];
            cell.thirdBrightPointLabel.text = array[2];
            break;
        default:
            break;
    }
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
