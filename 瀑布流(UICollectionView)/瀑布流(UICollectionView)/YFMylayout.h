//
//  YFMylayout.h
//  瀑布流(UICollectionView)
//
//  Created by krisfeng on 16/2/3.
//  Copyright © 2016年 krisfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFMylayout : UICollectionViewFlowLayout
//定义一个数据模型属性 方便计算每一个item的宽高
@property(strong,nonatomic)NSMutableArray *girls;
//定义个列数 方便外部需求的改变
@property(assign,nonatomic)int colNum;

@end
