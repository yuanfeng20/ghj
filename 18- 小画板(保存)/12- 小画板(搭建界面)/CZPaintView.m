//
//  CZPaintView.m
//  12- 小画板(搭建界面)
//
//  Created by apple on 16/2/27.
//  Copyright © 2016年 itcast. All rights reserved.
//

//1.获取触摸对象
//2.获取触摸点的位置
//3.创建路径
//4.设置起点
//5.重绘

#import "CZPaintView.h"
#import "CZBezierPath.h"

@interface CZPaintView ()


//多线的集合
@property(nonatomic,strong)NSMutableArray *pathsArray;

@end

@implementation CZPaintView


//清屏: 清空所有的路径 重绘
- (void)clear
{
    //1.清空所有的路径
    [self.pathsArray removeAllObjects];
    
    //2.重绘
    [self setNeedsDisplay];

}

//回退: 删除集合中最后一个路径 重绘
- (void)back
{
    //1. 删除集合中最后一个路径
    [self.pathsArray removeLastObject];
    
    //2.重绘
    [self setNeedsDisplay];

}

//橡皮擦:
- (void)eraser
{
//    //1. 创建一个路径 路径的颜色 和背景色一样 重绘
//    CZBezierPath *path = [CZBezierPath bezierPath];
//    //起点 和 终点 都是零
//    self.lineColor = self.backgroundColor;
//    
//    [self.pathsArray addObject:path];
//    
//    [self setNeedsDisplay];
    
    
//    //2.设置 当前的路径的颜色 和 画板的背景色 是一样的
    
    self.lineColor = self.backgroundColor;
    
    //2. 重绘
    [self setNeedsDisplay];

}











#pragma mark -  设置颜色
//监听按钮 获取按钮的颜色
//把颜色 给画板传过去PaintView 的属性 lineColor
// 在渲染的时候 设置颜色

#pragma mark -  设置线宽
//监听slider 的值得改变
//将slider 的值 赋值给 PaintView 的属性 linewith
//统一设置线宽（绘制状态）
//单独设置线宽
//设置线条的默认宽度

- (NSMutableArray *)pathsArray
{
    if (!_pathsArray) {
        
        _pathsArray = [NSMutableArray array];
    }

    return _pathsArray;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //1.获取触摸对象
    UITouch *touch = touches.anyObject;
    
    //2.获取触摸点的位置
    CGPoint loc = [touch locationInView:touch.view];
    
    //3.创建路径
    CZBezierPath *path = [CZBezierPath bezierPath];
    
    //单独设置每个路径的线宽
    path.lineWidth = self.lineWith;
    
    //单独设置每个路径的颜色
    path.linePathColor = self.lineColor;
    
    [path moveToPoint:loc];
    
    [self.pathsArray addObject:path];
    


}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //1.获取触摸对象
    UITouch *touch = touches.anyObject;
    
    //2.获取触摸点的位置
    CGPoint loc = [touch locationInView:touch.view];
    
    //3.添加线:取出最后的路径
    [[self.pathsArray lastObject] addLineToPoint:loc];
    
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
   
  
    //循环遍历 渲染
    for(CZBezierPath *path in self.pathsArray){
        
        //统一设置线宽
//        path.lineWidth = self.lineWith;
        
        //统一设置 颜色
//        [self.lineColor set];
        [path.linePathColor set];
    
        [path stroke];
    }
}


@end
