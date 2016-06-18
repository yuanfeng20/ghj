//
//  ViewController.m
//  12- 小画板(搭建界面)
//
//  Created by apple on 16/2/27.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "ViewController.h"
#import "CZPaintView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet CZPaintView *myPaintView;
@property (weak, nonatomic) IBOutlet UISlider *mySlider;

@property (weak, nonatomic) IBOutlet UIButton *btnRed;
@end

@implementation ViewController


//保存 需要截取屏幕
- (IBAction)save:(UIBarButtonItem *)sender {
    
    //1.开启图片上下文
    UIGraphicsBeginImageContextWithOptions(self.myPaintView.bounds.size, NO, 0.0);
    
    //2.获取当前上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //3.渲染
    [self.myPaintView.layer renderInContext:ctx];
    
    //4.获取图片
    UIImage *photoImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //5. 关闭上下文
    UIGraphicsEndImageContext();
    
    
    //6.保存到相册
    UIImageWriteToSavedPhotosAlbum(photoImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"操作提示" message:@"保存成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    [alert show];


}

//清屏
- (IBAction)clear:(UIBarButtonItem *)sender {
    
    [self.myPaintView clear];
}

//回退
- (IBAction)back:(UIBarButtonItem *)sender {
    [self.myPaintView back];
}

//橡皮擦
- (IBAction)eraser:(UIBarButtonItem *)sender {
    [self.myPaintView eraser];
}







//监听获取按钮的颜色
- (IBAction)colorAction:(UIButton *)sender {
    
    self.myPaintView.lineColor = sender.backgroundColor;
}
//监听 slider的变化
- (IBAction)sliderValueChange:(UISlider *)sender {
    
    //将变化值 传给画板
    self.myPaintView.lineWith = sender.value;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置默认的线宽
    self.myPaintView.lineWith = self.mySlider.value;
    
    //设置默认的颜色
    self.myPaintView.lineColor = self.btnRed.backgroundColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
