//
//  YFGirlsModel.h
//  瀑布流(UICollectionView)
//
//  Created by krisfeng on 16/2/3.
//  Copyright © 2016年 krisfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFGirlsModel : NSObject
//头像
@property(copy,nonatomic)NSString *icon;
//价格
@property(copy,nonatomic)NSString *price;
//高
@property(assign,nonatomic)int height;
//宽
@property(assign,nonatomic)int width;

-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype)girlsWithDict:(NSDictionary *)dict;

@end
