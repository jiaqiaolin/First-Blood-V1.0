//
//  FBScreenXQViewController.m
//  FirstBlood
//
//  Created by lanou on 16/4/22.
//  Copyright © 2016年 林佳乔. All rights reserved.
//

#import "FBScreenXQViewController.h"
#import "NetWorkRequestManager.h"
#import "FBScreenXQModel.h"
#import "FBScreenXQTableViewCell.h"

@interface FBScreenXQViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,retain) NSMutableArray *FBScreenXQArray;


@end

@implementation FBScreenXQViewController

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    _Tableview.dataSource = self;
    _Tableview.delegate = self;
    [self Http];
    // Do any additional setup after loading the view from its nib.
}


-(void)Http
{
    __weak typeof (self)bSelf = self;
    if ([self isNetWork] == YES) {
        [self showHudInViewhint:@"正在加载"];
        
        NSArray *urlArray = @[FB_Food1ScreenUrl,FB_Food2ScreenUrl,FB_Food3ScreenUrl,FB_Food4ScreenUrl,FB_Food5ScreenUrl,FB_Food6ScreenUrl,FB_Food7ScreenUrl,FB_Food8ScreenUrl,FB_Food9ScreenUrl];
        
        
        [NetWorkRequestManager requestWithType:GET urlString:urlArray[_count11] parDic:nil finish:^(NSData *data) {
            
            [self showhide];
            NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray * array = [[dataDic objectForKey:@"data"]objectForKey:@"list"];
            for (NSDictionary *dict in array) {
                
                FBScreenXQModel *model = [FBScreenXQModel new];
                [model setValuesForKeysWithDictionary:dict];
                
                [bSelf.FBScreenXQArray addObject:model];
                NSLog(@"%@",dict);
                
            }
                [_Tableview reloadData];
        } error:^(NSError *error) {
            
            [self showHint:@"服务器异常"];
            
        }];
    }else{
        
        [self showHint:@"当前网络异常请检测网络"];
    }
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"cell";
    FBScreenXQTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:str];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"FBScreenXQTableViewCell" owner:self options:nil]lastObject];
        
        FBScreenXQModel * model = self.FBScreenXQArray[indexPath.row];
        NSLog(@"%@",self.FBScreenXQArray);
        [cell getDataModel:model];
    }
  
    return cell;
    
}

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.FBScreenXQArray.count;

   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return FB_SCREEN_WIDTH * 0.38;
}


-(NSMutableArray *)FBScreenXQArray
{
    if (!_FBScreenXQArray) {
        self.FBScreenXQArray = [NSMutableArray array];
    }
    return _FBScreenXQArray;
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
