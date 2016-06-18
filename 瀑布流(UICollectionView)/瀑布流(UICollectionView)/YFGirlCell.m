//
//  YFGirlCell.m
//  瀑布流(UICollectionView)
//
//  Created by krisfeng on 16/2/3.
//  Copyright © 2016年 krisfeng. All rights reserved.
//

#import "YFGirlCell.h"
#import "YFGirlsModel.h"
@interface YFGirlCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end
@implementation YFGirlCell


#pragma mark 重写数据模型的set方法
-(void)setGirlModel:(YFGirlsModel *)girlModel{
    
    
    _girlModel = girlModel;
    
    _iconView.image = [UIImage imageNamed:girlModel.icon];
    
    _priceLabel.text = girlModel.price;
    

}




@end
