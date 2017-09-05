//
//  DGDanMuView.m
//  15 酷炫弹幕
//
//  Created by MAC on 2017/8/7.
//  Copyright © 2017年 GuoDongge. All rights reserved.
//

#import "DGDanMuView.h"
#import "DGImage.h"

@interface DGDanMuView()

/**
 图片数组
 */
@property(nonatomic,strong)NSMutableArray * imageArr;

/**定时器*/
@property(nonatomic,strong)CADisplayLink * link;

/**即将删除的图片数组*/
@property(nonatomic,strong)NSMutableArray * deleImageArr;

@end
@implementation DGDanMuView

-(void)addImages:(DGImage*)image
{
    //将图片加入的数组中
    [self.imageArr addObject:image];
    
    [self addTimer];
    
}

- (void)drawRect:(CGRect)rect {
    
   //当图片数组中没有图片是就销毁定时器
if (self.imageArr.count == 0) {
        [self.link invalidate];
            self.link = nil;
        return;
}

    
    NSLog(@"%s",__func__);
     //从图片数组中不断读取图片
    for (DGImage * image in self.imageArr) {
        
        //让图片的x值不断变小，在水平方向就会向左飘去
        image.x -= 3;
        
        //绘制图片，如果定时器不停止这里就会不断绘制
         [image drawAtPoint:CGPointMake(image.x, image.y)];
        
        //当图片的最右侧飘离屏幕时，就把这张图片添加到即将删除的数组中
        if (image.x + image.size.width < 0) {
            
            [self.deleImageArr addObject:image];
            
        }
        
        
        
}

    //因为不能一边遍历数组一边从这个数组中删除元素，所以只能从deleImageArr中遍历出这个图片然后从imageArr中删除
    for (DGImage * image in self.deleImageArr) {
        
        [self.imageArr removeObject:image];
        
    }

    [self.deleImageArr removeAllObjects];
    

    
}


#pragma mark - 添加定时器
-(void)addTimer
{
    if (self.link) return;
    
    CADisplayLink * link = [CADisplayLink displayLinkWithTarget:self selector:@selector(setNeedsDisplay)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes ];
    
    self.link = link;
    
}

#pragma mark - 懒加载图片数组
-(NSMutableArray*)imageArr
{
    
    if (_imageArr == nil) {
        _imageArr = [NSMutableArray array];
    }
    return _imageArr;
}

-(NSMutableArray*)deleImageArr
{
    
    if (_deleImageArr == nil) {
        _deleImageArr = [NSMutableArray array];
    }
    return _deleImageArr;
}


@end
