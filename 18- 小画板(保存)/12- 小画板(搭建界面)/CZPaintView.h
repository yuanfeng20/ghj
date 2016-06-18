//
//  CZPaintView.h
//  12- 小画板(搭建界面)
//
//  Created by apple on 16/2/27.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CZPaintView : UIView

//接收 slider的值
@property(nonatomic,assign)CGFloat lineWith;

//接收颜色
@property(nonatomic,strong)UIColor *lineColor;


//清屏
- (void)clear;

//回退
- (void)back;

//橡皮擦
- (void)eraser;

@end
