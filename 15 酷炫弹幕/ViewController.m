//
//  ViewController.m
//  15 酷炫弹幕
//
//  Created by MAC on 2017/8/7.
//  Copyright © 2017年 GuoDongge. All rights reserved.
//

#import "ViewController.h"
#import "DGDanMuView.h"
#import "DGImage.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet DGDanMuView *danMuView;


@end

@implementation ViewController


//点击一下屏幕将飘出一条弹幕
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
     NSString * filePath = [[NSBundle mainBundle]pathForResource:@"弹幕图片01.png" ofType:nil];
    DGImage * image = [[DGImage alloc]initWithContentsOfFile:filePath];
    //设置图片从屏幕最右侧飘出
    image.x = self.view.bounds.size.width;
    //设置图片飘出时不会出现在DGDanMuView之外
    image.y = arc4random_uniform(250 - image.size.height);
    //将这张图片加入到DGDanMuView中
    [self.danMuView addImages:image];
    
}


@end
