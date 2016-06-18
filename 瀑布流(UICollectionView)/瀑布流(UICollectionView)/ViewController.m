//
//  ViewController.m
//  瀑布流(UICollectionView)
//
//  Created by krisfeng on 16/2/3.
//  Copyright © 2016年 krisfeng. All rights reserved.
//

#import "ViewController.h"
#import "YFGirlsModel.h"
#import "YFGirlCell.h"
#import "YFMylayout.h"
@interface ViewController ()

@property(strong,nonatomic)NSMutableArray *girls;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //通过布局对象来设置item(cell)
    //获取布局对象
    //由于布局系统提供的布局对象不能满足瀑布流的 所以我们定义一个类继承布局对象的父类实现一些自己的逻辑
//    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    YFMylayout *myLayout = (YFMylayout *)self.collectionView.collectionViewLayout;
    //为布局对象传入两个参数 一个数据模型  一个列数
    myLayout.girls = self.girls;
    
    myLayout.colNum = 2;
    
}

#pragma mark 懒加载数据
-(NSMutableArray *)girls{
    if (_girls == nil) {
        
       NSArray *arrD = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"1.plist" ofType:nil]];
        
        NSMutableArray *arrM = [NSMutableArray array];
        
        for (NSDictionary *dict in arrD) {
            
            YFGirlsModel *girlModel = [YFGirlsModel girlsWithDict:dict];
            [arrM addObject:girlModel];
        }
        
        _girls = arrM;
        
        
    }
    return _girls;
}
#pragma mark 加载数据时调用的方法

-(void)loadMoreData{
    
    //随机数
    int randomNum = arc4random_uniform(3)+1;
    NSString *plistName = [NSString stringWithFormat:@"%d.plist",randomNum];
    
    NSArray *arrD = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:plistName ofType:nil]];
    
    NSMutableArray *arrM = [NSMutableArray array];
    
    for (NSDictionary *dict in arrD) {
        
        YFGirlsModel *girlModel = [YFGirlsModel girlsWithDict:dict];
        [arrM addObject:girlModel];
    }

    //把数据添加到数组当中去
    [self.girls addObjectsFromArray:arrM];
}
#pragma mark 实现数据源方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.girls.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *key = @"girl";
    
    YFGirlCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:key forIndexPath:indexPath];
    
    YFGirlsModel *girlModel = self.girls[indexPath.item];
    
    cell.girlModel = girlModel;
    
    return cell;
    
}
#pragma mark 创建底部视图
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *key = @"foot";
    
    
    UICollectionReusableView *footView =[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:key forIndexPath:indexPath];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self loadMoreData];
        
        //获取到布局对象
        YFMylayout *myLayout = (YFMylayout *)self.collectionView.collectionViewLayout;
        
        myLayout.girls = self.girls;
        
        [self.collectionView reloadData];
        
        
    });
    
    return footView;
    
    
}
@end
