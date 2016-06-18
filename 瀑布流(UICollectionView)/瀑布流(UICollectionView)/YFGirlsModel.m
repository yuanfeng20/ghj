//
//  YFGirlsModel.m
//  瀑布流(UICollectionView)
//
//  Created by krisfeng on 16/2/3.
//  Copyright © 2016年 krisfeng. All rights reserved.
//

#import "YFGirlsModel.h"

@implementation YFGirlsModel

-(instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)girlsWithDict:(NSDictionary *)dict{
    
    return [[self alloc]initWithDict:dict];
}

@end
