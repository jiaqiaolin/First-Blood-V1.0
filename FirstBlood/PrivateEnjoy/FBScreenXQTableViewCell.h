//
//  FBScreenXQTableViewCell.h
//  FirstBlood
//
//  Created by lanou on 16/4/22.
//  Copyright © 2016年 林佳乔. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBScreenXQModel.h"

@interface FBScreenXQTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *theme;
@property (weak, nonatomic) IBOutlet UILabel *nowPrice;
@property (weak, nonatomic) IBOutlet UILabel *consumer;
@property (weak, nonatomic) IBOutlet UILabel *orgPrice;

-(void)getDataModel:(FBScreenXQModel *)model;
@end
