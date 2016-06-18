//
//  YFMylayout.m
//  瀑布流(UICollectionView)
//
//  Created by krisfeng on 16/2/3.
//  Copyright © 2016年 krisfeng. All rights reserved.
//

#import "YFMylayout.h"
#import "YFGirlsModel.h"
@interface YFMylayout ()
//在这里定义个布局对象数组 设置所有item的frame
@property(strong,nonatomic)NSMutableArray *allLayouts;
//定义个字典数组 存放每一行（列item的Y值 ）列数和字典存放y值个数一致
@property(strong,nonatomic)NSMutableDictionary *dictY;
@end
@implementation YFMylayout

#pragma mark 调用方法一:刷新界面的时候调用
-(void)prepareLayout{
    
    [super prepareLayout];
    //当一刷新界面的时候就会加载数组中的数据 刷新出来的数据大于了数组中所能承受的范围就会崩溃
    //所以我们每刷新一次就把上一次的数据清除*************不理解为什么清除了数据 在刷新界面的时候还是承接上一次的数据往下刷
    [self.allLayouts removeAllObjects];
    self.dictY = nil;
    //定义个全局变量
    CGFloat margin = 10;
    //根据列数可以算出每一个item(cell)的width
    CGFloat cellW = ([UIScreen mainScreen].bounds.size.width-margin*(self.colNum+1))/self.colNum;

    
    //在这里里面 来根据模型属性 计算 所有Cell的UICollectionViewLayoutAttributes 布局对象
    //有多少个模型数据就有多少个cell（item）
    for (int i =0; i<self.girls.count ; i++) {
        
        //创建每一个布局对象(通过布局对象来对item进行设置frame)
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        UICollectionViewLayoutAttributes *eachLayout =[UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
        //获取模型数据 根据模型数据中的值来计算高(等比例)
        //每一个模型数据
        YFGirlsModel *model = self.girls[i];

        //宽：高=模型宽:模型高  计算高 宽*模型高/模型宽
        
        //高出来了
        CGFloat cellH = cellW*model.height/model.width;
        
        //计算列数
        int col = i%self.colNum;
        //计算X
        CGFloat cellX = margin+(margin+cellW)*col;
        
        //结算Y
        //计算Y需要知道上一个item的y值所以我们用字典保存上一个item的Y值
        
        //首先我们先取出默认的第一个y值 根据key来取值
        NSString *key = [NSString stringWithFormat:@"%d",col];
        CGFloat cellY = [self.dictY[key] intValue];
        
        //把下一次要用的Y值存储到字典中 方便下一次取出
        self.dictY[key]=@(cellY+cellH+margin);
        
        eachLayout.frame = CGRectMake(cellX, cellY, cellW, cellH);
        
        
        [self.allLayouts addObject:eachLayout];
     
    }
#warning 循环以后为footView设置一个布局对象
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    
    UICollectionViewLayoutAttributes *footLayout = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter withIndexPath:indexPath];
    
    //获取最大的Y值
    CGFloat maxY=0;
    for (int i =0; i<self.colNum; i++) {
        NSString *key = [NSString stringWithFormat:@"%d",i];
        int lastY = [self.dictY[key] intValue];
        if (maxY<lastY) {
            maxY = lastY;
        }
    }
    
    footLayout.frame = CGRectMake(0, maxY, [UIScreen mainScreen].bounds.size.width, 50);
    //添加到布局对象*******重要的一步  为下面计算contentSize做准备
    [self.allLayouts addObject:footLayout];
}

#pragma mark 重写方法二
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    //把所有的布局对象（设置frame的）返回给这个数组
    return self.allLayouts;
}
#pragma mark 重写方法三设置contentView的contentSize
-(CGSize)collectionViewContentSize{
    
    CGSize oldSize = [super collectionViewContentSize];
    
    int maxY = 0;
    
    for (int i =0; i<self.colNum; i++) {
        NSString *key = [NSString stringWithFormat:@"%d",i];
        int lastY = [self.dictY[key] intValue];
        if (maxY<lastY) {
            maxY = lastY;
        }
        
    }
    
    CGSize contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, maxY+50+10);
    
    return contentSize;
    

}
#pragma mark
-(NSMutableArray *)allLayouts{
    if (_allLayouts == nil) {
        
        _allLayouts = [NSMutableArray array];
    }
    
    return _allLayouts;
}

#pragma mark
-(NSMutableDictionary *)dictY{
    
    if (_dictY == nil) {
        _dictY = [NSMutableDictionary dictionary];
        
        for (int i =0; i<self.colNum; i++) {
            NSString *key = [NSString stringWithFormat:@"%d",i];
            
            //一个默认的margin(这个字典用来保存上一个item的Y值)
            NSDictionary *dict = @{key:@10};
            
            [_dictY addEntriesFromDictionary:dict];
            
        }
    }
    
    return _dictY;
    
}

@end
